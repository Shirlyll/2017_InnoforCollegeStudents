using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;

namespace _2017Jack.Webpage
{


    public partial class jackPage : System.Web.UI.Page
    {
        public void Page_Load ()
        {
            Session["WX_UserAccount"] = "131";
            string JackId = Request.QueryString["JackId"];
;           switch (Request.QueryString["action"])
            {

                case "initial":
                    initial();
                    break;
                case "showJackInfor":
                    showJackInfor(Request.QueryString["JackId"]);
                    break;
                case "saveName":
                    saveName(Request.QueryString["JackName"], Request.QueryString["JackId"]);
                    break;
                case "submitChange":
                    submitChange(Request.QueryString["JackId"], Request.QueryString["WorkState"],Request.QueryString["waitingTime"]);
                    break;

            }
        }
        public void initial()
        {
            try
            {
                string userId = Session["WX_UserAccount"].ToString();
                Connection connection = new Connection();
                ArrayList records = connection.dataAddress("select id, JackName from td_Jack where userId = '" + userId + "'and available = 1");
                Dictionary<string, string> result = new Dictionary<string, string>();
                EntityList JackList = new EntityList();
                foreach (Dictionary<string, string> record in records)
                {
                    result = record as Dictionary<string, string>;
                    JackEntity Jack_entity = new JackEntity();
                    Jack_entity.id = result["id"];
                    Jack_entity.JackName = result["JackName"];
                    JackList.entitylist.Add(Jack_entity);

                }

                //将dic型result对象传入stringbuilder中
                StringBuilder ShowJnameRecords = new StringBuilder();
                ShowJnameRecords.Append("[");
                foreach (JackEntity Jack_entity in JackList.entitylist)
                {
                    ShowJnameRecords.Append("{");
                    ShowJnameRecords.Append("id:'" + Jack_entity.id + "',");
                    ShowJnameRecords.Append("JackName:'" + Jack_entity.JackName + "'");
                    ShowJnameRecords.Append("},");
                }
                ShowJnameRecords.Append("]").Replace(",]", "]");
                Response.Clear();
                Response.Write("{'errcode':'0','ShowJnameRecords':" + ShowJnameRecords + "}");
                Response.End();
            }
            catch (Exception ex)
            {}

        }

        public void showJackInfor(string JackId)
        {
            try
            {

                string userId = Session["WX_UserAccount"].ToString();
                Connection connection = new Connection();
                ArrayList records = connection.dataAddress("select * from td_Jack where id = '" + JackId + "' and userId = '" + userId + "'and available = 1");
                EntityList JackList = new EntityList();
                foreach (Dictionary<string, string> record in records)
                {
                    Dictionary<string, string> result = record;
                    JackEntity Jack_entity = new JackEntity();
                    Jack_entity.id = result["id"];
                    Jack_entity.JackName = result["JackName"];
                    Jack_entity.JackType = result["JackType"];
                    Jack_entity.LinkState = result["LinkState"];
                    Jack_entity.WorkState = result["WorkState"];
                    Jack_entity.IsWaiting = result["IsWaiting"];
                    JackList.entitylist.Add(Jack_entity);
                    //查看workstate的值是否已到转换后的时间
                    if (Jack_entity.IsWaiting == "1")
                    {
                        Connection connection2 = new Connection();
                        ArrayList list = connection2.dataAddress("select operateTime from td_operateRecords where id = (select max(id) from td_operateRecords where userId = '" + userId + "'and JackId = '" + Jack_entity.id + "');");
                        //保持原来的等待状态
                        if (string.Compare(Jack_entity.operateTime, DateTime.Now.ToString()) == 1)
                        {
                            Jack_entity.IsWaiting = "0";
                            if (Jack_entity.WorkState == "1")
                            { Jack_entity.WorkState = "0"; }
                            else
                            { Jack_entity.WorkState = "1"; }
                        }
                        else//改变工作状态
                        {
                            foreach (Dictionary<string, string> operateRecord in list)
                            {
                                Jack_entity.operateTime = operateRecord["operateTime"];
                            }
                        }
                    }
                    else
                    {
                        Jack_entity.operateTime ="0";
                    }


                }
                //查看workstate的值是否已到转换后的时间
               
                //用StringBuilder构造json字符串
                StringBuilder ShowJackInforRecords = new StringBuilder();
                ShowJackInforRecords.Append("[");
                foreach (JackEntity Jack_entity in JackList.entitylist)
                {
                    ShowJackInforRecords.Append("{");
                    ShowJackInforRecords.Append("id:'" + Jack_entity.id + "',");
                    ShowJackInforRecords.Append("JackType:'" + Jack_entity.JackType + "',");
                    ShowJackInforRecords.Append("JackName:'" + Jack_entity.JackName + "',");
                    ShowJackInforRecords.Append("LinkState:'" + Jack_entity.LinkState + "',");
                    ShowJackInforRecords.Append("WorkState:'" + Jack_entity.WorkState + "',");
                    ShowJackInforRecords.Append("IsWaiting:'" + Jack_entity.IsWaiting + "',");
                    ShowJackInforRecords.Append("operateTime:'" + Jack_entity.operateTime + "'");
                    ShowJackInforRecords.Append("},");
                }
                ShowJackInforRecords.Append("]").Replace(",]", "]");
                Response.Clear();
                Response.Write("{'errcode':'0','ShowJackInforRecords':" + ShowJackInforRecords + "}");
                Response.End();

            }
            catch (Exception ex)
            { }
        }
        public void saveName(string JackName, string JackId)
        {
            try
            {
                string userId = Session["WX_UserAccount"].ToString();
                Connection connection = new Connection();
                connection.dataAddress("update td_Jack set JackName = '" + JackName + "' where id = '" + JackId + "'");
            }
            catch
            { }
        }
        //提交用户更改信息
        public void submitChange(string JackId, string WorkState,string waitingTime)
        {
            try
            {
                string userId = Session["WX_UserAccount"].ToString();
                //立即执行命令
                //修改Jack表
                if (waitingTime=="0")
                {
                    if (WorkState == "1")
                    {
                        Connection connection = new Connection();
                        connection.dataAddress("update td_Jack set WorkState='0' where id ='" + JackId + "'and userId='" + userId + "' and IsWaiting='0'");

                    }
                    else
                    {
                        Connection connection = new Connection();
                        connection.dataAddress("update td_Jack set WorkState='1' where id ='" + JackId + "'and userId='" + userId + "' and IsWaiting='0'");

                    }
                    //修改Records表
                    Connection connection2 = new Connection();
                    string submitTime = DateTime.Now.ToString();
                    //string operateTime = DateTime.Now.AddMinutes(30).ToString();
                    connection2.dataAddress("insert into td_OperateRecords values(1,'"+ userId + "','"+JackId+"','"+submitTime+"','"+submitTime+"')");
                    
                }
                //先等待再执行
                //修改Jack表
                
                if (waitingTime=="30")
                {
                    //修改Records表
                    string submitTime = DateTime.Now.ToString();
                    string operateTime = DateTime.Now.AddMinutes(30).ToString();
                    Connection connection = new Connection();
                    connection.dataAddress("insert into td_OperateRecords values(1,'" + userId + "','" + JackId + "','" + submitTime + "','" + operateTime + "')");
                    connection.dataAddress("update td_Jack set WorkState='"+WorkState+"' where id ='" + JackId + "'and userId='" + userId + "' and IsWaiting='1'");

                }

            }
            catch
            { }
        }
    }
}