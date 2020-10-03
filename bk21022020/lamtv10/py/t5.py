
# yum install python-sqlalchemy
import sqlalchemy as db
import sys


instance_name="ocp01"

#'"select * from instances where display_name="nfv_instance 00 011"'




engine = db.create_engine('mysql://nova:tDYYivjrHo749yokhU7utc2GLlJezi14@10.255.26.100:3306/nova')
connection = engine.connect()
metadata = db.MetaData()




nova_instances=db.Table('instances', metadata, autoload=True, autoload_with=engine)
instances_uuid=connection.execute(db.select([nova_instances.columns.uuid]).where(nova_instances.columns.display_name==instance_name)).fetchall()[:]
print(instances_uuid)
