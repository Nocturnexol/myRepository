using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
public partial class Detailsx : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Modelx m = new Modelx();
        string uid = (string)Session["uid"];
        //string uid = m.uid;
        if (uid == null || m.getUserTypeByUserID(uid) ==null|| m.getUserTypeByUserID(uid).Equals("T") || m.getUserTypeByUserID(uid).Equals("S") || m.getUserTypeByUserID(uid).Equals("P"))
        {
            Session["uid"] = null;
            Context.Response.Redirect("http://oa.chsx.cn/ISchoolOs/mainlogin.aspx");
        }
        string pidEn = Request["pid"];
        string sidEn = Request["sid"];
        decimal pid = Convert.ToDecimal(encryption.DeCode(pidEn));
        decimal sid = Convert.ToDecimal(encryption.DeCode(sidEn));
        Modelx.paginationUnit = 8; 
        int pageNow = Convert.ToInt32(Context.Request["pageNow"]);
        if (pageNow == 0) { pageNow = 1; }
        int pageTotal = 0;
        string sqlstm = "select count(*) from YXZ_rec where sSerID=" + sid + " and pSerID=" + pid + " ;";
        if (m.getCount(sqlstm) % (Modelx.paginationUnit) == 0) { pageTotal = m.getCount(sqlstm) / (Modelx.paginationUnit); }
        else { pageTotal = m.getCount(sqlstm) / (Modelx.paginationUnit) + 1; }
        Context.Items["pageTotal"] = pageTotal;
        ArrayList al = m.getConvBySPSerID(sid, pid, pageNow);
        Context.Items["al"] = al;
    }
}