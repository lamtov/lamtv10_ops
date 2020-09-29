from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *
class Node_role(Node_Base):
    __tablename__ = 'node_roles'
    id = Column(Integer,primary_key=True, autoincrement=True)
    role_name=Column(String(255))
    node_id= Column(Integer, ForeignKey('nodes.node_id'))
    node = relationship("Node")
    def __repr__(self):
        return "<Node_role(role_name='%s',node_id='%s')>" %(self.role_name,self.node_id) 
