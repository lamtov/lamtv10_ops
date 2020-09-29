from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *


class Service_info_File_config(Node_Base):
    __tablename__ = 'service_info_file_config'
    id = Column(Integer,primary_key=True, autoincrement=True)
    service_id=Column(Integer, ForeignKey('service_infos.service_id'))
    file_config_id= Column(Integer, ForeignKey('file_configs.file_id'))


    def __repr__(self):
        return "<Service_info_File_config(service_id='%s',file_config_id='%s')>" %(self.service_id,self.file_config_id) 





