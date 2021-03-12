# Create Databricks Notebooks for data transformation

To access resources secured by an Azure AD tenant , a security principal must represent the entity that requires access. A security principal defines the access policy and permissions for a user or an application in the Azure AD tenant.
To see more details about how to create this please see [this section]().

In order to mount ADLS from Databricks :
1. Create an Azure Key Vault-backed Secret Scope in Azure Databricks
* Go to Databricks url and add #secrets/createScope at the end (new user form is open). Populate user form as folows:

\
\
![storage account](images/DBricksMount/DBricksMount1.png)


2. Mount ADLS to Databricks using Secret Scope
```
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
    extra_configs = configs)```

3. Do the transformation

4. Unmount storage