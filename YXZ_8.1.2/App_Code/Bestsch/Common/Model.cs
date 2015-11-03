using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Collections;
using XT.SQLHELP.sqlbase;
using System.Data;
//using XT.SchInfo.web.ui;

    public class Modelx//:basepage
    {
        public static int paginationUnit { set; get; }
        //public string uid { get { return UID; } }
        //public string usertype { get { return UserType; } }
        msbase ms = new msbase();
        DataTable dt = null;
        public class stuAppt
        {
            public decimal SerID { set; get; }
            public string UserID { set; get; }
            public string StuName { set; get; }    
            public int semavail { set; get; }
            public decimal pSerID { set; get; }
            public DateTime date { set; get; }
            public int status { set; get; }
            public int weeknum { set; get; }
        }

        public class principal
        {
            public decimal SerID { get; set; }
            public string pID { get; set; }
            public string name { get; set; }
            public string district { get; set; }
            public int avail { get; set; }
            public int weeknum { get; set; }
        }

        public class rec
        {
            public int recID { get; set; }
            public decimal sSerID { get; set; }
            public decimal pSerID { get; set; }
            public string question { get; set; }
            public string msg { get; set; }
            public DateTime time { get; set; }
            public int isConvAnnounced { get; set; }
        }

        public class prst
        {
            public decimal sSerID { set; get; }
            public string sname { set; get; }
            public int semavail { set; get; }
            public decimal pSerID { set; get; }
            public DateTime date { set; get; }
            public int status { set; get; }
            public string pname { get; set; }
            public string district { get; set; }
            public int avail { get; set; }
            public int weeknum { get; set; }
        }
        /// <summary>
        /// 通过当前最后一条week记录的weeknum列得到当前是第几周，如果无记录，则插入一条，算做第一周。
        /// </summary>
        /// <returns>当前是第几周</returns>
        public int getWeeknum() {
            int weeknum = 0;
            dt = ms.SelectSql("select top 1 * from YXZ_week order by weeknum desc;");
            if (dt.Rows.Count > 0)
            {
                weeknum = Convert.ToInt32(dt.Rows[0][0]);
            }
            else {
                ms.ExeSql("insert into YXZ_week (weeknum,leftnum,date) values(1,4,getdate());");
                weeknum = 1;
            }
            return weeknum;
        }

        public int getWeekleft(int weeknum) {
            int weekleft = 0;
            dt = ms.SelectSql("select * from YXZ_week where weeknum="+weeknum +";");
            if (dt.Rows.Count > 0) { weekleft = Convert.ToInt32(dt.Rows[0][1]); }
            return weekleft;
        }

        public void setNewWeek() {
            DateTime d = new DateTime();
            DateTime dnow = DateTime.Now;
            dt = ms.SelectSql("select top 1 * from YXZ_week order by weeknum desc");
            if (dt.Rows.Count > 0&&this.getWeeknum()<=30)
            {
                if (dt.Rows[0]["date"] != null)
                {
                    d = Convert.ToDateTime(dt.Rows[0]["date"]);
                }
                TimeSpan ts = new TimeSpan(dnow.Ticks - d.Ticks);
                int day=Convert.ToInt32(DateTime.Now.DayOfWeek);
                if (day == 0) { day = 7; }
                if (ts.Days >= 7||ts.Days>=day)
                {
                    ms.ExeSql("insert into YXZ_week (weeknum,leftnum,date) values (" + (this.getWeeknum() + 1) + ",4,getdate())");
                }
            }
        }

        public bool setNewWeek(int week) {
            bool b = true;
            int weeknum = this.getWeeknum();
            if (week <=weeknum) {
                dt = ms.SelectSql("select * from YXZ_rec");
                if (dt.Rows.Count > 0)
                {
                    b = b && ms.ExeSql("delete from YXZ_rec;");
                }
                dt=ms.SelectSql("select * from YXZ_stuAppt;");
                if (dt.Rows.Count > 0)
                {
                    b = b && ms.ExeSql("delete from YXZ_stuAppt;");
                }
                b = b && ms.ExeSql("update YXZ_principal set avail=1;");
                dt = ms.SelectSql("select * from YXZ_week where weeknum="+week);
                if (dt.Rows.Count == 0) {
                    ms.ExeSql("insert into YXZ_week (weeknum,leftnum) values("+week+",4)");
                }
                b = b && ms.ExeSql("update YXZ_principal set weeknum=" + week + ";");
                dt = ms.SelectSql("select * from YXZ_week where weeknum>" + week);
                if (dt.Rows.Count > 0)
                {
                    b = b && ms.ExeSql("delete from YXZ_week where weeknum>" + week + ";");
                }
                b = b && ms.ExeSql("update YXZ_week set leftnum=4 where weeknum=" + week + ";");
                b = b && ms.ExeSql("update YXZ_week set date= getdate() where weeknum="+week);
            }
            else if (week > weeknum) { b = b && ms.ExeSql("insert into YXZ_week (weeknum,leftnum) values(" + week + ",4)"); }
            return b;
        }
        /// <summary>
        /// 每周初始化学生预约表stuAppt，如果该学生是本周第一次登陆并且本周还有预约名额，则更新表中该学生记录。
        /// </summary>
        /// <param name="uid">UserID</param>
        public void stuApptInit(string uid) {
            decimal SerID = this.getSerIDByUserID(uid);
            if (SerID == 0) { return; }
            int weeknum = this.getWeeknum();
            int weekleft = this.getWeekleft(weeknum);
            dt = ms.SelectSql("select * from YXZ_stuAppt where SerID=" + SerID + " and weeknum="+weeknum+";");
            if (dt.Rows.Count == 0) {
                // login 1st time this week or ever before
                DataTable ds = ms.SelectSql("select * from YXZ_stuAppt where SerID=" + SerID + ";");
                if (ds.Rows.Count > 0)
                {
                    //login ever
                    int semavail=Convert.ToInt32(ds.Rows[0][1]);
                    if (semavail >0) {
                        ms.ExeSql("update YXZ_stuAppt set weeknum="+weeknum+" where SerID="+SerID+";");
                    }
                }
                else
                {
                    //never login
                        ms.ExeSql("insert into YXZ_stuAppt (SerID,semavail,weeknum) values(" + SerID + ",1," + weeknum + ");");
                }
            }
        }
        /// <summary>
        /// [初始化选出的校长表princal，根据当前是第几周，顺序地在IAM_TeaInfo表中每周选出四位校长
        /// 插入principal表中，并指定其中两位为江锦校区，另外两位为采荷校区。]
        /// 新方法：校长为固定的四校长，每周只需要更新校长的可用名额字段与weeknum字段即可。
        /// </summary>
        /// <param name="weeknum">当前是第几周</param>
        public void principalInit(int weeknum) {
            string sqlstm = "select * from YXZ_principal;";
            dt = ms.SelectSql(sqlstm);
            if (dt.Rows.Count == 0) { 
            //empty table
                sqlstm = "insert into YXZ_principal (serid,name,district,avail,weeknum) values("+this.getPSerIDByUserID("hexia")+",'何霞','江锦',1,"+weeknum+")";
                ms.ExeSql(sqlstm);
                sqlstm = "insert into YXZ_principal (serid,name,district,avail,weeknum) values(" + this.getPSerIDByUserID("xuyue") + ",'徐越','江锦',1," + weeknum + ")";
                ms.ExeSql(sqlstm);
                sqlstm = "insert into YXZ_principal (serid,name,district,avail,weeknum) values(" + this.getPSerIDByUserID("wangwei") + ",'汪伟','采荷',1," + weeknum + ")";
                ms.ExeSql(sqlstm);
                sqlstm = "insert into YXZ_principal (serid,name,district,avail,weeknum) values(" + this.getPSerIDByUserID("huangshenghao") + ",'黄升昊','采荷',1," + weeknum + ")";
                ms.ExeSql(sqlstm);
            }
            sqlstm = "select * from YXZ_principal where weeknum="+weeknum+";";
            dt = ms.SelectSql(sqlstm);
            if (dt.Rows.Count == 0) { 
            //a new week
                sqlstm = "update YXZ_principal set weeknum="+weeknum+";";
                ms.ExeSql(sqlstm);
                sqlstm = "update YXZ_principal set avail=1;";
                ms.ExeSql(sqlstm);
            }
            //string sqlstm = "select top 4 * from IAM_TeaInfo where TeaSerID not in (select top " + 4 * (weeknum - 1) + " TeaSerID from IAM_TeaInfo);";
            //ArrayList al = new ArrayList();
            //dt = ms.SelectSql(sqlstm);
            //for (int i = 0; i < dt.Rows.Count; i++) {
            //    principal p = new principal();
            //    p.SerID =Convert.ToDecimal(dt.Rows[i][1]);
            //    p.name = dt.Rows[i][5].ToString();
            //    al.Add(p);
            //}
            //for(int i=0;i<2;i++){
            //    sqlstm = "select * from YXZ_principal where SerID=" + ((principal)al[i]).SerID + ";";
            //    dt = ms.SelectSql(sqlstm);
            //if (dt.Rows.Count==0)
            //{
            //    sqlstm = "insert into YXZ_principal (serid,name,district,avail,weeknum) values(" + ((principal)al[i]).SerID + ",'" + ((principal)al[i]).name + "','江锦',1," + weeknum + ");";
            //    ms.ExeSql(sqlstm);
            //}
            //else {
            //    sqlstm = "update YXZ_principal set weeknum=" + weeknum + ";";
            //    ms.ExeSql(sqlstm);
            //}
            //}
            //for (int i = 2; i < 4; i++)
            //{
            //    sqlstm = "select * from YXZ_principal where SerID=" + ((principal)al[i]).SerID + ";";
            //    dt = ms.SelectSql(sqlstm);
            //    if (dt.Rows.Count==0)
            //    {
            //        sqlstm = "insert into YXZ_principal (serid,name,district,avail,weeknum) values(" + ((principal)al[i]).SerID + ",'" + ((principal)al[i]).name + "','采荷',1," + weeknum + ");";
            //        ms.ExeSql(sqlstm);
            //    }
            //    else {
            //        sqlstm = "update YXZ_principal set weeknum=" + weeknum + ";";
            //        ms.ExeSql(sqlstm);
            //    }
            //}
        }
        /// <summary>
        /// 根据SQL语句条件得到表中记录总和。
        /// </summary>
        /// <param name="stmt">SQL语句</param>
        /// <returns>记录总数</returns>
        public int getCount(string stmt) {
            int count = 0;
            dt = ms.SelectSql(stmt);
            if (dt.Rows.Count > 0) {
                count =Convert.ToInt32(dt.Rows[0][0]);
            }
            return count;        
        }
        /// <summary>
        /// 得到要发布的记录表中数据条数总和。
        /// </summary>
        /// <returns>记录总数</returns>
        public int getCount()
        {
            int count = 0;
            dt = ms.SelectSql("select count(*) from YXZ_rec,YXZ_stuAppt where sSerID=SerID and isConvAnnounced=1 and msg!=('') ;");
            if (dt.Rows.Count > 0)
            {
                count = Convert.ToInt32(dt.Rows[0][0]);
            }
            return count;
        }

        public string getUserTypeByUserID(string uid) {
            string type = null;
            dt = ms.SelectSql("select * from IAM_FwUser where UserID='" + uid + "';");
            if (dt.Rows.Count > 0)
            {
                type = dt.Rows[0]["UserType"].ToString();
            }
            return type;
        }

        public string getPnameBySerID(decimal id)
        {
            string pname = null;
            dt = ms.SelectSql("select * from YXZ_principal where SerID=" + id + ";");
            if (dt.Rows.Count>0)
            {
                pname = dt.Rows[0][2].ToString();
            }
            return pname;
        }

        public int getStatusBySerID(decimal id) {
            int status = 0;
            dt = ms.SelectSql("select * from YXZ_stuAppt where SerID=" + id + ";");
            if (dt.Rows.Count>0) {
                status =Convert.ToInt32(dt.Rows[0][4]);
            }
            return status;
        }

        public string getStuIDBySerID(decimal id)
        {
            string  StuID=null;
            dt = ms.SelectSql("select * from IAM_StuInfo where StuSerID=" + id + ";");
            if (dt.Rows.Count>0)
            {
                StuID = dt.Rows[0][3].ToString();
            }
            return StuID;
        }

        public string getClassnameByStuID(string uid) {
            string cl = null;
            dt = ms.SelectSql("select ClassName from IAM_StuInfo,V_ClassList where IAM_StuInfo.ClassID=V_ClassList.ClassID and StuID ='"+uid+"';");
            if (dt.Rows.Count > 0) {
                cl = dt.Rows[0][0].ToString();            
            }
            return cl;
        }

        public string getUserIDBySerID(decimal serid) {
            string uid = null;
            dt = ms.SelectSql("select * from IAM_FwUser where SerID=" + serid + ";");
            if (dt.Rows.Count > 0)
            {
                uid = dt.Rows[0][1].ToString();
            }
            return uid;
        }

        public decimal getPSerIDByUserID(string uid) {
            decimal pSerID = 0;
            dt = ms.SelectSql("select * from IAM_FwUser where UserID='" + uid + "';");
            if (dt.Rows.Count>0)
            {
                pSerID =Convert.ToDecimal(dt.Rows[0][0]);
            }
            return pSerID;
        }

        public decimal getSerIDByUserID(string uid) {
            decimal SerID = 0;
          /*      cmd=new SqlCommand("select * from IAM_FwUser where UserID='" + uid + "';", con);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                StuSerID = dr.GetDecimal(0);
            }*/
            //dbh.closeConn( cmd, dr);
            dt = ms.SelectSql("select * from IAM_StuInfo where StuID='" + uid + "';");
            if (dt.Rows.Count>0)
            {
                SerID =Convert.ToDecimal(dt.Rows[0][1]);
            }
            return SerID;
        }

        public string getSnameBySerID(decimal id)
        {
            string Sname = null;
            dt = ms.SelectSql("select * from IAM_StuInfo where StuSerID=" + id + ";");
            if (dt.Rows.Count>0)
            {
                Sname = dt.Rows[0][7].ToString();
            }
            return Sname;
        }

        public string getPdistrictBySerID(decimal id) 
        {
            string pd = null;
            dt = ms.SelectSql("select * from YXZ_principal where SerID=" + id + ";");
            if (dt.Rows.Count>0)
            {
                pd = dt.Rows[0][3].ToString();
            }
            return pd;        
        }

        public ArrayList getConvBySPSerID(decimal sSerID,decimal pSerID,int pageNow) {
            ArrayList al = new ArrayList();
            string sqlstm = "select top " + Modelx.paginationUnit + " * from YXZ_rec where recID not in (select top " + (pageNow - 1) * Modelx.paginationUnit + " recID from YXZ_rec where sSerID=" + sSerID + " and pSerID=" + pSerID + ") and sSerID=" + sSerID + " and pSerID=" + pSerID + ";";
            dt = ms.SelectSql(sqlstm);
            for (int i = 0; i < dt.Rows.Count;i++)
            {
                Modelx.rec r = new Modelx.rec();
                r.recID = Convert.ToInt32(dt.Rows[i][0]);
                r.sSerID = Convert.ToDecimal(dt.Rows[i][1]);
                r.pSerID = Convert.ToDecimal(dt.Rows[i][2]);
                r.question = dt.Rows[i][3].ToString();
                r.msg = dt.Rows[i][4].ToString();
                r.time =Convert.ToDateTime(dt.Rows[i][5]);
                r.isConvAnnounced=Convert.ToInt32(dt.Rows[i][6]);
                al.Add(r);
            }
            return al;
        }

        public ArrayList getConvBySPSerID(decimal sSerID, decimal pSerID) 
        {
            ArrayList al = new ArrayList();
            dt = ms.SelectSql("select * from YXZ_rec where sSerID=" + sSerID + " and pSerID=" + pSerID + " order by time;");
            for (int i = 0; i < dt.Rows.Count;i++)
            {
                rec r = new rec();
                r.recID = Convert.ToInt32(dt.Rows[i][0]);
                r.sSerID = Convert.ToDecimal(dt.Rows[i][1]);
                r.pSerID = Convert.ToDecimal(dt.Rows[i][2]);
                r.question = dt.Rows[i][3].ToString();
                r.msg = dt.Rows[i][4].ToString();
                r.time = Convert.ToDateTime(dt.Rows[i][5]);
                r.isConvAnnounced = Convert.ToInt32(dt.Rows[i][6]);
                al.Add(r);
            }
            return al;
        }

        public ArrayList getAnnouncedConv(int pageNow)
        {
            ArrayList al = new ArrayList();
            string sqlstm = "select top " + Modelx.paginationUnit + " * from YXZ_rec where recID not in (select top " + (pageNow - 1) * Modelx.paginationUnit + " recID from YXZ_rec where isConvAnnounced=1 and msg!='' order by time desc ) and isConvAnnounced=1 and msg!=''order by time desc;";
            dt = ms.SelectSql(sqlstm);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Modelx.rec r = new Modelx.rec();
                r.recID = Convert.ToInt32(dt.Rows[i][0]);
                r.sSerID = Convert.ToDecimal(dt.Rows[i][1]);
                r.pSerID = Convert.ToDecimal(dt.Rows[i][2]);
                r.question = dt.Rows[i][3].ToString();
                r.msg = dt.Rows[i][4].ToString();
                r.time =Convert.ToDateTime(dt.Rows[i][5]);
                r.isConvAnnounced=Convert.ToInt32(dt.Rows[i][6]);
                al.Add(r);
            }
            return al;
        }

    }
