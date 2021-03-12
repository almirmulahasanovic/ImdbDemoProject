# IMDB Demo Project

## Project overview

In the world of big data, raw, unorganized data is often stored in relational, non-relational, and other storage systems. All those data need a services that can orchestrate and operationalize processes to refine these enormous stores of data into actionable business insights.

The first step in building an information production system is to connect to all the required sources of data and processing, such as software-as-a-service (SaaS) services, databases, file shares, and FTP web services. The next step is to move the data as needed to a centralized location for subsequent processing.

Aim of this demo project is to provide an glimpse of different scenarios using  Azure Data Factory and Azure Databricks to Ingest, Prepare, Transform and Serve (IPTS) data. 

## Data source for the project

The project references IMDB Movie/TV datasets. You can get a subset of the IMDB data from [datasets.imdbws.com](datasets.imdbws.com). These files are refreshed daily, and you can find the descriptions and details on [imdb.com/interfaces](imdb.com/interfaces). Make sure you read the terms and conditions for usage.

## Prerequisites

*   Azure subscription. If you don't have an Azure subscription, create a [free Azure account](https://azure.microsoft.com/en-us/free/) before you begin.

## Project will show you how to:
1. [Set-up environment](Sections/setUp.md) 
2. [Ingest data from HTTP service into Azure Blob Storage (ABS) with parametrized pipelines using Azure Data Factory (ADF)](Sections/HTTPToBlob.md)
3. [Copy data from Azure Blob Storage (ABS) to Azure Data Lake Storage (ADLS)](Sections/BlobToADLS.md)
4. [Copy data from Azure Data Lake Storage (ADLS) to Azure SQL Database](Sections/ADLSToSQL.md)
5. [Create Databricks Notebooks for data transformation](Sections/CreateDBricksNoteBook.md)
6. [Transform data using Databricks Notebook Activity in Azure Data Factory (ADF) and load into Azure Data Lake Storage (ADLS) and Azure SQL Database](Sections/RunDBrickNbUsingADF.md)
7. [Transform data using Data Flows in Azure Data Factory (ADF) and load from Azure SQL Database into CosmosDb](Sections/SQLToCosmos.md))
8. [Use Azure Function and C# for fetching and loading data into Azure Storage Acocunt from Azure SQL Database]()


***Important** : Purpose of links from list above  is not to describe step by step implementation but te provide general concept of implementation.*

## Project Architecture



![Project Architecture overview](ProjectArchitecture/Software%20Architecture.png "Project Architecture") 

## My other projects
1.  [**FIDAR** - ](Sections/setUp.md) 
 (**FI**nancial **D**ata, **A**nalysis and **R**eporting) is profitability calculator. It's developed following banking financial standards for calculating profitability on different levels (segments, products, customers, branches). Implements Fund Transfer Pricing for calculating internal pricing and net interest margin on single deal, product and segment level [(see more details)](setUp.md)



