using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public static void Run(TimerInfo myTimer, ILogger log, TextWriter outputBlob )
{
    string constr = Environment.GetEnvironmentVariable("SqlServerConnString");
        using (SqlConnection con = new SqlConnection(constr))
    {
        using (SqlCommand cmd = new SqlCommand("select top 10 tconst from stage.movies where titleType ='tvmovie'"))
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

                    outputBlob.Write(csv.ToString());
                }
            }
        }
    }

                
}
