from flask import Flask
from config import Config
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from datetime import datetime
app = Flask(__name__)
app.config.from_object(Config)
db = SQLAlchemy(app)
session=db.session
Node_Base=db.Model
Column = db.Column
relationship=db.relationship
import uuid
def generate_uuid():
    return str(uuid.uuid4())
migrate = Migrate(app, db)

from sql_alchemy_learn import routes, models


print("I'm here")
def test_add_nodes_b1():
    print("sdfsdfs")


    #node1 = Node(created_at=datetime.now(), updated_at=datetime.now(), deleted_at=None, management_ip="172.16.29.193", ssh_user="root", ssh_password="123456@Epc", status="set_ip", node_display_name="controller_01")
    node2= models.Node(created_at=datetime.now(), updated_at=datetime.now(), deleted_at=None, management_ip="172.16.29.194", ssh_user="root", ssh_password="123456@Epc", status="set_ip", node_display_name="controller_02")
    node3= models.Node(created_at=datetime.now(), updated_at=datetime.now(), deleted_at=None, management_ip="172.16.29.195", ssh_user="root", ssh_password="123456@Epc", status="set_ip", node_display_name="controller_03")


    #node_info  = Node_info(node_name="tovanlam1", memory_mb=123)
    #session.add(node1)
    session.add(node2)
    session.add(node3)


    session.commit()


if __name__ == "__main__":
    test_add_nodes_b1()

