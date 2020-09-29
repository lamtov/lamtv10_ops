from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker

import sqlalchemy as db 
import json
from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base()


import uuid
from uuid import uuid4
from sqlalchemy.dialects.mysql import BINARY
from sqlalchemy.types import TypeDecorator

class BinaryUUID(TypeDecorator):

    
    impl = BINARY(16)
    
    def process_bind_param(self, value, dialect):
        try:
            return value.bytes
        except AttributeError:
            try:
                return uuid.UUID(value).bytes
            except TypeError:
                return value
                
    def process_result_value(self, value, dialect):
        return uuid.UUID(bytes=value)

def generate_uuid():
    return str(uuid.uuid4())

class Node_info(Base):
    __tablename__ = 'node_infos'

    node_info_id = Column(String(255),primary_key=True,default=generate_uuid)
    node_name=Column(String(255))   
    memory_mb = Column(Integer)
    memory_mb_free= Column(Integer)
    numa_topology= Column(Text)
    metrics=Column(Text)
    processor_core=Column(Integer)
    processor_count=Column(Integer)
    processor_threads_per_core=Column(Integer)
    processor_vcpu=Column(Integer)

    os_family=Column(String(255))
    pkg_mgr=Column(String(255))
    os_version=Column(String(255))
    default_ipv4=Column(String(255))
    default_broadcast=Column(String(255))
    default_gateway=Column(String(255))
    default_interface_id=Column(String(255))
    def __repr__(self):
        return "<Node_info(node_info_id='%s',node_name='%s',memory_mb='%s',memory_mb_free='%s',numa_topology='%s',metrics='%s',processor_core='%s',processor_count='%s',processor_threads_per_core='%s',processor_vcpu='%s',os_family='%s',pkg_mgr='%s',os_version='%s',default_ipv4='%s',default_broadcast='%s',default_gateway='%s',default_interface_id='%s')>" %(self.node_info_id,self.node_name,self.memory_mb,self.memory_mb_free,self.numa_topology,self.metrics,self.processor_core,self.processor_count,self.processor_threads_per_core,self.processor_vcpu,self.os_family,self.pkg_mgr,self.os_version,self.default_ipv4,self.default_broadcast,self.default_gateway,self.default_interface_id) 


class Deployment(Base):
    __tablename__ = 'deployments'
    deployment_id = Column(Integer,primary_key=True, autoincrement=True)
    created_at=Column(DateTime)
    updated_at= Column(DateTime)
    finished_at=Column(DateTime)
    status=Column(String(255))
    name=Column(String(255))
    jsondata=Column(Text)
    log=Column(Text)
    result=Column(String(255))
    progress=Column(String(255))
    def __repr__(self):
        return "<Deployment(deployment_id='%s',created_at='%s',updated_at='%s',finished_at='%s',status='%s',name='%s',jsondata='%s',log='%s',result='%s',progress='%s')>" %(self.deployment_id,self.created_at,self.updated_at,self.finished_at,self.status,self.name,self.jsondata,self.log,self.result,self.progress) 


class Node(Base):
    __tablename__ = 'nodes'
    node_id = Column(Integer,primary_key=True, autoincrement=True)
    created_at=Column(DateTime)
    updated_at= Column(DateTime)
    deleted_at=Column(DateTime)
    management_ip=Column(String(255))
    ssh_user=Column(String(255))
    ssh_password=Column(String(255))
    status=Column(Text)
    node_display_name=Column(String(255))
    node_info_id=Column(String(255), ForeignKey('node_infos.node_info_id'))
    deployment_id=Column(Integer, ForeignKey('deployments.deployment_id'))
    node_type=Column(String(255))

    node_info = relationship("Node_info")
    deployment = relationship("Deployment")



    def __repr__(self):
        return "<Node(node_id='%s',created_at='%s',updated_at='%s',deleted_at='%s',management_ip='%s',ssh_user='%s',ssh_password='%s',status='%s',node_display_name='%s',node_info_id='%s',deployment_id='%s',node_type='%s')>" %(self.node_id,self.created_at,self.updated_at,self.deleted_at,self.management_ip,self.ssh_user,self.ssh_password,self.status,self.node_display_name,self.node_info_id,self.deployment_id,self.node_type) 

class Interface_resource(Base):
    __tablename__ = 'interface_resources'
    interface_id = Column(String(255),primary_key=True,default=generate_uuid)
    device_name=Column(String(255))
    speed=Column(Integer) 
    port_info=Column(Text)
    active=Column(String(255))
    features=Column(Text)
    macaddress=Column(String(255))
    module=Column(String(255))
    mtu=Column(Integer)
    pciid=Column(String(255))
    phc_index=Column(Integer)
    type_interface=Column(String(255))
    is_default_ip=Column(String(255))
    node_info_id=Column(String(255),ForeignKey('node_infos.node_info_id') )
    node_info = relationship("Node_info")
    def __repr__(self):
        return "<Interface_resource(interface_id='%s',device_name='%s',speed='%s',port_info='%s',active='%s',features='%s',macaddress='%s',module='%s',mtu='%s',pciid='%s',phc_index='%s',type_interface='%s',is_default_ip='%s',node_info_id='%s')>" %(self.interface_id,self.device_name,self.speed,self.port_info,self.active,self.features,self.macaddress,self.module,self.mtu,self.pciid,self.phc_index,self.type_interface,self.is_default_ip,self.node_info_id) 




class Service_setup(Base):
    __tablename__ = 'service_setups'
    service_setup_id = Column(String(255),primary_key=True,default=generate_uuid)
    service_type=Column(String(255))
    service_name= Column(String(255))
    service_info=Column(Text)
    service_lib=Column(Text)
    service_config_folder=Column(Text)
    setup_index=Column(Integer)
    is_validated_success=Column(String(255))
    validated_status=Column(String(255))
    deployment_id=Column(Integer , ForeignKey('deployments.deployment_id'))
    deployment = relationship("Deployment")
    def __repr__(self):
        return "<Service_setup(service_setup_id='%s',service_type='%s',service_name='%s',service_info='%s',service_lib='%s',service_config_folder='%s',setup_index='%s',is_validated_success='%s',validated_status='%s',deployment_id='%s')>" %(self.service_setup_id,self.service_type,self.service_name,self.service_info,self.service_lib,self.service_config_folder,self.setup_index,self.is_validated_success,self.validated_status,self.deployment_id) 


class Task(Base):
    __tablename__ = 'tasks'
    task_id = Column(Integer,primary_key=True, autoincrement=True)
    created_at=Column(DateTime)
    finished_at= Column(DateTime)
    task_display_name=Column(String(255))
    setup_data=Column(String(255))
    task_type=Column(String(255))
    status=Column(String(255))
    result=Column(String(255))
    log=Column(Text)
    task_index=Column(Integer)
    service_setup_id=Column(String(255), ForeignKey('service_setups.service_setup_id'))
    service_setup = relationship("Service_setup")
    def __repr__(self):
        return "<Task(task_id='%s',created_at='%s',finished_at='%s',task_display_name='%s',setup_data='%s',task_type='%s',status='%s',result='%s',log='%s',task_index='%s',service_setup_id='%s')>" %(self.task_id,self.created_at,self.finished_at,self.task_display_name,self.setup_data,self.task_type,self.status,self.result,self.log,self.task_index,self.service_setup_id) 



class File_config(Base):
    __tablename__ = 'file_configs'
    file_id = Column(Integer,primary_key=True, autoincrement=True)
    node_id=Column(Integer, ForeignKey('nodes.node_id'))
    file_name= Column(String(255))
    file_path=Column(String(255))
    service_name=Column(String(255))
    created_at=Column(DateTime)
    modified_at=Column(DateTime)
    service_info = relationship('Service_info',secondary='service_info_file_config')
    def __repr__(self):
        return "<File_config(file_id='%s',node_id='%s',file_name='%s',file_path='%s',service_name='%s',created_at='%s',modified_at='%s')>" %(self.file_id,self.node_id,self.file_name,self.file_path,self.service_name,self.created_at,self.modified_at) 


class Change(Base):
    __tablename__ = 'changes'
    change_id=Column(String(255),primary_key=True,default=generate_uuid)
    created_at=Column(DateTime)
    finished_at=Column(DateTime)
    status=Column(String(255))
    change_type=Column(String(255))
    new_service=Column(String(255))
    backup_service=Column(String(255))
    new_file=Column(Text)
    backup_file=Column(Text)
    new_folder=Column(Text)
    backup_folder=Column(Text)
    change_log=Column(Text)
    task_id=Column(Integer, ForeignKey('tasks.task_id'))
    change_index=Column(Integer)
    file_config_id=Column(String(255), ForeignKey('file_configs.file_id'))
    file_config_file_id=Column(Integer)

    task = relationship("Task")
    file_config = relationship("File_config")
    update=relationship("Update", secondary='update_change')
    def __repr__(self):
        return "<Change(change_id='%s',created_at='%s',finished_at='%s',status='%s',change_type='%s',new_service='%s',backup_service='%s',new_file='%s',backup_file='%s',new_folder='%s',backup_folder='%s',change_log='%s',task_id='%s',change_index='%s',file_config_id='%s',file_config_file_id='%s')>" %(self.change_id,self.created_at,self.finished_at,self.status,self.change_type,self.new_service,self.backup_service,self.new_file,self.backup_file,self.new_folder,self.backup_folder,self.change_log,self.task_id,self.change_index,self.file_config_id,self.file_config_file_id) 


class Update(Base):
    __tablename__ = 'updates'
    update_id = Column(String(255),primary_key=True,default=generate_uuid)
    created_at=Column(DateTime)
    deleted_at= Column(DateTime)
    note=Column(Text)
    log=Column(Text)

    change=relationship('Update',secondary='update_change')
    def __repr__(self):
        return "<Update(update_id='%s',created_at='%s',deleted_at='%s',note='%s',log='%s')>" %(self.update_id,self.created_at,self.deleted_at,self.note,self.log) 


class Update_change(Base):
    __tablename__ = 'update_change'
    id = Column(Integer,primary_key=True, autoincrement=True)
    update_id=Column(String(255), ForeignKey('updates.update_id'))
    change_id= Column(String(255), ForeignKey('changes.change_id'))
    def __repr__(self):
        return "<Update_change(update_id='%s',change_id='%s')>" %(self.update_id,self.change_id) 






class Password(Base):
    __tablename__ = 'passwords'
    password_id = Column(String(255),primary_key=True,default=generate_uuid)
    created_at=Column(DateTime)
    updated_at= Column(DateTime)
    user=Column(String(255))
    password=Column(String(255))
    update_id=Column(String(255), ForeignKey('updates.update_id'))
    service_name=Column(String(255))

    update = relationship("Update")
    def __repr__(self):
        return "<Password(password_id='%s',created_at='%s',updated_at='%s',user='%s',password='%s',update_id='%s',service_name='%s')>" %(self.password_id,self.created_at,self.updated_at,self.user,self.password,self.update_id,self.service_name) 



class Openstack_config(Base):
    __tablename__ = 'openstack_configs'
    config_id = Column(String(255),primary_key=True,default=generate_uuid)
    created_at=Column(DateTime)
    deleted_at=Column(DateTime)
    key=Column(String(255))
    value=Column(Text)
    service=Column(String(255))
    update_id=Column(String(255), ForeignKey('updates.update_id'))
    password_id=Column(Integer, ForeignKey('passwords.password_id'))
    block=Column(String(255))
    file_id=Column(Integer, ForeignKey('file_configs.file_id'))
    activate=Column(Integer)

    update = relationship("Update")
    password = relationship("Password")

    def __repr__(self):
        return "<Openstack_config(config_id='%s',created_at='%s',deleted_at='%s',key='%s',value='%s',service='%s',update_id='%s',password_id='%s',block='%s',file_id='%s',activate='%s')>" %(self.config_id,self.created_at,self.deleted_at,self.key,self.value,self.service,self.update_id,self.password_id,self.block,self.file_id,self.activate) 




class Disk_resource(Base):
    __tablename__ = 'disk_resources'
    disk_id = Column(String(255),primary_key=True,default=generate_uuid)
    device_name=Column(String(255))
    size= Column(Integer)
    model=Column(String(255))
    removable=Column(Integer)
    sectors=Column(Text)
    sectorsize=Column(Integer)
    serial=Column(String(255))
    vendor=Column(String(255))
    support_discard=Column(String(255))
    virtual=Column(Integer)
    node_info_id=Column(String(255), ForeignKey('node_infos.node_info_id'))

    node_info = relationship("Node_info")
    def __repr__(self):
        return "<Disk_resource(disk_id='%s',device_name='%s',size='%s',model='%s',removable='%s',sectors='%s',sectorsize='%s',serial='%s',vendor='%s',support_discard='%s',virtual='%s',node_info_id='%s')>" %(self.disk_id,self.device_name,self.size,self.model,self.removable,self.sectors,self.sectorsize,self.serial,self.vendor,self.support_discard,self.virtual,self.node_info_id) 



class Service_info(Base):
    __tablename__ = 'service_infos'
    service_id = Column(Integer,primary_key=True, autoincrement=True)
    service_type=Column(String(255))
    service_status=Column(String(255))
    tag=Column(String(255))
    node_id=Column(Integer, ForeignKey('nodes.node_id'))

    node = relationship("Node")
    file_config = relationship("File_config",secondary='service_info_file_config')
   
    def __repr__(self):
        return "<Service_info(service_id='%s',service_type='%s',service_status='%s',tag='%s',node_id='%s')>" %(self.service_id,self.service_type,self.service_status,self.tag,self.node_id) 



class Service_info_File_config(Base):
    __tablename__ = 'service_info_file_config'
    id = Column(Integer,primary_key=True, autoincrement=True)
    service_id=Column(Integer, ForeignKey('service_infos.service_id'))
    file_config_id= Column(Integer, ForeignKey('file_configs.file_id'))


    def __repr__(self):
        return "<Service_info_File_config(service_id='%s',file_config_id='%s')>" %(self.service_id,self.file_config_id) 






class Node_role(Base):
    __tablename__ = 'node_roles'
    id = Column(Integer,primary_key=True, autoincrement=True)
    role_name=Column(String(255))
    node_id= Column(Integer, ForeignKey('nodes.node_id'))
    node = relationship("Node")
    def __repr__(self):
        return "<Node_role(role_name='%s',node_id='%s')>" %(self.role_name,self.node_id) 


CONF = {"database":{"connection":"mysql+pymysql://lamtv10:lamtv10@172.16.29.198/auto_lamtv10"}}
db_engine = db.create_engine(CONF["database"]["connection"])
Base.metadata.create_all(db_engine)
db_connection = db_engine.connect()


#result = db_connection.execute("select * from nodes")
#print(result)

#db_connection.execute(db_nodes.insert(), {"id: "})

Session = sessionmaker()
Session.configure(bind=db_engine) 
session = Session()

#node1 = Node(node_id=11,created_at=datetime(2015, 6, 5, 8, 10, 10, 10),updated_at=datetime(2015, 6, 5, 8, 10, 10, 10),deleted_at=datetime(2015, 6, 5, 8, 10, 10, 10),management_ip="172.16.29.195", ssh_user="root", ssh_password="123456aA@", status="INIT2", node_display_name="test3")

# session.add(node1)
# session.commit()

# for i in range(0,10):
#   movie1 = Movie(title="tovanlam1"+ str(i), release_date=datetime(2015, 6, 5, 8, 10, 10, 10))
#   session.add(movie1)
# session.commit()

def add_data_with_relationship():
    movie1 = Movie(title="tovanlam1", release_date=datetime(2015, 6, 5, 8, 10, 10, 10))
    session.add(movie1)

    actor1 = Actor(name="lamtv" , birthday = datetime(2015, 6, 5, 8, 10, 10, 10))
    actor1.movie.append(movie1)

    session.add(actor1)
    session.commit()
    #+++++>>> can sua lai database theo huong ...

#our_node = session.query(Node).filter_by(node_display_name='test1').first() 
#print(our_node)




#our_node = session.query(Node).filter_by(node_display_name='test1').all()
#for node in our_node:
#   print(node)



# count(): Returns the total number of rows of a query.
# filter(): Filters the query by applying a criteria.
# delete(): Removes from the database the rows matched by a query.
# distinct(): Applies a distinct statement to a query.
# exists(): Adds an exists operator to a subquery.
# first(): Returns the first row in a query.
# get(): Returns the row referenced by the primary key parameter passed as argument.
# join(): Creates a SQL join in a query.
# limit(): Limits the number of rows returned by a query.
# order_by(): Sets an order in the rows returned by a query.

# bourne_identity = Movie(title="The Bourne Identity", release_date=datetime(2002, 10, 11,10, 10, 10))
# furious_7 = Movie(title="Furious 7", release_date=datetime(2015, 4, 2,10, 10, 10))
# pain_and_gain = Movie(title="Pain & Gain", release_date=datetime(2013, 8, 23,10, 10, 10))


# matt_damon = Actor(name="Matt Damon", birthday = datetime(1970, 10, 8, 10, 10, 10))
# dwayne_johnson = Actor(name="Dwayne Johnson", birthday = datetime(1972, 5, 2, 10, 10, 10))
# mark_wahlberg = Actor(name="Mark Wahlberg", birthday = datetime(1971, 6, 5, 10, 10, 10))


# bourne_identity.actors = [matt_damon]
# furious_7.actors = [dwayne_johnson]
# pain_and_gain.actors = [dwayne_johnson, mark_wahlberg]


def test_contact():
    lamtv10=session.query(Actor).filter_by(name='lamtv').first() 
    
    
    matt_contact = Contact(phone_number="415 555 2671", address="Burbank, CA", actor=lamtv10)
    # dwayne_contact = ContactDetails("423 555 5623", "Glendale, CA", dwayne_johnson)
    # dwayne_contact_2 = ContactDetails("421 444 2323", "West Hollywood, CA", dwayne_johnson)
    # mark_contact = ContactDetails("421 333 9428", "Glendale, CA", mark_wahlberg)
    
    
    session.add(matt_contact)
    session.commit()

# del_lamtv10=session.query(Actor).filter_by(name='lamtv').first()

# #session.add(del_lamtv10)

# del_lamtv10.name="lamtv10"

# session.commit()


def test_add_nodes_b1():
    print("sdfsdfs")


    #node1 = Node(created_at=datetime.now(), updated_at=datetime.now(), deleted_at=None, management_ip="172.16.29.193", ssh_user="root", ssh_password="123456@Epc", status="set_ip", node_display_name="controller_01")
    node2= Node(created_at=datetime.now(), updated_at=datetime.now(), deleted_at=None, management_ip="172.16.29.194", ssh_user="root", ssh_password="123456@Epc", status="set_ip", node_display_name="controller_02")
    node3= Node(created_at=datetime.now(), updated_at=datetime.now(), deleted_at=None, management_ip="172.16.29.195", ssh_user="root", ssh_password="123456@Epc", status="set_ip", node_display_name="controller_03")


    node_info  = Node_info(node_name="tovanlam1", memory_mb=123)
    #session.add(node1)
    session.add(node2)
    session.add(node3)


    session.commit()


def test_and_nodes_b2():
    print("lamtv10")
    runner=Runner(None,'ansible_compute.yml',None,None,None,'multinode',None)
    stats = runner.run()
    print_stats(stats)







if __name__=="__main__":
    #test_add_nodes()
    print("lamtv10")

