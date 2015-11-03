using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using XT.SQLHELP.sqlbase;
using System.Data;
public partial class view_activenote_Pinreservation_AnnouncedQA : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Modelx m = new Modelx();
        msbase ms = new msbase();
        DataTable dt = null;
        string sqlstm = null;
        ArrayList al = new ArrayList();
        ArrayList msgbox = new ArrayList();
        ArrayList date = new ArrayList();
        int pageNow = Convert.ToInt32(Context.Request["pageNow"]);
        if (pageNow == 0) { pageNow = 1; }
        Modelx.paginationUnit = 8;
        int pageTotal = 0;
        string act = Request["act"];
        if (act == null)
        {
            if (m.getCount() % (Modelx.paginationUnit) == 0) { pageTotal = m.getCount() / (Modelx.paginationUnit); }
            else { pageTotal = m.getCount() / (Modelx.paginationUnit) + 1; }
            // sqlstm = "select * from rec where msg !=('') order by time desc;";
            sqlstm = "select top " + Modelx.paginationUnit + " * from YXZ_rec where recID not in (select top " + (pageNow - 1) * Modelx.paginationUnit + " recID from YXZ_rec where isConvAnnounced=1 and msg!='' order by time desc ) and isConvAnnounced=1 and msg!=''order by time desc;";
        }
        else if (encryption.DeCode(act).Equals("search"))
        {
            Context.Items["pageTotal"] = pageTotal;
            string date1 = Request["date1"];
            string date2 = Request["date2"];
            string s = "select count(*) from YXZ_rec where isConvAnnounced=1 and msg!=('') and time between '" + date1 + "' and '" + date2 + "';";
            if (m.getCount(s) % (Modelx.paginationUnit) == 0) { pageTotal = m.getCount(s) / (Modelx.paginationUnit); }
            else { pageTotal = m.getCount(s) / (Modelx.paginationUnit) + 1; }
            sqlstm = "select top " + Modelx.paginationUnit + " * from YXZ_rec where recID not in (select top " + (pageNow - 1) * Modelx.paginationUnit + " recID from YXZ_rec where isConvAnnounced=1 and msg!=('') and time between '" + date1 + "' and '" + date2 + "' order by time desc ) and isConvAnnounced=1 and msg!=('') and time between '" + date1 + "' and '" + date2 + "' order by time desc;";
        }
        Context.Items["pageTotal"] = pageTotal;
        //dt = ms.SelectSql(sqlstm);
        //for (int i = 0; i < dt.Rows.Count; i++)
        //{
        //    Model.rec rec = new Model.rec();
        //    rec.recID = Convert.ToInt32(dt.Rows[i][0]);
        //    rec.sSerID = Convert.ToDecimal(dt.Rows[i][1]);
        //    rec.pSerID =Convert.ToDecimal(dt.Rows[i][2]);
        //    rec.question = dt.Rows[i][3].ToString();
        //    rec.msg = dt.Rows[i][4].ToString();
        //    rec.time = Convert.ToDateTime(dt.Rows[i][5]);
        //    al.Add(rec);
        //}
        al = m.getAnnouncedConv(pageNow);
        for (int i = 0; i < al.Count; i++)
        {
            if (i == 0)
            {
                ArrayList msg = new ArrayList();
                date.Add(((Modelx.rec)al[i]).time);
                msg.Add(al[i]);
                msgbox.Add(msg);
            }
            else
            {
                Modelx.rec lr = (Modelx.rec)al[i - 1];
                Modelx.rec r = (Modelx.rec)al[i];
                if (r.time.Year.CompareTo(lr.time.Year) != 0 || r.time.Day.CompareTo(lr.time.Day) != 0 || r.time.Month.CompareTo(lr.time.Month) != 0)
                {
                    ArrayList msg = new ArrayList();
                    date.Add(r.time);
                    msg.Add(r);
                    msgbox.Add(msg);
                }
                else
                {
                    int count = msgbox.Count;
                    ArrayList mssg = (ArrayList)msgbox[count - 1];
                    mssg.Add(r);
                }
            }

        }
        Context.Items["msgbox"] = msgbox;
        Context.Items["date"] = date;
    }
}