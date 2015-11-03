using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using XT.SQLHELP.sqlbase;
public partial class pList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Modelx m = new Modelx();
        msbase ms = new msbase();
        DataTable dt = null;
        ArrayList al = new ArrayList();
        string uid = Request["UserID"];
        Session["uid"] = uid;
        if (uid == null || m.getUserTypeByUserID(uid) ==null|| !m.getUserTypeByUserID(uid).Equals("T")) {
            Session["uid"] = null;
            Context.Response.Redirect("http://oa.chsx.cn/ISchoolOs/mainlogin.aspx");
        }
        //string uid = m.UID;
        m.setNewWeek();
        decimal pSerID = m.getPSerIDByUserID(uid);
        string sqlstm = "select * from YXZ_stuAppt where pSerID=" + pSerID + " order by weeknum desc;";
        dt = ms.SelectSql(sqlstm);
        for (int i = 0; i < dt.Rows.Count;i++)
        {
            Modelx.stuAppt stu = new Modelx.stuAppt();
            stu.SerID = Convert.ToDecimal(dt.Rows[i][0]);
            stu.UserID = m.getStuIDBySerID(stu.SerID);
            stu.StuName = m.getSnameBySerID(stu.SerID);
            stu.semavail = Convert.ToInt32(dt.Rows[i][1]);
            stu.pSerID = Convert.ToDecimal(dt.Rows[i][2]);
            stu.date = Convert.ToDateTime(dt.Rows[i][3]);
            stu.status = Convert.ToInt32(dt.Rows[i][4]);
            stu.weeknum = Convert.ToInt32(dt.Rows[i][5]);
            al.Add(stu);
        }
        Context.Items["al"] = al;
    }
}