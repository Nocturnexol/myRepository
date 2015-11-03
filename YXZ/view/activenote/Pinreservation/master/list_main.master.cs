using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using XT.SQLHELP.sqlbase;
public partial class plugs_common_view_classweb_list_main : System.Web.UI.MasterPage
{
    msbase ms = new msbase();
    public string UserType;
    public string userphoto, teaname;
    protected void Page_Load(object sender, EventArgs e)
    {
        Modelx m = new Modelx();
        //string uid = m.UID;
       //string uid=(string)Session["uid"];
        //string UserSerIDen = (string )Session["UserSerID"];
        //string UserSerIDen = Request["UserSerID"];
       string uid = Request["UserID"];
       if (uid == null) { uid =(string) Session["uid"]; }
        //if (UserSerIDen == null) { Response.Redirect("Login.aspx"); }
        if (uid != null)
        {
            //UserSerID = encryption.DeCode(UserSerIDen);
            //string UserSerID = "104165";
            string UserSerID = m.getPSerIDByUserID(uid).ToString();
            DataTable dt = ms.SelectSql("select * from v_userlist where UserSerID='" + UserSerID + "'");
            if (dt.Rows.Count > 0)
            {
                UserType = dt.Rows[0]["UserType"].ToString();
            }
            DataTable dm = ms.SelectSql("select * from v_userlist2 where UserSerID='" + UserSerID + "'");
            if (dm.Rows.Count > 0)
            {
                userphoto = dm.Rows[0]["userphoto"].ToString();
                teaname = dm.Rows[0]["TeaName"].ToString();
            }
        }
    }
}
