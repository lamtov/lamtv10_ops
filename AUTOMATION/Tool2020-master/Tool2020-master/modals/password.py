from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *


class Password(Node_Base):
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