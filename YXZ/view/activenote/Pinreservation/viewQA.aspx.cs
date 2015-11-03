using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
public partial class viewQA : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sidEn = Request["sid"];
        string pidEn = Request["pid"];
        Modelx m = new Modelx();
        //string uid = m.UID;
        string uid = (string)Session["uid"];
        if (uid == null || m.getUserTypeByUserID(uid) ==null|| !m.getUserTypeByUserID(uid).Equals("S")) {
            Session["uid"] = null;
            Context.Response.Redirect("http://oa.chsx.cn/ISchoolOs/mainlogin.aspx");
        }
        //string page = Request["page"];
        //if (page == null) { page = ""; }
        ArrayList al = null;
        Modelx.paginationUnit = 8;
        int pageNow = Convert.ToInt32(Context.Request["pageNow"]);
        if (pageNow == 0) { pageNow = 1; }
        int pageTotal = 0;
        //decimal sid = Convert.ToDecimal(encryption.DeCode(sidEn));
        //decimal pid = Convert.ToDecimal(encryption.DeCode(pidEn));
        Modelx.stuAppt stu = new Modelx.stuAppt();
        stu = (Modelx.stuAppt)Session["stu"];
        if (stu != null)
        {
            decimal sid = Convert.ToDecimal(stu.SerID);
            decimal pid = Convert.ToDecimal(stu.pSerID);
            string sqlstm2 = "select count(*) from YXZ_rec where sSerID=" + sid + " and pSerID=" + pid + " ;";
            if (m.getCount(sqlstm2) % (Modelx.paginationUnit) == 0) { pageTotal = m.getCount(sqlstm2) / (Modelx.paginationUnit); }
            else { pageTotal = m.getCount(sqlstm2) / (Modelx.paginationUnit) + 1; }
            Context.Items["pageTotal"] = pageTotal;
            /*if (page.Equals("list")) {
                al = m.getConvBySPSerID(Convert.ToDecimal( sidEn),Convert.ToDecimal( pidEn));
            }*/
            // else
            // {
            al = m.getConvBySPSerID(sid, pid, pageNow);
            // }
            Context.Items["conv"] = al;
        }
    }
}