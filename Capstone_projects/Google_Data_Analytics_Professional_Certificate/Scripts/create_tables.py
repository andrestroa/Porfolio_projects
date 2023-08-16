from sqlalchemy import create_engine, Column,Integer,String,Table,MetaData,Float,Boolean,BigInteger
import pandas as pd
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.exc import OperationalError
import os 

def create_tables(engine,csv_files):

    try:

        Session = sessionmaker(bind = engine)
        session = Session()

        Base = declarative_base()


        for key,value in  csv_files.items():
            metadata = MetaData(bind=engine)
            df = value
            table_name = key.replace('.csv','')
            schema = 'Projects'
            columns = []
            for column_name, dtype in df.dtypes.items():
                if dtype == 'int64':
                    column_type = BigInteger()
                elif dtype == 'float64':
                    column_type = Float()
                elif dtype == 'object':
                    max_length = df[column_name].str.len().max()
                    if max_length is None or max_length == 0:
                        max_length = 50
                    column_type = String(length=max_length)
                elif dtype == 'bool':
                    column_type = Boolean()
                else:
                    column_type = String()

                column = Column(column_name, column_type)
                columns.append(column)
            table = Table(
                table_name,
                metadata,
                schema=schema,
                *columns
            )

            try:
                metadata.create_all(engine)
                session.commit()
                print(f'______________________Table {table_name} created______________________')
            except OperationalError as e:
                print(f"______________________Table {table_name} already exists or an error occurred: {str(e)}______________________")
                session.rollback()  
                continue  
            
            
            try:
                    df.to_sql(table_name, engine, if_exists='append', index=False, schema=schema)
                    print(f'______________________Data loaded into table {table_name}______________________')
            except Exception as e:
                print(f"______________________Error loading data into table {table_name}: {str(e)}______________________")


            
            




        session.close()
        print('______________________Tables created and loaded data________________________')

    except Exception as e:
        print(f'An error ocurred: {str(e)}')