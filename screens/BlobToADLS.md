# Copy data from Azure Blob Storage (ABS) to Azure Data Lake Storage (ADLS)

Principle is the same ad described in [Ingest data from HTTP service into Azure Blob Storage (ABS) with parametrized pipelines using Azure Data Factory (ADF)](screens/HTTPToBlob.md).

There are  2 main diferences which must be taken into consideration:
1. Datasets are different then used in [linked article](screens/HTTPToBlob.md)
2. Parameter values are set according to Source and Sink in copy activity

The principle of execution flow is completely the same as from [linked article](screens/HTTPToBlob.md) so we are not going into implementation details. As previously defined datasets are different and the same looks as on following image:



