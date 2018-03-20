#http://airflow.readthedocs.org/en/latest/tutorial.html
import airflow
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': airflow.utils.dates.days_ago(1),
    'email': ['ant@gmail.com'],
    'email_on_failure': True,
    'email_on_retry': True,
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'atmosphere',
    default_args=default_args,
    schedule_interval='0 3 * * *')

t1 = BashOperator(
    task_id='godlovesugly',
    bash_command='python /home/ant/atmosphere/godlovesugly.py',
    dag=dag)