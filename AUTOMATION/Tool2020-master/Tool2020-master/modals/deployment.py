from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *
class Deployment(Node_Base):
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
    service_setups = relationship("Service_setup", back_populates="deployment")
    node=relationship("Node", uselist=False, back_populates="deployment")
    def __repr__(self):
        return "<Deployment(deployment_id='%s',created_at='%s',updated_at='%s',finished_at='%s',status='%s',name='%s',jsondata='%s',log='%s',result='%s',progress='%s')>" %(self.deployment_id,self.created_at,self.updated_at,self.finished_at,self.status,self.name,self.jsondata,self.log,self.result,self.progress) 