<%@ WebHandler Language="C#" Class="LoginHandler" %>

using System;
using System.Web;
using XT.SQLHELP.sqlbase;
using System.Data;
using System.Web.Security;
using System.Web.SessionState;
public class LoginHandler : IHttpHandler,IRequiresSessionState {
    public void ProcessRequest (HttpContext context) {
        msbase ms = new msbase();
        DataTable dt = null;
        context.Response.ContentType = "text/plain";
        context.Response.ContentType = "text/html";
        string uid = context.Request.Form["uid"];
        string pwd = context.Request.Form["pwd"];
        string actEn = context.Request["act"];
        string act = encryption.DeCode(actEn);
        if (act == null && actEn.Equals("login"))
        {
            string sqlstm = "select * from IAM_FwUser where UserID='" + uid + "';";
            dt = ms.SelectSql(sqlstm);
            if (dt.Rows.Count>0)
            {
                //user exists
                string rpwd = dt.Rows[0][2].ToString();
                //MD5 encode
                string md5pwd = FormsAuthentication.HashPasswordForStoringInConfigFile(pwd, "md5");
                //context.Response.Write(md5pwd);
                if (md5pwd.Equals(rpwd))
                {
                    //pwd correct
                    // login successfully
                    string type = dt.Rows[0][3].ToString();
                    Modelx m = new Modelx();
                    string sid = encryption.EnCode(m.getPSerIDByUserID(uid).ToString());
                    context.Session["uid"] = uid;
                    if (type.Equals("S"))
                    {
                        //student
                        decimal SerID = m.getSerIDByUserID(uid);
                        m.stuApptInit(uid);
                        context.Response.Redirect("Intro.aspx");

                    }
                    else if (type.Equals("T"))
                    {
                        //principal
                        context.Response.Redirect("pList.aspx");

                    }
                    else if (type.Equals("X") || type.Equals("Q") || type.Equals("M"))
                    {
                        //admin
                        context.Response.Redirect("AllDetails.aspx");
                    }
                    else if (type.Equals("P")) { context.Response.Redirect("AnnouncedQA.aspx"); }
                }
                else
                {
                    context.Response.Redirect("Login.aspx?err=2");
                }
            }
            else
            {
                context.Response.Redirect("Login.aspx?err=1");

            }
        }
        else if (act.Equals("logout"))
        {
            context.Session["stu"] = null;
            context.Session["uid"] = null;
            context.Response.Redirect("http://oa.chsx.cn/ISchoolOs/mainlogin.aspx");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}