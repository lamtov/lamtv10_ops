from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *

class Node(Node_Base):
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
    service_infos=relationship("Service_info", back_populates="node")
    node_roles = relationship("Node_role", back_populates="node")

    def __repr__(self):
        return "<Node(node_id='%s',created_at='%s',updated_at='%s',deleted_at='%s',management_ip='%s',ssh_user='%s',ssh_password='%s',status='%s',node_display_name='%s',node_info_id='%s',deployment_id='%s',node_type='%s')>" %(self.node_id,self.created_at,self.updated_at,self.deleted_at,self.management_ip,self.ssh_user,self.ssh_password,self.status,self.node_display_name,self.node_info_id,self.deployment_id,self.node_type)



