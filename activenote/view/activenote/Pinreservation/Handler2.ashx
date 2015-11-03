<%@ WebHandler Language="C#" Class="Handler2" %>

using System;
using System.Web;
using System.Collections;
using XT.SQLHELP.sqlbase;
using System.Data;
public class Handler2 : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        int who = Convert.ToInt32(encryption.DeCode(context.Request["who"]));
        decimal sSerID = Convert.ToDecimal(encryption.DeCode(context.Request["sSerID"]));
        decimal pSerID = Convert.ToDecimal(encryption.DeCode(context.Request["pSerID"]));
        string typeEn = context.Request["type"];
        string type = encryption.DeCode(typeEn);
        Modelx m = new Modelx();
        Modelx.stuAppt stu = new Modelx.stuAppt();
        msbase ms = new msbase();
        if (type == "insert" && sSerID != 0)
        {
            string sqlstm = "";
            if (who == 0)
            {
                string txt = context.Request["txt"];
                sqlstm = "insert into YXZ_rec (sSerID,pSerID,question) values(@sSerID,@pSerID,@question);";
                ms.ExeSql(sqlstm,sSerID,pSerID,txt);
                context.Response.Redirect("viewQA.aspx");
            }
            else if (who == 1)
            {
                int weeknum=Convert.ToInt32(encryption.DeCode(context.Request["weeknum"]));
                string rid = context.Request["recID"];
                string txt = context.Request.Form["txt1"];
                sqlstm = "update YXZ_rec set msg=@msg where sSerID=@sSerID and pSerID=@pSerID and recID=@recID";
                ms.ExeSql(sqlstm,txt,sSerID,pSerID,rid);
                sqlstm = "update YXZ_rec set time=getdate() where sSerID=" + sSerID + " and pSerID=" + pSerID + " and recID=" + rid + ";";
                ms.ExeSql(sqlstm);
                context.Response.Redirect("pView.aspx?weeknum="+encryption.EnCode(weeknum.ToString())+"&sid="+encryption.EnCode(sSerID.ToString())+"&pid="+encryption.EnCode(pSerID.ToString()));
            }

        }
        else if (type == "set") { 
        int week=Convert.ToInt32(context.Request["week"]);
        bool b=m.setNewWeek(week);
        context.Response.Redirect("AllDetails.aspx?optflag="+encryption.EnCode(b.ToString()));
        }
        else if (type == "delete")
        {
            string ridEn = context.Request["recID"];
            string rid = encryption.DeCode(ridEn);
            int week = Convert.ToInt32(encryption.DeCode(context.Request["weeknum"]));
            if (who == 1)
            {
                string pidEn = context.Request["pid"];
                string sidEn = context.Request["sid"];
                ms.ExeSql("update YXZ_rec set msg='' where recid=" + rid + ";");
                context.Response.Redirect("pView.aspx?weeknum=" + encryption.EnCode(week.ToString()) + "&sid=" + sidEn + "&pid=" + pidEn);
            } if (who == 0)
            {
                ms.ExeSql("delete from YXZ_rec where recid=" + rid + ";");
                context.Response.Redirect("viewQA.aspx");
            }
        }
        else if (type == "edit")
        {
            string rid = context.Request["recID"];
            string txt = context.Request["txt"];
            if (who == 1)
            {
                ms.ExeSql("update YXZ_rec set msg=@msg where recid=@recid",txt,rid);
            }
            else if (who == 0)
            {
                ms.ExeSql("update YXZ_rec set question=@question where recid=@recid",txt,rid);
            }
        }
        /* else if (type == "view")
         {
             string pidEn = context.Request["pid"];
             string sidEn = context.Request["sid"];
             string pid = encryption.DeCode(pidEn);
             string sid = encryption.DeCode(sidEn);
             SqlDataReader dr = null;
             ArrayList al = new ArrayList();

             if (sid != "0")
             {
                 string sqlstm = "select * from YXZ_rec where sSerID=" + sid + " and pSerID=" + pid + " order by time;";
                 conn = dbh.getConn();
                 cmd = new SqlCommand(sqlstm, conn);
                 dr = cmd.ExecuteReader();
                 while (dr.Read())
                 {
                     Model.rec rec = new Model.rec();
                     rec.recID = dr.GetInt32(0);
                     rec.sSerID = dr.GetDecimal(1);
                     rec.pSerID = dr.GetDecimal(2);
                     rec.question = dr.GetString(3);
                     rec.msg = "";
                     if (dr.GetString(4) != null) { rec.msg = dr.GetString(4); };
                     rec.time = dr.GetDateTime(5);
                     al.Add(rec);
                 }
                 context.Session["alrec"] = al;
                 context.Response.Redirect("Details.aspx");
                 dbh.closeConn(cmd, dr);
             }
             dbh.closeConn(conn, cmd, dr);
         }*/
        else if (type == "announce")
        {
            string pidEn = context.Request["pid"];
            string sidEn = context.Request["sid"];
            decimal pid = Convert.ToDecimal(encryption.DeCode(pidEn));
            decimal sid = Convert.ToDecimal(encryption.DeCode(sidEn));
            string page = encryption.DeCode(context.Request["page"]);
            int status = 0;
            string announced = "";
            status = m.getStatusBySerID(sid);
            //if (status == -1 || status == 0)
            //{
            //    announced = encryption.EnCode("2");
            //    if (page == "1") { context.Response.Redirect("Details.aspx?sid=" + sidEn + "&pid=" + pidEn + "&announced=" + announced); }
            //    else
            //    {
            //        context.Response.Redirect("AllDetails.aspx?announced=" + announced);
            //    }
            //}
            ArrayList al = m.getConvBySPSerID(sid, pid);
            Boolean b = false;
            for (int i = 0; i < al.Count; i++)
            {
                if (!((Modelx.rec)al[i]).msg.Equals("")) { b = true; }
            }
            if (sid != 0 && al.Count != 0 && b)
            {
                string sqlstm = "update YXZ_rec set isConvAnnounced=1 where sSerID=" + sid + " and pSerID=" + pid + ";";
                bool bb = ms.ExeSql(sqlstm);
                if (bb)
                {
                    announced = encryption.EnCode("1");
                    context.Response.Write("<script>alert('发布成功！');</script>");
                    if (page == "1") { context.Response.Redirect("Details.aspx?sid=" + sidEn + "&pid=" + pidEn + "&announced=" + announced); }
                    else
                    {
                        context.Response.Redirect("AllDetails.aspx?announced=" + announced);
                    }
                }
                else
                {
                    context.Response.Write("<script>alert('发布失败！');</script>");
                    announced = encryption.EnCode("0");
                    if (page == "1") { context.Response.Redirect("Details.aspx?sid=" + sidEn + "&pid=" + pidEn + "&announced=" + announced); }
                    else
                    {
                        context.Response.Redirect("AllDetails.aspx?announced=" + announced);
                    }
                }
            }
            else if (al.Count == 0)
            {
                context.Response.Write("<script>alert('无问答信息，不能发布！');</script>");
                announced = encryption.EnCode("4");
                if (page == "1") { context.Response.Redirect("Details.aspx?sid=" + sidEn + "&pid=" + pidEn + "&announced=" + announced); }
                else
                {
                    context.Response.Redirect("AllDetails.aspx?announced=" + announced);
                }
            }
            else if (!b)
            {
                announced = encryption.EnCode("3");
                if (page == "1") { context.Response.Redirect("Details.aspx?sid=" + sidEn + "&pid=" + pidEn + "&announced=" + announced); }
                else
                {
                    context.Response.Redirect("AllDetails.aspx?announced=" + announced);
                }
            }

        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}