#https://docs.sqlalchemy.org/en/13/core/type_basics.html

# https://auth0.com/blog/sqlalchemy-orm-tutorial-for-python-developers/
from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from datetime import datetime

import sqlalchemy as db 
import json

from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
class Movie(Base):
    __tablename__ = 'movies'
    id = Column(Integer,primary_key=True, autoincrement=True)
    title = Column(String(255))
    release_date = Column(DateTime)
    actor= relationship('Actor',secondary='movie_actor')
    def __repr__(self):
    	return "<Movie(title='%s',release_date='%s')>" %(self.title,self.release_date) 

class Actor(Base):
    __tablename__ = 'actors'
    id = Column(Integer,primary_key=True, autoincrement=True)
    name = Column(String(255))
    birthday = Column(DateTime)
    # stuntman = relationship("Stuntman", uselist=False, back_populates="actors")
    movie = relationship('Movie',secondary='movie_actor')
    def __repr__(self):
    	return "<Actor(name='%s',birthday='%s')>" %(self.name,self.birthday) 

class MovieActor(Base):
    __tablename__ = 'movie_actor'
    id = Column(Integer,primary_key=True, autoincrement=True)
    movies_id = Column(Integer, ForeignKey('movies.id'))
    actors_id = Column(Integer, ForeignKey('actors.id'))
    def __repr__(self):
        return "<MovieActor(movies_id='%s',actors_id='%s')>" %(self.movies_id,self.actors_id) 




class Contact(Base):
    __tablename__ = 'contacts'
    id = Column(Integer,primary_key=True, autoincrement=True)
    phone_number = Column(String(255))
    address = Column(DateTime)
    actors_id = Column(Integer, ForeignKey('actors.id'))
    actor = relationship("Actor")
    def __repr__(self):
    	return "<Contact(phone_number='%s',address='%s', actors_id='%s')>" %(self.phone_number,self.address, self.actors_id) 

# class Stuntman(Base):
#     __tablename__ = 'stuntman'
#     id = Column(Integer,primary_key=True, autoincrement=True)
#     name = Column(String(255))
#     active = Column(Integer)
#     actors_id = Column(Integer, ForeignKey('actors.id'))
#     actor = relationship("Actor",  back_populates="stuntman")
#     def __repr__(self):
#     	return "<Stuntman(name='%s',active='%s',actors_id='%s' )>" %(self.name,self.active, self.actors_id) 



CONF = {"database":{"connection":"mysql+pymysql://lamtv10:lamtv10@172.16.29.198/lamtv10"}}
db_engine = db.create_engine(CONF["database"]["connection"])
Base.metadata.create_all(db_engine)
db_connection = db_engine.connect()


#result = db_connection.execute("select * from nodes")
#print(result)

#db_connection.execute(db_nodes.insert(), {"id: "})

Session = sessionmaker()
Session.configure(bind=db_engine) 
session = Session()

#node1 = Node(node_id=11,created_at=datetime(2015, 6, 5, 8, 10, 10, 10),updated_at=datetime(2015, 6, 5, 8, 10, 10, 10),deleted_at=datetime(2015, 6, 5, 8, 10, 10, 10),management_ip="172.16.29.195", ssh_user="root", ssh_password="123456aA@", status="INIT2", node_display_name="test3")

# session.add(node1)
# session.commit()

# for i in range(0,10):
# 	movie1 = Movie(title="tovanlam1"+ str(i), release_date=datetime(2015, 6, 5, 8, 10, 10, 10))
# 	session.add(movie1)
# session.commit()

def add_data_with_relationship():
    movie1 = Movie(title="tovanlam1", release_date=datetime(2015, 6, 5, 8, 10, 10, 10))
    session.add(movie1)

    actor1 = Actor(name="lamtv" , birthday = datetime(2015, 6, 5, 8, 10, 10, 10))
    actor1.movie.append(movie1)

    session.add(actor1)
    session.commit()
	#+++++>>> can sua lai database theo huong ...

#our_node = session.query(Node).filter_by(node_display_name='test1').first() 
#print(our_node)




#our_node = session.query(Node).filter_by(node_display_name='test1').all()
#for node in our_node:
#	print(node)



# count(): Returns the total number of rows of a query.
# filter(): Filters the query by applying a criteria.
# delete(): Removes from the database the rows matched by a query.
# distinct(): Applies a distinct statement to a query.
# exists(): Adds an exists operator to a subquery.
# first(): Returns the first row in a query.
# get(): Returns the row referenced by the primary key parameter passed as argument.
# join(): Creates a SQL join in a query.
# limit(): Limits the number of rows returned by a query.
# order_by(): Sets an order in the rows returned by a query.

# bourne_identity = Movie(title="The Bourne Identity", release_date=datetime(2002, 10, 11,10, 10, 10))
# furious_7 = Movie(title="Furious 7", release_date=datetime(2015, 4, 2,10, 10, 10))
# pain_and_gain = Movie(title="Pain & Gain", release_date=datetime(2013, 8, 23,10, 10, 10))


# matt_damon = Actor(name="Matt Damon", birthday = datetime(1970, 10, 8, 10, 10, 10))
# dwayne_johnson = Actor(name="Dwayne Johnson", birthday = datetime(1972, 5, 2, 10, 10, 10))
# mark_wahlberg = Actor(name="Mark Wahlberg", birthday = datetime(1971, 6, 5, 10, 10, 10))


# bourne_identity.actors = [matt_damon]
# furious_7.actors = [dwayne_johnson]
# pain_and_gain.actors = [dwayne_johnson, mark_wahlberg]


def test_contact():
    lamtv10=session.query(Actor).filter_by(name='lamtv').first() 
    
    
    matt_contact = Contact(phone_number="415 555 2671", address="Burbank, CA", actor=lamtv10)
    # dwayne_contact = ContactDetails("423 555 5623", "Glendale, CA", dwayne_johnson)
    # dwayne_contact_2 = ContactDetails("421 444 2323", "West Hollywood, CA", dwayne_johnson)
    # mark_contact = ContactDetails("421 333 9428", "Glendale, CA", mark_wahlberg)
    
    
    session.add(matt_contact)
    session.commit()

del_lamtv10=session.query(Actor).filter_by(phone_nu='lamtv').first()



#session.add(del_lamtv10)

del_lamtv10.name="lamtv10"

session.commit()