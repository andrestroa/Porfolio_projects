from sqlalchemy import create_engine, Column,Integer,String,Table,MetaData,Float,Boolean
import pandas as pd
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base



def upload_data(engine, csv_files):
    
    Session = sessionmaker(bind = engine)
    session = Session()
    
    Base = declarative_base()
    
    for file in csv_files:
        pd.read_csv(file)
        print(file)
        break