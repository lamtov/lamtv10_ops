from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime
from sqlalchemy.orm import relationship, sessionmaker
import sys
sys.path.insert(0,'../')

from utils import *

class Update_change(Node_Base):
    __tablename__ = 'update_change'
    id = Column(Integer,primary_key=True, autoincrement=True)
    update_id=Column(String(255), ForeignKey('updates.update_id'))
    change_id= Column(String(255), ForeignKey('changes.change_id'))
    def __repr__(self):
        return "<Update_change(update_id='%s',change_id='%s')>" %(self.update_id,self.change_id) 

