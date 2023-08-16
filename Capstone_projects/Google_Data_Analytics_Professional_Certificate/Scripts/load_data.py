import os
import pandas as pd


def load_data():
    folder_path = os.path.join(os.getcwd(),'Google project/data')
    csv_files = {}
        
    try:
        file_list = list(os.listdir(folder_path))
        csv_files = {
            file : pd.read_csv(os.path.join(folder_path,file))
            for file in file_list
            for file in file_list
            if file.endswith('.csv')
        }
        
    
    except OSError as e:
        print(f'Error {e}')
        return None
    
    print("______________________Documents loaded________________________")
    return csv_files