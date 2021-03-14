# Databricks notebook source
#Connect to ADLS
# Connection String Variables
adlsAccountName = "adlsimdbproject"
adlsContainerName = "exportedfiles-imdbproject"
adlsFolderName = "ExportedFiles"
mountPoint = "/mnt/csvFiles"

# Client ID - from Azure Key Vault using Secret Scope
applicationId = dbutils.secrets.get(scope="imdbprojectKeyVault",key="ClientId")

# Application (Client) - - from Azure Key Vault using Secret Scope
authenticationKey = dbutils.secrets.get(scope="imdbprojectKeyVault",key="ClientSecret")

# Directory (Tenant) ID - - from Azure Key Vault using Secret Scope
tenandId = dbutils.secrets.get(scope="imdbprojectKeyVault",key="TenatId")

# Dynamic End Point to ADLS-u
endpoint = "https://login.microsoftonline.com/" + tenandId + "/oauth2/token"
source = "abfss://" + adlsContainerName + "@" + adlsAccountName + ".dfs.core.windows.net/" + adlsFolderName

# Connect using Service Principal secrets and OAuth
configs = {"fs.azure.account.auth.type": "OAuth",
           "fs.azure.account.oauth.provider.type": "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
           "fs.azure.account.oauth2.client.id": applicationId,
           "fs.azure.account.oauth2.client.secret": authenticationKey,
           "fs.azure.account.oauth2.client.endpoint": endpoint}

# Mounting ADLS Storage => DBFS
 
if not any(mount.mountPoint == mountPoint for mount in dbutils.fs.mounts()):
  dbutils.fs.mount(
    source = source,
    mount_point = mountPoint,
    extra_configs = configs)

# COMMAND ----------

# reference import

from pyspark.sql import SQLContext
from pyspark.sql.functions import explode
from pyspark.sql.types import *
from pyspark.sql.functions import col, split, concat_ws
from pyspark.sql import functions as sf
from pyspark import SparkConf, SparkContext
from pyspark.sql import SparkSession

# COMMAND ----------

# Create dataframes from 2 tsv files

dfBasics = spark.read.csv("/mnt/csvFiles/Basics.csv", sep=r'\t', header=True).select('tconst','titleType','primaryTitle','originalTitle','isAdult','startYear','endYear','runtimeMinutes','genres')
dfRatings = spark.read.csv("/mnt/csvFiles/Ratings.csv", sep=r'\t', header=True).select('tconst','averageRating','numVotes')

df = (dfBasics.alias('dfBasics').join(dfRatings.alias('dfRatings'),
                               on = dfBasics['tconst'] == dfRatings['tconst'],
                               how = 'inner')
                         .select('dfBasics.*',
                                 'dfRatings.averageRating')
)


# start transform
df2 = df.withColumn("genres", split(col("genres"), ",").cast("array<string>"))

# explosion in dataset - transform comma separated velues in columns in rows
df3 = df2.withColumn("originalGenres",explode(df2.genres))
df4 = df3.withColumn('webLocation', sf.concat(sf.lit('https://www.imdb.com/title'),sf.lit('/'), sf.col('tconst')))
df4.show()

# COMMAND ----------

#Load Back to Azure SQL Database


userName = dbutils.secrets.get(scope="imdbprojectKeyVault",key="userName")
passWord = dbutils.secrets.get(scope="imdbprojectKeyVault",key="passWord")
jdbcUrl = dbutils.secrets.get(scope="imdbprojectKeyVault",key="jdbcUrl")

# "jdbc:sqlserver://imdbdatabaseserver.database.windows.net:1433;database=IMdbDataBase"

# return array in column data type 
df4.withColumn('genres', concat_ws(',', 'genres')).write \
    .format("jdbc") \
    .mode("overwrite") \
    .option("url", jdbcUrl ) \
    .option("dbtable", "dbo.RatedMovies") \
    .option("user", userName) \
    .option("password", passWord) \
    .save()





# COMMAND ----------

# Unmount 
if any(mount.mountPoint == mountPoint for mount in dbutils.fs.mounts()):
  dbutils.fs.unmount(mountPoint)
