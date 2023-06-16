from pyspark.sql import SparkSession
from pyspark.sql.functions import lit
print("import done")
spark = (
    SparkSession.builder.appName("Hudi_Data_Processing_Framework")
    # .config("spark.serializer", "org.apache.spark.serializer.KryoSerializer")
    # .config("spark.sql.hive.convertMetastoreParquet", "false")
    # .config(
    #     "spark.jars.packages",
    #     "org.apache.hudi:hudi-spark-bundle_2.12:0.7.0,org.apache.spark:spark-avro_2.12:3.0.2"
    # )
    .getOrCreate()
)

# spark = SparkSession.builder.appName(job_name) \
#         .config("spark.sql.parquet.writeLegacyFormat", "true") \
#         .config('spark.driver.extraJavaOptions', '-Duser.timezone=GMT+5:30') \
#         .config('spark.executor.extraJavaOptions', '-Duser.timezone=GMT+5:30') \
#         .getOrCreate()

print("spark session created")

input_df = spark.createDataFrame(
    [
        ("1231001", "2015-02-01 13:51:39.340", "2015-02-01T13:51:39.340396Z"),
        ("1231002", "2015-02-01 13:51:39.340", "2015-02-01T12:14:58.597216Z"),
        ("1231003", "2015-02-01 13:51:39.340", "2015-02-01T13:51:40.417052Z"),
        ("1231004", "2015-02-01 13:51:39.340", "2015-02-01T13:51:40.519832Z"),
        ("1231005", "2015-02-02 13:51:39.340", "2015-02-01T12:15:00.512679Z"),
        ("1231006", "2015-02-02 13:51:39.340", "2015-02-01T13:51:42.248818Z"),
    ],
    ("id", "creation_date", "last_update_time"),
)

print("input df :")
input_df.show()

print("HUDI options :")

# hudi_options={
#   'className': 'org.apache.hudi',
#   'hoodie.datasource.hive_sync.use_jdbc': 'false',
#   'hoodie.datasource.hive_sync.skip_ro_suffix': 'true',
#   'hoodie.consistency.check.enabled': 'true',
#   'hoodie.datasource.write.recordkey.field': 'id',
#   'hoodie.table.name': 'hudi_test',
#   'hoodie.datasource.hive_sync.database': 'new_hudi_test_db',
#   'hoodie.datasource.hive_sync.enable': 'true',
# #   'hoodie.datasource.write.partitionpath.field': '',
#   'hoodie.datasource.write.precombine.field': 'last_update_time',
#   'hoodie.datasource.write.keygenerator.class': 'org.apache.hudi.keygen.ComplexKeyGenerator',
#   'hoodie.datasource.write.operation': 'insert'
# }

# hudi_options = {
#     # ---------------DATA SOURCE WRITE CONFIGS---------------#
#     'className': 'org.apache.hudi',
#     'hoodie.datasource.hive_sync.skip_ro_suffix':'true',
#     'hoodie.datasource.hive_sync.use_jdbc':'false',
#     "hoodie.datasource.hive_sync.database":"new_hudi_test_db",
#     "hoodie.table.name": "hudi_test",
#     "hoodie.datasource.write.recordkey.field": "id",
#     "hoodie.datasource.write.precombine.field": "last_update_time",
#     "hoodie.datasource.write.partitionpath.field": "creation_date",
#     "hoodie.datasource.write.hive_style_partitioning": "true",
#     "hoodie.upsert.shuffle.parallelism": 1,
#     "hoodie.insert.shuffle.parallelism": 1,
#     "hoodie.consistency.check.enabled": True,
#     "hoodie.index.type": "BLOOM",
#     "hoodie.index.bloom.num_entries": 60000,
#     "hoodie.index.bloom.fpp": 0.000000001,
#     "hoodie.cleaner.commits.retained": 2,
#     'hoodie.datasource.hive_sync.enable':'true'
#     # "hoodie.datasource.write.table.type": 'COPY_ON_WRITE'
# }

hudi_options = {
                    # ---------------DATA SOURCE WRITE CONFIGS---------------#
                    'hoodie.datasource.hive_sync.skip_ro_suffix': 'true',  # to remove _ro suffix from files that are written
                    'hoodie.datasource.hive_sync.use_jdbc': 'false',  # true if JDBC destination
                    "hoodie.datasource.hive_sync.database": 'new_hudi_test_db',  # databasename to be written to in glue catalog
                    "hoodie.table.name": "hudi_test",  # table to be created/appended to
                    "hoodie.datasource.write.recordkey.field": "id",  # Value to be used as the recordKey component of HoodieKey
                    "hoodie.datasource.write.precombine.field": "last_update_time",  # if duplicates exist, record against largest value of precombined field is picked
                    "hoodie.datasource.write.partitionpath.field": "",  # partition into folders
                    "hoodie.datasource.write.hive_style_partitioning": "false",  # for <partition_column_name>=<partition_value> format while partitioning
                    "hoodie.upsert.shuffle.parallelism": 1,
                    "hoodie.insert.shuffle.parallelism": 1,
                    "hoodie.consistency.check.enabled": True,  # Enabled to handle S3 eventual consistency issue. This property is no longer required since S3 is now strongly consistent.
                    "hoodie.index.type": "BLOOM",
                    "hoodie.index.bloom.num_entries": 60000,  # number of records in a file
                    "hoodie.index.bloom.fpp": 0.000000001,  # Error rate allowed given the number of entries. Used to calculate how many bits should be assigned for the bloom filter
                    "hoodie.cleaner.commits.retained": 2,  #
                    'hoodie.datasource.hive_sync.enable': 'true',  # register/sync the table to Apache Hive metastore
                    "hoodie.datasource.write.table.type": 'COPY_ON_WRITE',
                    'hoodie.datasource.write.keygenerator.class': 'org.apache.hudi.keygen.ComplexKeyGenerator',
                    'hoodie.datasource.write.operation': 'insert'
                     }
# combinedConf={
#   'className': 'org.apache.hudi',
#   'hoodie.clustering.async.enabled': 'true',
#   'hoodie.clustering.inline': 'false',
#   'hoodie.compact.inline.trigger.strategy': 'NUM_COMMITS',
#   'hoodie.datasource.compaction.async.enable': 'true',
#   'hoodie.compact.inline': 'true',
#   'hoodie.compact.inline.max.delta.commits': '1',
#   'hoodie.datasource.write.table.type': 'MERGE_ON_READ',
#   'hoodie.clean.async': 'true',
#   'hoodie.clean.automatic': 'true',
#   'hoodie.cleaner.policy': 'KEEP_LATEST_COMMITS',
#   'hoodie.cleaner.commits.retained': '1',
#   'hoodie.parquet.small.file.limit': '50',
#   'hoodie.parquet.compression.codec': 'snappy',
#   'hoodie.bloom.index.update.partition.path': 'false',
#   'hoodie.upsert.shuffle.parallelism': '100',
#   'hoodie.datasource.hive_sync.skip_ro_suffix': 'true',
#   'hoodie.parquet.small.file.limit': 50,
#   'hoodie.bloom.index.update.partition.path': 'false',
#   'hoodie.datasource.hive_sync.use_jdbc': 'false',
#   'hoodie.datasource.write.recordkey.field': record_key,
#   'hoodie.table.name': tblname,
#   'hoodie.datasource.hive_sync.database': database,
#   'hoodie.datasource.hive_sync.enable': 'true',
#   'hoodie.datasource.write.precombine.field': precombine_key,
#   'hoodie.datasource.write.partitionpath.field': 'prttn_ky',
#   'hoodie.datasource.write.keygenerator.class': 'org.apache.hudi.keygen.ComplexKeyGenerator',
#   'hoodie.datasource.write.operation': 'upsert',
#   'hoodie.index.type': 'BLOOM'
# }

print("HUDI Insert")
# INSERT
(
    input_df.write.format('org.apache.hudi')
    .options(**hudi_options)
    .mode("append")
    .save("s3://empower-ingestion-rnd/target_folder/hudi-test3/")
)

# # UPDATE
# update_df = input_df.limit(1).withColumn("creation_date", lit("2014-01-01"))
# (
#     update_df.write.format("org.apache.hudi")
#     .options(**hudi_options)
#     .mode("append")
#     .save("/tmp/hudi_test")
# )

# # REAL UPDATE
# update_df = input_df.limit(1).withColumn("last_update_time", lit("2016-01-01T13:51:39.340396Z"))
# (
#     update_df.write.format("org.apache.hudi")
#     .options(**hudi_options)
#     .mode("append")
#     .save("s3://empower-ingestion-rnd/target_folder/hudi-test/")
# )

# output_df = spark.read.format("org.apache.hudi").load(
#     "/tmp/hudi_test/*/*"
# )

# output_df.show()
