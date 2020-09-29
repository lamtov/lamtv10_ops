from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *
class Change(Node_Base):
    __tablename__ = 'changes'
    change_id=Column(String(255),primary_key=True,default=generate_uuid)
    created_at=Column(DateTime)
    finished_at=Column(DateTime)
    status=Column(String(255))
    change_type=Column(String(255))
    new_service=Column(String(255))
    backup_service=Column(String(255))
    new_file=Column(Text)
    backup_file=Column(Text)
    new_folder=Column(Text)
    backup_folder=Column(Text)
    change_log=Column(Text)
    task_id=Column(Integer, ForeignKey('tasks.task_id'))
    change_index=Column(Integer)
    file_config_id=Column(String(255), ForeignKey('file_configs.file_id'))
    file_config_file_id=Column(Integer)

    task = relationship("Task")
    file_config = relationship("File_config")
    update=relationship("Update", secondary='update_change')
    def __repr__(self):
        return "<Change(change_id='%s',created_at='%s',finished_at='%s',status='%s',change_type='%s',new_service='%s',backup_service='%s',new_file='%s',backup_file='%s',new_folder='%s',backup_folder='%s',change_log='%s',task_id='%s',change_index='%s',file_config_id='%s',file_config_file_id='%s')>" %(self.change_id,self.created_at,self.finished_at,self.status,self.change_type,self.new_service,self.backup_service,self.new_file,self.backup_file,self.new_folder,self.backup_folder,self.change_log,self.task_id,self.change_index,self.file_config_id,self.file_config_file_id) 



