import datetime
from datetime import timedelta
from os import getenv
import json
from airflow import DAG
from airflow.providers.amazon.aws.operators.glue import GlueJobOperator
from airflow.operators.dummy import DummyOperator
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago
from airflow.utils.dates import datetime
from airflow.utils.dates import timedelta
from airflow.models import Variable
from datetime import datetime
import os
import json


DAG_ID = '{$0}' #os.path.basename(__file__).replace(".py", "")

with DAG(
        dag_id=DAG_ID,
        schedule_interval='{$1}',
        is_paused_upon_creation=False,
        default_args={
            'owner': 'airflow',
            'email': ['airflow@example.com'],
            'email_on_failure': False,
            'email_on_retry': False,
        },
        start_date=datetime.strptime('{$2}' , "%Y-%m-%d %H:%M:%S")
) as dag:

    start_ingestion_task = DummyOperator(
        task_id='start_ingestion_task'
    )

    end_ingestion_task = DummyOperator(
        task_id='end_ingestion_task'
    )

    json_config = {$3}

    json_source_target = {k:v for k,v in json_config.items() if k not in ['table_mapping']}

    for table in (table for table in json_config['table_mapping'] if table['enabled']):

        jsonparams = json.dumps(dict(list(table.items()) + list(json_source_target.items())))
        IncrementalIngestionJob = GlueJobOperator(
            task_id="glue_job_step_" + table['source_name'],
            job_name='sftp_to_s3_JOB',
            job_desc="triggering glue job IngestionJob",
            region_name='ap-south-1',
            s3_bucket = 'empower-foundation-artifact-bucket',
            concurrent_run_limit = 200,
            create_job_kwargs={"GlueVersion": "3.0","NumberOfWorkers": 2, "WorkerType": "G.1X","Timeout": 1800 },  #,"Connections": {"Connections": ["ingestion_test"]}},
            # create_job_kwargs={"GlueVersion": "3.0","NumberOfWorkers": 2, "WorkerType": "G.1X","Timeout":180,"Connections": {"Connections": ["sample-ingestion-postgres-connector"]}},

            iam_role_name = 'glue-rds-access',
            # iam_role_name = 'glue-redshift-access',
            script_location='s3://empower-ingestion-rnd/Job-new/sftp_to_s3/Main.py',
            script_args={"--jsonparams":jsonparams,"--job-language":"python","--job-bookmark-option":"job-bookmark-disable","--enable-metrics":"true","--enable-continuous-cloudwatch-log":"true","--enable-spark-ui":"true","--enable-glue-datacatalog":"true","--enable-job-insights":"true","--extra-py-files":"s3://empower-ingestion-rnd/Job-new/sftp_to_s3/Empower_Ingestion_Framework_sftp_to_s3.zip","--extra-files":"s3://empower-ingestion-rnd/Job-new/sftp_to_s3/Config.properties","--additional-python-modules":"s3://empower-ingestion-rnd/python-packages/pysftp-0.2.9-py3-none-any.whl"},
            trigger_rule='all_success'
        )

        start_ingestion_task >> IncrementalIngestionJob >> end_ingestion_task
