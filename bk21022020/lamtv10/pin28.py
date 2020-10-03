# yum install python-sqlalchemy
import sqlalchemy as db
import sys
import json

host_name= 'SPGM01DRCTRL01'
engine = db.create_engine('mysql://nova:tDYYivjrHo749yokhU7utc2GLlJezi14@10.255.26.60:3306/nova')
connection = engine.connect()
metadata = db.MetaData()
nova_compute_nodes = db.Table('compute_nodes', metadata, autoload=True, autoload_with=engine)
#select hypervisor_hostname from compute_nodes;


list_host= connection.execute(db.select([nova_compute_nodes.columns.hypervisor_hostname]).where(nova_compute_nodes.columns.deleted=='0')).fetchall()[:]
print(list_host[0][0])




compute_cell= json.loads(connection.execute(db.select([nova_compute_nodes.columns.numa_topology]).where(nova_compute_nodes.columns.hypervisor_hostname=='SPGM01DRCOmP28')).fetchall()[0][0])
print (compute_cell["nova_object.data"]["cells"][0]["nova_object.data"]["pinned_cpus"])
print (compute_cell["nova_object.data"]["cells"][1]["nova_object.data"]["pinned_cpus"])

