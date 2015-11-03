<%@ WebHandler Language="C#" Class="Handler1" %>

using System;
using System.Web;
using XT.SQLHELP.sqlbase;
using System.Web.SessionState;
public class Handler1 : IHttpHandler,IRequiresSessionState {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        //string pname = context.Request["val"];
        Modelx.stuAppt stu = new Modelx.stuAppt();
        Modelx m=new Modelx();
        msbase ms = new msbase();
        stu = (Modelx.stuAppt)context.Session["stu"];
        string optEn = context.Request["opt"];
        string opt = encryption.DeCode(optEn);
        //string realopt = encryption.DeCode(opt);
        string pidEn = context.Request["val"];
        string pid = encryption.DeCode(pidEn);
        //int realpid = Convert.ToInt32(encryption.DeCode(pid));
        //string val = (string)(context.Request.QueryString["val"]);
        // context.Response.Write(pid);           
        string sqlstm;
        int weeknum = m.getWeeknum();
        int weekleft = m.getWeekleft(weeknum);
        Modelx.principal pr = new Modelx.principal();
        bool b = true;
        if (opt == "apptmt")
        {
            if (weekleft > 0)
            {
                sqlstm = "update YXZ_week set leftnum=leftnum-1 where weeknum=" + weeknum+ ";";
                b=b&&ms.ExeSql(sqlstm);
                sqlstm = "update YXZ_stuAppt set semavail=semavail-1 where SerID=" + stu.SerID + ";";
                b=b&&ms.ExeSql(sqlstm);
                sqlstm = "update YXZ_stuAppt set pSerID =" + pid + ",date=getdate(),status=0 where SerID=" + stu.SerID + ";";
                b=b&&ms.ExeSql(sqlstm);
                sqlstm = "update YXZ_principal set avail=avail-1 where SerID=" + pid + ";";
                b=b&&ms.ExeSql(sqlstm);
                if (b) { context.Response.Redirect("List.aspx?aptflag=" + encryption.EnCode("635653084")); }
            }
        }
        else if (opt == "cancel")
        {
            sqlstm = "update YXZ_stuAppt set pSerID =null,date=null,status=null where SerID=" + stu.SerID + ";";
            ms.ExeSql(sqlstm);
            sqlstm = "update YXZ_week set leftnum=leftnum+1 where weeknum=" + weeknum + ";";
            ms.ExeSql(sqlstm);
            sqlstm = "update YXZ_stuAppt set semavail=semavail+1 where SerID=" + stu.SerID + ";";
            ms.ExeSql(sqlstm);
            sqlstm = "update YXZ_principal set avail=avail+1 where SerID=" + pid + ";";
            ms.ExeSql(sqlstm);
        }
        context.Response.Redirect("List.aspx");
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}