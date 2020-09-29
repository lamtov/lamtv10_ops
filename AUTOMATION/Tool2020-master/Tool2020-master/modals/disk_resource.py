from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *
class Disk_resource(Node_Base):
    __tablename__ = 'disk_resources'
    disk_id = Column(String(255),primary_key=True,default=generate_uuid)
    device_name=Column(String(255))
    size= Column(Integer)
    model=Column(String(255))
    removable=Column(Integer)
    sectors=Column(Text)
    sectorsize=Column(Integer)
    serial=Column(String(255))
    vendor=Column(String(255))
    support_discard=Column(String(255))
    virtual=Column(Integer)
    node_info_id=Column(String(255), ForeignKey('node_infos.node_info_id'))

    node_info = relationship("Node_info")
    def __repr__(self):
        return "<Disk_resource(disk_id='%s',device_name='%s',size='%s',model='%s',removable='%s',sectors='%s',sectorsize='%s',serial='%s',vendor='%s',support_discard='%s',virtual='%s',node_info_id='%s')>" %(self.disk_id,self.device_name,self.size,self.model,self.removable,self.sectors,self.sectorsize,self.serial,self.vendor,self.support_discard,self.virtual,self.node_info_id) 

