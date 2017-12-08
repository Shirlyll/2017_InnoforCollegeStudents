using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _2017Jack.Webpage
{
    public partial class indexPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["WX_UserAccount"] = "131";
            string userId = Session["WX_UserAccount"].ToString();


        }
    }
}