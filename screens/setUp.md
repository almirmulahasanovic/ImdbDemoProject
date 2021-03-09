# Set Up Environment

## General overview

Following to project architecture there are several resources we need to create in order to build project.

The first pre-requisit is to have an Azure subscription. If you don't have an Azure subscription, create a [free Azure account](https://azure.microsoft.com/en-us/free/) before you continiue.

After you open Azure Portal under your account the following resourcese need to be created:
1. Azure Storage Account ([see details](#sac))
2. Data Lake Storage Account Gen 2 (ADLS) ([see details](#ADLS))
3. Azure Data Factory ([see details](#ADF))
4. Azure SQL Database ([see details](#SQL))
5. Azure Cosmos DB ([see details](#Cosmos))
6. Azure Databricks Cluster ([see details](#Databricks))
7. Azure Function App (Azure Function) ([see details](#Function))
8. Azure Key Vault ([see details](#KeyVault))

### Final overview of project services
![Project Architecture overview](images/Services.png "Project Architecture") 

>**Notice:** *Assuming you already have solid knowledge and understanding how to provision those services no detailed instructions and screen shoots will be provided on each step of creation. For more details if needed please visit Microsoft Docs pages.*

<a name="sac"></a>
## Storage Account

For details on how to create Azure Storage Account please visit [this web page](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal). 

**Important**: After Azure Storage Account is porvisioned, 3 containers must be created as shown on following image. All conatiners are type of Blob Storage and will be used as one of storage solution for the project.

![storage account](images/SA4.png)


<a name="ADLS"></a>
## Data Lake Storage Account

**Notice** : For details on how to create Data Lake Gen 2 Storage please visit [this web page](https://docs.microsoft.com/en-us/azure/storage/blobs/create-data-lake-storage-account).\
*The only difference comparing to Azure Storage Account is in enabling Hierarchy Namespace.*

![storage account](images/ADLS1.png)

**Important**: Inside ADLS 3 (three) containers must be created as shown on image. All conatiners are type of Blob Storage and will be used as one of storage solution for the project.

![storage account](images/ADLS4.png)

>### Important recomendation for both Storage Account and Azure Data Lake Storage
>*It's recomended to use **Azure Storage Explorer** - an application which helps you to easily access the Azure storage account through any device on any platform, be it Windows, MacOS, or Linux. You can easily connect to your subscription and manipulate your tables, blobs, queues, and files.*

<a name="SQL"></a>
## Azure SQL Database

After Azure SQL Server is provisioned (for details on how to provision visit [this web page](https://docs.microsoft.com/en-us/learn/modules/provision-azure-sql-db/)), the most important thing is to set firewall rules to allow access to database for other Azure Services and IP addresses/ranges/subnets. For more details on how to set firewall rules please visit [this web page](https://docs.microsoft.com/en-us/azure/azure-sql/database/secure-database-tutorial).

In order to prepare database for the project run the following [script](/SQL%20Server%20Scripts/IMDBDatabaseScript.sql)


<a name="KeyVault"></a>
## Azure KeyVault

<a name="ADF"></a>
## Azure Data Factory


<a name="Cosmos"></a>
## Cosmos DB

<a name="Databricks"></a>
## Azure Databricks Cluster

<a name="Function"></a>
## Azure Function App







