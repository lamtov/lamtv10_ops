from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *

class Service_setup(Node_Base):
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
    tasks = relationship("Task", back_populates="service_setup")
    def __repr__(self):
        return "<Service_setup(service_setup_id='%s',service_type='%s',service_name='%s',service_info='%s',service_lib='%s',service_config_folder='%s',setup_index='%s',is_validated_success='%s',validated_status='%s',deployment_id='%s')>" %(self.service_setup_id,self.service_type,self.service_name,self.service_info,self.service_lib,self.service_config_folder,self.setup_index,self.is_validated_success,self.validated_status,self.deployment_id) 


def print_service_setup(node ):
    def sort_function(e):
        return e.setup_index
    service_setups = node.deployment.service_setups

    service_setups.sort(key=sort_function)

    for service_setup in service_setups:
        print(service_setup.service_name + " index: "+ str(service_setup.setup_index))

    return service_setups

def get_service_setup(node ,service_name):
    service_setups = node.deployment.service_setups
