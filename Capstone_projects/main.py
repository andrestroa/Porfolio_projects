from Scripts.load_data import load_data
from Scripts.mysql_connection import mysql_connection
from Scripts.create_tables import create_tables
from Scripts.upload_data import upload_data
import os


def main():
    os.system('clear')
    csv_files = load_data()
    engine = mysql_connection()
    create_tables(engine,csv_files)




if __name__ == '__main__':
    main()