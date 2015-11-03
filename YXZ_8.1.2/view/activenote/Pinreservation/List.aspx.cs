using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using XT.SQLHELP.sqlbase;
public partial class List : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Modelx m = new Modelx();
        Modelx.stuAppt stuAppt = new Modelx.stuAppt();
        msbase ms = new msbase();
        DataTable dt = null;
        string sqlstm;
        string sqlstm1;
        string sqlstm2;
        int t = 0, weeknum = 0;
        ArrayList al = new ArrayList();
        ArrayList al1 = new ArrayList();
        ArrayList al2 = new ArrayList();
        /* sqlstm="select * from principal;";
         cmd = new SqlCommand(sqlstm, conn);
         dr = cmd.ExecuteReader();
         while(dr.Read()) {
             al.Add( dr.GetString(1));
         }
         Context.Items["prcpl"] = al;
         dbh.closeConn(cmd, dr);*/
        stuAppt.UserID = (string)Session["uid"];
        if (stuAppt.UserID == null || m.getUserTypeByUserID(stuAppt.UserID) ==null|| !m.getUserTypeByUserID(stuAppt.UserID).Equals("S")) {
            Session["uid"] = null;
            Context.Response.Redirect("http://oa.chsx.cn/ISchoolOs/mainlogin.aspx");
        }
        //stuAppt.UserID = m.uid;
        stuAppt.SerID = m.getSerIDByUserID(stuAppt.UserID);
        m.setNewWeek();
        weeknum = m.getWeeknum();
        Context.Items["weeknum"] = weeknum;
        sqlstm = "select * from YXZ_stuAppt where SerID=" + stuAppt.SerID + ";";
        dt = ms.SelectSql(sqlstm);
        if (dt.Rows.Count > 0)
        {
            stuAppt.semavail = Convert.ToInt32(dt.Rows[0][1]);
            stuAppt.weeknum = Convert.ToInt32(dt.Rows[0][5]);
            if (stuAppt.semavail == 0)
            {
                stuAppt.pSerID = Convert.ToDecimal(dt.Rows[0][2]);
                stuAppt.date = Convert.ToDateTime(dt.Rows[0][3]);
                stuAppt.status = Convert.ToInt32(dt.Rows[0][4]);
            }
        }
        stuAppt.StuName = m.getSnameBySerID(stuAppt.SerID);
        Session["stu"] = stuAppt;

        //sqlstm = "select * from YXZ_rec where sSerID=" + stuAppt.SerID + " and pSerID=" + stuAppt.pSerID + " order by time;";
        //dt = ms.SelectSql(sqlstm);
        //for (int i = 0; i < dt.Rows.Count; i++)
        //{
        //    Model.rec rec = new Model.rec();
        //    rec.recID = Convert.ToInt32(dt.Rows[i][0]);
        //    rec.sSerID = Convert.ToDecimal(dt.Rows[i][1]);
        //    rec.pSerID = Convert.ToDecimal(dt.Rows[i][2]);
        //    rec.question = dt.Rows[i][3].ToString();
        //    rec.msg = dt.Rows[i][4].ToString();
        //    rec.time = Convert.ToDateTime(dt.Rows[i][5]);
        //    al.Add(rec);
        //}
        //Context.Items["al"] = al;

        t = m.getWeekleft(weeknum);
        Context.Items["weekleft"] = t;

        m.principalInit(weeknum);
        sqlstm1 = "select top(2) * from YXZ_principal where district='江锦' and avail=1;";
        sqlstm2 = "select top(2) * from YXZ_principal where district='采荷' and avail=1;";
        dt = ms.SelectSql(sqlstm1);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            Modelx.principal pr = new Modelx.principal();
            pr.SerID = Convert.ToDecimal(dt.Rows[i][0]);
            pr.name = dt.Rows[i][2].ToString();
            pr.district = dt.Rows[i][3].ToString();
            pr.avail = Convert.ToInt32(dt.Rows[i][4]);
            pr.weeknum = Convert.ToInt32(dt.Rows[i][5]);
            al1.Add(pr);
        }
        Context.Items["al1"] = al1;

        dt = ms.SelectSql(sqlstm2);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            Modelx.principal pr = new Modelx.principal();
            pr.SerID = Convert.ToDecimal(dt.Rows[i][0]);
            pr.name = dt.Rows[i][2].ToString();
            pr.district = dt.Rows[i][3].ToString();
            pr.avail = Convert.ToInt32(dt.Rows[i][4]);
            pr.weeknum = Convert.ToInt32(dt.Rows[i][5]);
            al2.Add(pr);
        }
        Context.Items["al2"] = al2;
    }
}