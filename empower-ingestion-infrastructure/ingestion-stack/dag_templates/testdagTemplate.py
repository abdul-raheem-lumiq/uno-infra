from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta

DAG_ID = '{$0}' #os.path.basename(__file__).replace(".py", "")

def hello():
    print("hello world")

with DAG(
        dag_id=DAG_ID,
        is_paused_upon_creation=False,
        schedule_interval='{$1}',
        default_args={
            'owner': 'airflow',
            'email': ['airflow@example.com'],
            'email_on_failure': False,
            'email_on_retry': False,
        },
        start_date=datetime.strptime('{$2}' , "%Y-%m-%d %H:%M:%S")
) as dag:
    start_ingestion_task = PythonOperator(
        task_id='start_ingestion_task',
        python_callable=hello,
        dag=dag
    )
    start_ingestion_task
