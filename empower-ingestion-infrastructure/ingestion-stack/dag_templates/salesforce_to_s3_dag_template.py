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
            job_name='EMP_Incremental_Ingestion_Job_SF_API_To_S3',
            job_desc="triggering glue job IngestionJob",
            region_name='ap-south-1',
            s3_bucket = 'empower-foundation-artifact-bucket',
            concurrent_run_limit = 200,
            create_job_kwargs={"GlueVersion": "3.0","NumberOfWorkers": 1, "WorkerType": "G.1X","Timeout":1800}, #,"Connections": {"Connections": ["internet-access"]}},
            # create_job_kwargs={"GlueVersion": "3.0","NumberOfWorkers": 2, "WorkerType": "G.1X","Timeout":180,"Connections": {"Connections": ["sample-ingestion-postgres-connector"]}},

            iam_role_name = 'glue-rds-access',
            # iam_role_name = 'glue-redshift-access',
            script_location='s3://empower-ingestion-rnd/Job-new/salesforce_to_s3/Main.py',
            script_args={
                        # "--extra-jars": "s3://empower-foundation-artifact-bucket/glue-artifacts/dependent-jars/hudi-spark3.3-bundle_2.12-0.12.0.jar,s3://empower-foundation-artifact-bucket/glue-artifacts/dependent-jars/spark-avro_2.12-3.0.1.jar,s3://empower-foundation-artifact-bucket/glue-artifacts/dependent-jars/calcite-core-1.33.0.jar,s3://empower-ingestion-rnd/drivers/postgresql-9.2-1003-jdbc4.jar",
                        #  "--conf": "spark.serializer=org.apache.spark.serializer.KryoSerializer --conf spark.sql.hive.convertMetastoreParquet=false --conf spark.jars.packages=org.apache.hudi:hudi-spark-bundle_2.12:0.7.0,org.apache.spark:spark-avro_2.12:3.0.2",
                         "--jsonparams": jsonparams,
                         "--job-language": "python",
                         "--job-bookmark-option": "job-bookmark-disable",
                         "--enable-metrics": "True",
                         "--enable-continuous-cloudwatch-log": "True",
                         "--enable-spark-ui": "True",
                         "--enable-glue-datacatalog": "True",
                         "--enable-job-insights": "True",
                         "--extra-py-files": "s3://empower-ingestion-rnd/Job-new/salesforce_to_s3/Empower_Ingestion_Framework.zip",
                         "--extra-files": "s3://empower-ingestion-rnd/Job-new/salesforce_to_s3/Config.properties"},
            trigger_rule='all_success',
        )

        start_ingestion_task >> IncrementalIngestionJob >> end_ingestion_task
