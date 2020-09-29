from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *
class File_config(Node_Base):
    __tablename__ = 'file_configs'
    file_id = Column(Integer,primary_key=True, autoincrement=True)
    node_id=Column(Integer, ForeignKey('nodes.node_id'))
    file_name= Column(String(255))
    file_path=Column(String(255))
    service_name=Column(String(255))
    created_at=Column(DateTime)
    modified_at=Column(DateTime)
    
    service_infos = relationship('Service_info',secondary='service_info_file_config')
    node = relationship('Node')
    openstack_configs = relationship("Openstack_config", back_populates="file_config")


    def __repr__(self):
        return "<File_config(file_id='%s',node_id='%s',file_name='%s',file_path='%s',service_name='%s',created_at='%s',modified_at='%s')>" %(self.file_id,self.node_id,self.file_name,self.file_path,self.service_name,self.created_at,self.modified_at) 

