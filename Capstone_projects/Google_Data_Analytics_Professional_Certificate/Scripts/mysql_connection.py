from sqlalchemy import create_engine, Column,Integer,String,Table,MetaData,Float,Boolean
import pandas as pd
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base


def mysql_connection():


    ####db credentials
    usr = 'admin'
    pwd = 'password'
    host = '127.0.0.1'
    port = 3306
    db_name = 'Projects'
    
    #create engine
    engine = create_engine(
        f"mysql+mysqldb://{usr}:{pwd}@{host}:{port}/{db_name}",
        echo= True,
        future = True
    )
    
    print('______________________Successful connection________________________')
    return engine
    
    
    
    
    
    
    
    
    
    
    