using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Intro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string uid = Request["UserID"];
        if (uid == null) { 
        uid=(string)Session["uid"];
        }
        else
        {
            Session["uid"] = uid;
        }
        Modelx m = new Modelx();
        m.stuApptInit(uid);
        //if (uid==null||!m.getUserTypeByUserID(uid).Equals("S")) { Session["uid"] = null; }
    }
}