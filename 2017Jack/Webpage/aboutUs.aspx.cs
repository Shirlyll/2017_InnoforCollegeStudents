using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _2017Jack.Webpage
{
   
    public class SuggestionEntity : EntityBase
    {

    }
    public partial class aboutUs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           

            switch (Request.QueryString["action"])
            {
                case null:
                    break;
                case "saveParameter":
                    saveSuggestion();
                    break;
                default:
                    break;
            }



        }
        protected void saveSuggestion()
        {

        }
    }
}