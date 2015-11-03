<%@ WebHandler Language="C#" Class="Handler3" %>

using System;
using System.Web;
using XT.SQLHELP.sqlbase;
public class Handler3 : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string optEn = context.Request["opt"];
        string seridEn = context.Request["serid"];
        int opt = Convert.ToInt32(encryption.DeCode(optEn));
        //decimal serid = Convert.ToDecimal(DESencryption.DecryptString(seridEn.ToString()));
        //decimal serid = Convert.ToDecimal(Security.Decrypt(optEn, "12345678"));
        decimal serid = Convert.ToDecimal(encryption.DeCode(seridEn.Replace(".", "+").Replace("/", "&")));
        // context.Response.Write(encryption.DeCode(serid));
        msbase ms = new msbase();
        string sqlstm = "update YXZ_stuAppt set status=" + opt + " where serid=" + serid + ";";
        ms.ExeSql(sqlstm);
        /*if (opt == -1) { 
         sqlstm="update YXZ_stuAppt set isconvannounced=0 where serid="+serid+";";
         cmd = new SqlCommand(sqlstm, conn);
         cmd.ExecuteNonQuery();
        }*/
        context.Response.Redirect("pList.aspx");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}