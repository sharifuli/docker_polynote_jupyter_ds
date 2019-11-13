## Access Spark
### Run PySpark
We can run PySpark by running `pyspark` on the terminal.
```console
root@83ed7c8eb6ac:/opt# pyspark
Python 2.7.15+ (default, Oct  7 2019, 17:39:04)
[GCC 7.4.0] on linux2
... ...
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /__ / .__/\_,_/_/ /_/\_\   version 2.4.4
      /_/

Using Python version 2.7.15+ (default, Oct  7 2019 17:39:04)
SparkSession available as 'spark'.
>>> from pyspark.sql import SparkSession
```
We can also submit any Spark Job using the `spark-submit` command. For this purpose, lets login `bash` and `cd` to the `spark_example`, as shown in the code below.
```console
root@83ed7c8eb6ac:/opt# cd setup_files/spark_example/
root@83ed7c8eb6ac:/opt/setup_files/spark_example# spark-submit --master local[4] SimpleApp.py
19/11/13 19:51:17 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
... ...
19/11/13 19:51:25 INFO DAGScheduler: Job 1 finished: count at NativeMethodAccessorImpl.java:0, took 0.077107 s




Lines with a: 112, lines with b: 69




19/11/13 19:51:25 INFO SparkUI: Stopped Spark web UI at http://83ed7c8eb6ac:4040
... ...
19/11/13 19:51:25 INFO ShutdownHookManager: Deleting directory /tmp/spark-daaa128a-02a7-4885-bdad-37636c14fa2e
root@83ed7c8eb6ac:/opt/setup_files/spark_example#
```
