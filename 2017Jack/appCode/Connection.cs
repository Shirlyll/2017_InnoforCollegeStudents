using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace _2017Jack
{
    public class Connection
    {
        public ArrayList dataAddress (string commText)
        {
            //连接字符串
            string connstr = ConfigurationManager.AppSettings["dbconnection"];
            SqlConnection conn = new SqlConnection(connstr);

            //写sql命令 传available=1 的Jackid & JackName
            SqlCommand comm = conn.CreateCommand();
            comm.CommandText = commText;
            conn.Open();
            SqlDataReader dr = comm.ExecuteReader();
            ArrayList records = new ArrayList();

            while (dr.Read())
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                for (int a = 0; a < dr.FieldCount; a++)
                {
                    dic.Add(dr.GetName(a), dr[a].ToString());
                }
                records.Add(dic);
            }
            return records;
        }
    }
}