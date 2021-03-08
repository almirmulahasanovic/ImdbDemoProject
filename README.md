# ImdbDemoProject

## Project overview

In the world of big data, raw, unorganized data is often stored in relational, non-relational, and other storage systems. All those data need a services that can orchestrate and operationalize processes to refine these enormous stores of data into actionable business insights.

The first step in building an information production system is to connect to all the required sources of data and processing, such as software-as-a-service (SaaS) services, databases, file shares, and FTP web services. The next step is to move the data as needed to a centralized location for subsequent processing.

Aim of this demo project is to provide an glimpse of different scenarios using  Azure Data Factory and Azure Databricks to Ingest, Prepare, Transform and Serve (IPTS) data. 

## Data source for the project

The project references IMDB Movie/TV datasets. You can get a subset of the IMDB data from [datasets.imdbws.com](datasets.imdbws.com). These files are refreshed daily, and you can find the descriptions and details on [imdb.com/interfaces](imdb.com/interfaces). Make sure you read the terms and conditions for usage.

## Prerequisites

*   Azure subscription. If you don't have an Azure subscription, create a [free Azure account](https://azure.microsoft.com/en-us/free/) before you begin.

## Project will show you how to:
* [Set-up environment]() 
* [ingest data from HTTP service into Azure Blob Storage (ABS) with parametrized pipelines using Azure Data Factory (ADF)]()
* [copy data from Azure Blob Storage (ABS) to Azure Data Lake Storage (ADLS)]()
* [copy data from Azure Data Lake Storage (ADLS) to Azure SQL Database]()
* [create Databricks Notebooks for data transformation]()
* [transform data using Databricks Notebook Activity in Azure Data Factory (ADF) and load into Azure Data Lake Storage (ADLS) and Azure SQL Database]()
* [transform data using Data Flows in Azure Data Factory (ADF) and load from Azure SQL Database into CosmosDb]()
* [use Azure Function and C# for fetching and loading data into Azure Storage Acocunt from Azure SQL Database]()

## Project Architecture

![Architecture](img/Software%20Architecture.png)


