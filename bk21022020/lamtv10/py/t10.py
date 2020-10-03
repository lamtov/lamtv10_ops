
# yum install python-sqlalchemy
import sqlalchemy as db
import sys


instance_name="ocp01"

#'"select * from instances where display_name="nfv_instance 00 011"'




engine = db.create_engine('mysql://nova:tDYYivjrHo749yokhU7utc2GLlJezi14@10.255.26.100:3306/nova')
connection = engine.connect()
metadata = db.MetaData()




nova_instances=db.Table('instances', metadata, autoload=True, autoload_with=engine)
instances_uuid=connection.execute(db.select([nova_instances.columns.uuid]).where(db.and_(nova_instances.columns.display_name==instance_name , nova_instances.columns.vm_state=="active" ))).fetchall()[0]
print(instances_uuid)
#select numa_topology from instance_extra where instance_uuid="15a468f0-82eb-4cae-bca8-48bddf03e711"
nova_instance_extra=db.Table('instance_extra', metadata, autoload=True, autoload_with=engine)
instance_info=connection.execute(db.select([nova_instance_extra.columns.numa_topology]).where(nova_instances.columns.instance_uuid=="dsdsdadaadada")).fetchall()[0]

instance_cell=instance_info["nova_object.data"]
print(instance_cell)
