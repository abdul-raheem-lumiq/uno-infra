from pyspark.sql import SparkSession
from pyspark import SparkContext
import sys
from awsglue.job import Job
from awsglue.utils import getResolvedOptions
from awsglue.context import GlueContext
from com.lumiq.framework.factory.ClassFactory import ClassFactory as cf
from com.lumiq.framework.utils.ConfigUtils import ConfigUtils
from com.lumiq.framework.utils.DFUtils import DFUtils as F
import logging as logs
import json


def main():
    sc = SparkContext()
    glueContext = GlueContext(sc)

    StartTime = F.TimeNow()
    logs.basicConfig()
    logs.getLogger().setLevel(logs.INFO)
    logs.info("::::Job Start Time {}".format(StartTime))

    job = Job(glueContext)
    config = ConfigUtils().getConfig()
    print(config)
    # PropMsg, config = ConfigUtils().getConfig()

    # if PropMsg.strip() != "":
    #     raise RuntimeError(PropMsg)

    AuditCheck = config.get('Framework', 'Framework.audit.enable')

    global args

    OptParam = [x.replace('--', '', 1) for x in sys.argv if '--p_' in x]
    CustomParamList = ['JOB_NAME', 'jsonparams'] + OptParam
    args = getResolvedOptions(sys.argv, CustomParamList)

    json_param = json.loads(args['jsonparams'])
    if json_param['source']['engine'].strip().upper() in ['POSTGRES','MYSQL', 'REDSHIFT', 'ORACLE'] and json_param['destination']['engine'].strip().upper() == 'S3':
        if json_param["sync_type"].strip().upper() in ['FRO','FRA']:
            job_name = 'FullRefreshJob'
        elif json_param["sync_type"].strip().upper() == 'INA':
            job_name = 'IncrementalIngestionJob'


    JOB_NAME = args['JOB_NAME']
    JOB_RUN_ID = args['JOB_RUN_ID']
    args['JobName'] = str(job_name)

    spark = SparkSession.builder.appName(job_name) \
        .config("spark.sql.parquet.writeLegacyFormat", "true") \
        .config('spark.driver.extraJavaOptions', '-Duser.timezone=GMT+5:30') \
        .config('spark.executor.extraJavaOptions', '-Duser.timezone=GMT+5:30') \
        .getOrCreate()

    job.init(args['JOB_NAME'], args)

    logs.info('::::Executing Job {}'.format(str(job_name)))
    logs.info("::::The Glue Job {} is starting with Glue Run Id is {}".format(JOB_NAME, JOB_RUN_ID))
    Job_Instance = cf.getJobClass(spark, glueContext, config, job_name)
    res = Job_Instance.execute(args)
    response = res.split('-', 1)
    if len(response) > 1:
        JobRunState = str(response[0]).strip()
        Msg = str(response[1]).strip()
    else:
        JobRunState = str(response[0]).strip()
        Msg = ""
    logs.info('::::[JOB NAME {job} RESULT: {result}]'.format(job=job_name, result=res))

    if AuditCheck.title() == "True":
        args['JobStartTime'] = StartTime
        args['JobResult'] = str(JobRunState).title()
        args['JobMessage'] = str(Msg)
        AuditMsg = F.AuditLog(spark, config, args)
        if AuditMsg != "":
            raise RuntimeError(AuditMsg)

    if str(JobRunState).upper() != "SUCCESS":
        raise RuntimeError(Msg)
    else:
        logs.info("::::Committing Job BookMark.")
        job.commit()

    logs.info("::::Job {} has Successfully Completed.".format(job_name))


if __name__ == '__main__':
    main()
