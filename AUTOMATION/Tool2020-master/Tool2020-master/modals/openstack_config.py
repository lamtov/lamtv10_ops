from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *

class Openstack_config(Node_Base):
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
    file_config = relationship("File_config")

    def __repr__(self):
        return "<Openstack_config(config_id='%s',created_at='%s',deleted_at='%s',key='%s',value='%s',service='%s',update_id='%s',password_id='%s',block='%s',file_id='%s',activate='%s')>" %(self.config_id,self.created_at,self.deleted_at,self.key,self.value,self.service,self.update_id,self.password_id,self.block,self.file_id,self.activate) 