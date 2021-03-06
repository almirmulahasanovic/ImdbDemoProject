## Use Azure Function and C# for fetching and loading data into Azure Storage Acocunt from Azure SQL Database

Purpose of this section is to show another option in moving data from one location to another.In this case we use Azure Function and Visual Studio (C#) to connect to Azure SQL Database , fetch the data and move the same into Azure Blob Storage.

We often build systems to react to a series of critical events. Whether you're building a web API, responding to database changes, processing IoT data streams, or even managing message queues - every application needs a way to run some code as these events occur.\

In project we run function as scheduled tasks - actually we execute code at set time. There are many other scenarios - for more info plese see Microsoft Docs pages.\

As for set time please visit [this page](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-timer?tabs=csharp) for more details.

C# code for defined function is in addition.


```
using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using System.IO;
using System.Threading.Tasks;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using Microsoft.Azure.Storage.Blob;
using Microsoft.Azure.Storage;

namespace FunctionMoveToSqlApp
{
    public static class fnMoveSqlToBlob
    {
        [FunctionName("fnMoveSqlToBlob")]
        public static void Run([TimerTrigger("0 */1 * * * *")]TimerInfo myTimer, ILogger log)
        {
            string sqlSrvConnString = Environment.GetEnvironmentVariable("SqlServerConnString");
            string constr = Environment.GetEnvironmentVariable("SqlServerConnString");

            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("select distinct top 10 name from SalesLT.Product"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);

                            //Build the CSV file data as a Comma separated string.
                            string csv = string.Empty;

                            foreach (DataColumn column in dt.Columns)
                            {
                                //Add the Header row for CSV file.
                                csv += column.ColumnName + ',';
                            }

                            //Add new line.
                            csv += "\r\n";

                            foreach (DataRow row in dt.Rows)
                            {
                                foreach (DataColumn column in dt.Columns)
                                {
                                    //Add the Data rows.
                                    csv += row[column.ColumnName].ToString().Replace(",", ";") + ',';
                                }

                                //Add new line.
                                csv += "\r\n";
                            }

                            UploadNewFile(csv.ToString());



                        }
                    }
                }

            }
           
        }
        public static void UploadNewFile(string csv)
        {

            string blobConnString = Environment.GetEnvironmentVariable("BlobConnectionString");
            // Create a BlobServiceClient object which will be used to create a container client
            BlobServiceClient blobServiceClient = new BlobServiceClient(blobConnString);

            //Unique name for the post container
            string containerName = "referencedataimdbproject";
            string fileName = "reference_data.csv";
            ;

            using (MemoryStream stream = new MemoryStream())
            using (StreamWriter sw = new StreamWriter(stream))
            {
                sw.Write(csv.ToString());
                sw.Flush();
                stream.Position = 0;

                CloudStorageAccount storage = CloudStorageAccount.Parse(blobConnString);
                CloudBlobClient client = storage.CreateCloudBlobClient();
                CloudBlobContainer container = client.GetContainerReference(containerName);
                CloudBlockBlob blob = container.GetBlockBlobReference(fileName);
                blob.UploadFromStream(stream);
            }
        }


    }

}



```



