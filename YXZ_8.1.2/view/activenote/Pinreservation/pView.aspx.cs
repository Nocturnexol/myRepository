using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class view_activenote_Pinreservation_pView : System.Web.UI.Page
{
    public int getRecID() { 
        int recID;
        recID=Convert.ToInt32(Request["recID"]);
        //Response.Write(recID);
       // Response.End();
        return recID;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Modelx m = new Modelx();
        string uid = (string)Session["uid"];
        if (uid == null || m.getUserTypeByUserID(uid) ==null|| !m.getUserTypeByUserID(uid).Equals("T"))
        {
            Session["uid"] = null;
            Response.Redirect("http://oa.chsx.cn/ISchoolOs/mainlogin.aspx");
        }
        ArrayList al = new ArrayList();
        decimal SerID = Convert.ToDecimal(encryption.DeCode(Request["sid"]));
        decimal pSerID = Convert.ToDecimal(encryption.DeCode(Request["pid"]));
        Modelx.paginationUnit = 8; 
        int pageNow = Convert.ToInt32(Context.Request["pageNow"]);
        if (pageNow == 0) { pageNow = 1; }
        int pageTotal = 0;
        if (SerID != 0)
        {
            string sqlstm2 = "select count(*) from YXZ_rec where sSerID=" + SerID + " and pSerID=" + pSerID + " ;";
            if (m.getCount(sqlstm2) % (Modelx.paginationUnit) == 0) { pageTotal = m.getCount(sqlstm2) / (Modelx.paginationUnit); }
            else { pageTotal = m.getCount(sqlstm2) / (Modelx.paginationUnit) + 1; }
            Context.Items["pageTotal"] = pageTotal;
            al = m.getConvBySPSerID(SerID, pSerID, pageNow);
            Context.Items["al"] = al;
        }
    }
}