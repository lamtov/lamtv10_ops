import argparse
import yaml
import json
import ast
from os import environ as env
from os import rename, path
import traceback
import urlparse
from threading import Thread
import pickle
import requests
from time import sleep, time
from neutronclient.v2_0 import client as neutron_client
# from novaclient.v1_1 import client as nova_client
# http://docs.openstack.org/developer/python-novaclient/api.html
from cinderclient.v2 import client as cinder_client
from novaclient import client as nova_client
from BaseHTTPServer import BaseHTTPRequestHandler
from BaseHTTPServer import HTTPServer
from SocketServer import ForkingMixIn
#from prometheus_client import CollectorRegistry, generate_latest, Gauge, CONTENT_TYPE_LATEST
from netaddr import IPRange

import random
# import swift.common.utils

# from swift.common.ring.ring import Ring

import logging
import logging.handlers
config = None
log = logging.getLogger('poe-logger')


def get_creds_dict(*names):
    """Get dictionary with cred envvars"""
    return {name: env['OS_%s' % name.upper()]
            for name in names if 'OS_%s' % name.upper() in env}


def get_creds_list(*names):
    """Get list with cred envvars, error if not set"""
    return [env['OS_%s' % name.upper()] for name in names]


def maybe_get_cacert():
    """Get cacert, None if unset"""
    return env.get("OS_CACERT")


def get_clients():
    ks_version = int(env.get('OS_IDENTITY_API_VERSION', 2))
    if ks_version == 2:
        from keystoneclient.v2_0 import client as keystone_client
        # Legacy v2 env vars:
        # OS_USERNAME OS_PASSWORD OS_TENANT_NAME OS_AUTH_URL OS_REGION_NAME
        ks_creds = get_creds_dict("username", "password", "tenant_name",
                                  "auth_url", "region_name")
        cacert = maybe_get_cacert()
        if cacert:
            ks_creds["cacert"] = cacert
        nova_creds = [2] + get_creds_list("username", "password", "tenant_name",
                                          "auth_url")
        cinder_creds = get_creds_list("username", "password", "tenant_name",
                                      "auth_url")
        keystone = keystone_client.Client(**ks_creds)
        nova = nova_client.Client(*nova_creds, cacert=cacert)
        neutron = neutron_client.Client(**ks_creds)
        cinder = cinder_client.Client(*cinder_creds, cacert=cacert)

    elif ks_version == 3:
        from keystoneauth1.identity import v3
        from keystoneauth1 import session
        from keystoneclient.v3 import client
        # A little helper for the poor human trying to figure out which env vars
        # are needed, it worked for me (jjo) having:
        #  OS_USERNAME OS_PASSWORD OS_USER_DOMAIN_NAME OS_AUTH_URL
        #  OS_PROJECT_DOMAIN_NAME OS_PROJECT_DOMAIN_ID OS_PROJECT_ID OS_DOMAIN_NAME
        # Keystone needs domain creds for e.g. project list

        # project and project_domain are needed for listing projects
        ks_creds_domain = get_creds_dict(
            "username", "password", "user_domain_name", "auth_url",
            "project_domain_name", "project_name", "project_domain_id", "project_id")
        # Need non-domain creds to get full catalog
        ks_creds_admin = get_creds_dict(
            "username", "password", "user_domain_name", "auth_url",
            "project_domain_name", "project_name", "project_domain_id", "project_id")
        auth_domain = v3.Password(**ks_creds_domain)
        auth_admin = v3.Password(**ks_creds_admin)
        # Need to pass in cacert separately
        verify = maybe_get_cacert()
        if verify is None:
            verify = True
        sess_domain = session.Session(auth=auth_domain, verify=verify)
        sess_admin = session.Session(auth=auth_admin, verify=verify)

        keystone = client.Client(session=sess_domain)
        nova = nova_client.Client(2, session=sess_admin)
        neutron = neutron_client.Client(session=sess_admin)
        cinder = cinder_client.Client(session=sess_admin)

    else:
        raise(ValueError("Invalid OS_IDENTITY_API_VERSION=%s" % ks_version))
    log.debug("Client setup done, keystone ver {}".format(ks_version))
    return (keystone, nova, neutron, cinder)


print(get_clients())