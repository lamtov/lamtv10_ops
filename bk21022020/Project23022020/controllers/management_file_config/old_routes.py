from flask import Blueprint, render_template, abort,  abort, jsonify, request,make_response, redirect
from jinja2 import TemplateNotFound
from app import  db, session, Node_Base, Column, relationship, ansible
from datetime import  datetime
import  models
import os
from sqlalchemy import and_,or_
from assets import *

mod = Blueprint('discovery_node', __name__,
                        template_folder='templates')

@mod.route('/hosts/add_host', methods=['POST'])
def add_host():
    if not request.json :
        abort(400)
    else:
        data = request.json
    old_nodes = session.query(models.Node).filter_by(management_ip=data.get('management_ip')).all()
    if len(old_nodes) != 0:
        return {"status":"Node da ton tai"}

    node = models.Node(created_at=datetime.now(), updated_at=datetime.now(), deleted_at=None, management_ip=data.get('management_ip', ""),ssh_user=data.get('ssh_user',""), ssh_password=data.get('ssh_password',  ""), status="set_ip", node_display_name=data.get('node_display_name', ''))

    session.add(node)
    session.commit()
    new_node = session.query(models.Node).filter_by(node_display_name=str(data.get('node_display_name', ''))).all()
    #print(models.to_json(new_node, 'Node',True))
    return jsonify(models.to_json(new_node, 'Node',True)), 201

@mod.route('/hosts', method=['GET'])
def get_hosts():
    nodes = session.query(models.Node).all()
    #print(models.to_json(nodes, 'Node', True))
    return jsonify(models.to_json(nodes, 'Node', True)), 200

@mod.route('/hosts/<string:host_id>', method=['GET'])
def get_host(host_id):
    if host_id is None:
        return redirect('/api/v1/hosts/all')
    selected_node = session.query(models.Node).filter_by(node_id=str(host_id)).all()
    if len(selected_node) ==0:
        return abort(404)
    else:
        return jsonify(models.to_json(selected_node[0], 'Node', False)), 200

@mod.route('/hosts/discover_hosts', method=['POST']) #################################### ERROR #######################
def discover_hosts():
    inventory_dir = '/home/vttek/lamtv10/etc/ansible/inventory/new_node'
    facts_dir = '/home/vttek/lamtv10/etc/ansible/facts/'
    get_facts(inventory_dir, facts_dir)
    load_node_info_to_database(facts_dir)
    return redirect('/api/v1/hosts/')

@mod.route('/hosts/host_info', method=['GET']) ############################### UNDONE ##################
def get_host_info():
    if request.args.get('host_id') is None:
        return abort(400)
    host_id = request.args.get('host_id')
    nodes = session.query(models.Node).filter_by(node_id=str(host_id)).first()


    #print(nodes.node_info)
    if request.args.fields is None:
        return jsonify(models.to_json(nodes.node_info, 'Node_info',False)), 200
    else:
        result = models.to_json(nodes.node_info, 'Node_info',False)
        return jsonify(result), 200


@mod.route('/hosts/interface_resources', method=['GET'])
def get_interface_resources():
    interface_id = request.args.get('interface_id')
    device_name = request.args.get('device_name')
    host_id = request.args.get('host_id')

    if interface_id is not None:
        interface_resource = session.query(models.Interface_resource).filter_by(interface_id=str(interface_id)).first()
        return jsonify(models.to_json(interface_resource, 'Interface_resource', False)), 200

    if host_id is not None:
        if device_name is not None:
            list_interface_resources=session.query(models.Interface_resource).filter(and_(models.Interface_resource.device_name==str(device_name) , models.Interface_resource.node_info.has(models.Node_info.node.has(models.Node.node_id==host_id)))).all()
            return jsonify(models.to_json(list_interface_resources, 'Interface_resource', True)), 200
        else:
            list_interface_resources = session.query(models.Interface_resource).filter( models.Interface_resource.node_info.has(models.Node_info.node.has(models.Node.node_id==host_id))).all()
            return jsonify(models.to_json(list_interface_resources, 'Interface_resource', True)), 200
    if device_name is not None:
        list_interface_resources = session.query(models.Interface_resource).filter_by(device_name=str(device_name)).all()
        return jsonify(models.to_json(list_interface_resources, 'Interface_resource', True)), 200

    return abort(400)


@mod.route('/hosts/disk_resources', method=['GET'])
def get_disk_resources():
    disk_id = request.args.get('disk_id')
    device_name = request.args.get('device_name')
    host_id = request.args.get('host_id')

    if disk_id is not None:
        disk_resource = session.query(models.Disk_resource).filter_by(disk_id=str(disk_id)).first()
        return jsonify(models.to_json(disk_resource, 'Disk_resource', False)), 200

    if host_id is not None:
        if device_name is not None:
            list_disk_resources=session.query(models.Disk_resource).filter(and_(models.Disk_resource.device_name==str(device_name) , models.Disk_resource.node_info.has(models.Node_info.node.has(models.Node.node_id==host_id)))).all()
            return jsonify(models.to_json(list_disk_resources, 'Disk_resource', True)), 200
        else:
            list_disk_resources = session.query(models.Disk_resource).filter( models.Disk_resource.node_info.has(models.Node_info.node.has(models.Node.node_id==host_id))).all()
            return jsonify(models.to_json(list_disk_resources, 'Disk_resource', True)), 200
    if device_name is not None:
        list_disk_resources = session.query(models.Disk_resource).filter_by(device_name=str(device_name)).all()
        return jsonify(models.to_json(list_disk_resources, 'Disk_resource', True)), 200

    return abort(400)

@mod.route('/hosts/<string:host_id>/historys', method=['GET', 'POST'])
def get_set_host_historys(host_id):
    return abort(400)

@mod.route('/hosts/<string:host_id>/refresh', method=['GET'])
def refresh_host_info(host_id):
    return abort(400)




