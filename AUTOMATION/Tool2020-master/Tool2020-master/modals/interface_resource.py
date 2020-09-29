from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *
class Interface_resource(Node_Base):
    __tablename__ = 'interface_resources'
    interface_id = Column(String(255),primary_key=True,default=generate_uuid)
    device_name=Column(String(255))
    speed=Column(Integer) 
    port_info=Column(Text)
    active=Column(String(255))
    features=Column(Text)
    macaddress=Column(String(255))
    module=Column(String(255))
    mtu=Column(Integer)
    pciid=Column(String(255))
    phc_index=Column(Integer)
    type_interface=Column(String(255))
    is_default_ip=Column(String(255))
    node_info_id=Column(String(255),ForeignKey('node_infos.node_info_id') )
    node_info = relationship("Node_info")
    def __repr__(self):
        return "<Interface_resource(interface_id='%s',device_name='%s',speed='%s',port_info='%s',active='%s',features='%s',macaddress='%s',module='%s',mtu='%s',pciid='%s',phc_index='%s',type_interface='%s',is_default_ip='%s',node_info_id='%s')>" %(self.interface_id,self.device_name,self.speed,self.port_info,self.active,self.features,self.macaddress,self.module,self.mtu,self.pciid,self.phc_index,self.type_interface,self.is_default_ip,self.node_info_id) 

