from airflow import DAG
from datetime import datetime,timedelta
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from airflow.sensors.filesystem import FileSensor
import pandas as pd
from random import randint
from airflow.operators.email import EmailOperator


def _generate_satellite_data(**kwargs):
    initial_timestamp = kwargs['logical_date']
    data = pd.DataFrame({"Astronauts ": ["YURI GAGARIN","JOHN GLENN","NEIL ARMSTRONG00", "BUZZ ALDRIN","JIM LOVELL","SALLY RIDE","CHRISTA MCAULIFFE","MAE JEMISON",
                                      "CHRIS HADFIELD","SCOTT KELLY", "MARK KELLY"]
    })
    numb_astronaut  = len(data)
    time_difference = timedelta(minutes=randint(1,1000))
    timestamps = []
    for Astronaut in range(numb_astronaut):
        new_timestamp = initial_timestamp + (Astronaut * time_difference)
        timestamps.append(new_timestamp)
    data['timestamp'] = timestamps

    data.to_csv(f"/tmp/astronauts_data_{kwargs['ds_nodash']}.csv", header=True, index=False)


with DAG(dag_id="etl_spacex_date",
         description='This DAG is made it for a ETL process for analyse data from Space X',
         start_date=datetime(2023,7,9),
         default_args={"depends_on_past":True}
    ) as dag:

    t1 = BashOperator(task_id='Task_1_Nasa_authorization',
                      bash_command='sleep 20 && echo "OK," > /tmp/response{{ds_nodash}}.txt')

    t2 = FileSensor(task_id='Task_2_verification_nasa',
                      filepath = '/tmp/response{{ds_nodash}}.txt')

    t3 = BashOperator(task_id="Task_3_SpaceX_api_connection",
                      bash_command='curl -o /tmp/spacex_history_{{ds_nodash}}.json -L "https://api.spacexdata.com/v3/history"')

    t4 = PythonOperator(task_id="Task_4_satellite_response_data",
                        python_callable=_generate_satellite_data)

    t5 = BashOperator(task_id = "Task_5_read_satellite_response_data",
                      bash_command='ls /tmp && head /tmp/astronauts_data_{{ds_nodash}}.csv')

    t6 = EmailOperator(task_id='Task_6_notify_data',
                       to= ['marketing@email.com','data@email.com'],
                       subject="Notification Satellite Data",
                       html_content="Hello Marketing and Data team, this email is just for notify that the satellite data is ready and available for use",
                       dag = dag)

    t1 >> t2 >> t3 >> t4 >> t5 >> t6
