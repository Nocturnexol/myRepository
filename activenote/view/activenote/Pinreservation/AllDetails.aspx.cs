using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using XT.SQLHELP.sqlbase;
using System.Collections;

public partial class AllDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Modelx m = new Modelx();
        msbase ms = new msbase();
        DataTable dt = null;
        ArrayList  allApptmt= new ArrayList();
        ArrayList p= new ArrayList();
        string uid = Request["UserID"];
        if (uid != null)
        {
            Session["uid"] = uid;
        }
        string userid=(string)Session["uid"];
        if (userid == null || m.getUserTypeByUserID(userid) ==null|| !(m.getUserTypeByUserID(userid).Equals("Q") || m.getUserTypeByUserID(userid).Equals("M") || m.getUserTypeByUserID(userid).Equals("X")))
        {
            Session["uid"] = null;
            Context.Response.Redirect("http://oa.chsx.cn/ISchoolOs/mainlogin.aspx");
        }
        //string uid = m.UID;
        m.setNewWeek();
        int weeknum = m.getWeeknum();
        m.principalInit(weeknum);
        string sqlstm1 = "select top(2) * from YXZ_principal where district='江锦';";
        string sqlstm2 = "select top(2) * from YXZ_principal where district='采荷';";
        dt = ms.SelectSql(sqlstm1);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            Modelx.principal pr = new Modelx.principal();
            pr.SerID = Convert.ToDecimal(dt.Rows[i][0]);
            pr.name = dt.Rows[i][2].ToString();
            pr.district = dt.Rows[i][3].ToString();
            pr.avail = Convert.ToInt32(dt.Rows[i][4]);
            pr.weeknum = Convert.ToInt32(dt.Rows[i][5]);
            p.Add(pr);
        }
        dt = ms.SelectSql(sqlstm2);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            Modelx.principal pr = new Modelx.principal();
            pr.SerID = Convert.ToDecimal(dt.Rows[i][0]);
            pr.name = dt.Rows[i][2].ToString();
            pr.district = dt.Rows[i][3].ToString();
            pr.avail = Convert.ToInt32(dt.Rows[i][4]);
            pr.weeknum = Convert.ToInt32(dt.Rows[i][5]);
            p.Add(pr);
        }
        for (int i = 0; i < p.Count; i++)
        {
            string sqlstm = "select * from YXZ_stuAppt where pSerID=" + ((Modelx.principal)p[i]).SerID + " order by weeknum desc;";
            dt = ms.SelectSql(sqlstm);
            ArrayList apptmt = new ArrayList();
            for(int j=0;j<dt.Rows.Count;j++)
            {
                Modelx.stuAppt stu = new Modelx.stuAppt();
                stu.SerID = Convert.ToDecimal(dt.Rows[j][0]);
                stu.semavail = Convert.ToInt32(dt.Rows[j][1]);
                stu.pSerID = Convert.ToDecimal(dt.Rows[j][2]);
                stu.date = Convert.ToDateTime(dt.Rows[j][3]);
                stu.weeknum= Convert.ToInt32(dt.Rows[j][5]);
                stu.StuName = m.getSnameBySerID(stu.SerID);
                apptmt.Add(stu);
            }
            allApptmt.Add(apptmt);
        }
        //for (int i = 0; i < al2.Count; i++)
        //{
        //    string sqlstm = "select * from YXZ_stuAppt where pSerID=" + ((Model.principal)al2[i]).SerID + ";";
        //    dt = ms.SelectSql(sqlstm);
        //    Model.prst prst = new Model.prst();
        //    if (dt.Rows.Count > 0)
        //    {
        //        prst.sSerID = Convert.ToDecimal(dt.Rows[0][0]);
        //        prst.sname = m.getSnameBySerID(prst.sSerID);
        //        prst.semavail = Convert.ToInt32(dt.Rows[0][1]);
        //        prst.pSerID = Convert.ToDecimal(dt.Rows[0][2]);
        //        prst.pname = ((Model.principal)al2[i]).name;
        //        prst.date = Convert.ToDateTime(dt.Rows[0][3]);
        //        prst.status = Convert.ToInt32(dt.Rows[0][4]);
        //    }
        //    else
        //    {
        //        prst.pSerID = ((Model.principal)al2[i]).SerID;
        //        prst.pname = ((Model.principal)al2[i]).name;
        //    }
        //    alprst.Add(prst);
        //}
        Context.Items["p"] = p;
        Context.Items["allApptmt"] = allApptmt;
    }
}