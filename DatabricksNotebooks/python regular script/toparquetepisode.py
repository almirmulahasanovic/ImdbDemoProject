# Databricks notebook source
#Poveži se na ADLS
# Varijable za konekcioni string
adlsAccountName = "adlsimdbproject"
adlsContainerName = "exportedfiles-imdbproject"
adlsFolderName = "ExportedFiles"
mountPoint = "/mnt/csvFiles"
base_container = "abfss://" + adlsContainerName + "@" + adlsAccountName + ".dfs.core.windows.net/"

# Client ID - ovo ce pokupiti iz Azure Key Vaulta preko Seccret Scopea
applicationId = dbutils.secrets.get(scope="imdbprojectKeyVault",key="ClientId")

# Application (Client) - ovo ce pokupiti iz Azure Key Vaulta preko Seccret Scopea 
authenticationKey = dbutils.secrets.get(scope="imdbprojectKeyVault",key="ClientSecret")

# Directory (Tenant) ID - ovo ce pokupiti iz Azure Key Vaulta preko Seccret Scopea
tenandId = dbutils.secrets.get(scope="imdbprojectKeyVault",key="TenatId")

# Kreiraj dinamicki end point prema ADLS-u
endpoint = "https://login.microsoftonline.com/" + tenandId + "/oauth2/token"
source = base_container + adlsFolderName

# Konektuj se koristeći Service Principal secrets and OAuth
configs = {"fs.azure.account.auth.type": "OAuth",
           "fs.azure.account.oauth.provider.type": "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
           "fs.azure.account.oauth2.client.id": applicationId,
           "fs.azure.account.oauth2.client.secret": authenticationKey,
           "fs.azure.account.oauth2.client.endpoint": endpoint}

# Mounting ADLS Storage => DBFS
# Prvo porvjeri da li je vec mountiran - ako nije onda izvrsi mounth 
if not any(mount.mountPoint == mountPoint for mount in dbutils.fs.mounts()):
  dbutils.fs.mount(
    source = source,
    mount_point = mountPoint,
    extra_configs = configs)
  
  dbutils.fs.mount(
    source = "abfss://parquet" + "@" + adlsAccountName + ".dfs.core.windows.net/",
    mount_point = "/mnt/parquet",
    extra_configs = configs)

# COMMAND ----------

df_episode = spark.read.csv("/mnt/csvFiles/Episode.csv", sep=r'\t', header=True)

# COMMAND ----------

display(df_episode)
print(df_episode.count())

# COMMAND ----------

from pyspark.sql.functions import *
from pyspark.sql.functions import when, lit, col

def replace(column, value):
    return when(column != value, column).otherwise(lit(None))

df_episode = df_episode.withColumn("seasonNumber", replace(col("seasonNumber"), "\\N"))
df_episode = df_episode.withColumn("episodeNumber", replace(col("episodeNumber"), "\\N"))


# COMMAND ----------

display(df_episode)

# COMMAND ----------

# remove null values
df_episode = df_episode.dropna()
print(df_episode.count())

# COMMAND ----------

df_episode.write.mode("append").parquet("/mnt/parquet/episode")
