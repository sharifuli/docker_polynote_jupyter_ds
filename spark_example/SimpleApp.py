"""SimpleApp.py"""
from pyspark.sql import SparkSession

logFile = "README.md"  # Should be some file on your system
spark = SparkSession.builder.appName("SimpleApp").getOrCreate()
logData = spark.read.text(logFile).cache()

numAs = logData.filter(logData.value.contains('a')).count()
numBs = logData.filter(logData.value.contains('b')).count()

print("\n\n\n\nLines with a: %i, lines with b: %i\n\n\n\n" % (numAs, numBs))

spark.stop()
