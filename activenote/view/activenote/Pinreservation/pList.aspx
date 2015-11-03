<%@ Page Title="" Language="C#" MasterPageFile="master/list_main.master" AutoEventWireup="true" CodeFile="pList.aspx.cs" Inherits="pList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="lmain" Runat="Server">
<link rel="icon" href="http://www.bestsch.com/bestsch.ico" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/animate.css" rel="stylesheet" />
    <link href="css/spage-style.css" rel="stylesheet" />
    <link href="css/ScreenStyle.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="http://apps.bdimg.com/libs/angular.js/1.3.9/angular.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="lcontent" Runat="Server">
<%
    ArrayList al=(ArrayList) Context.Items["al"];
    string uid = Request["UserID"];
    decimal pid = new Modelx().getPSerIDByUserID(uid);
    int weeknum=new Modelx().getWeeknum();
    bool b = true;
    //if (stu == null) {
    //   stu = new Model.stuAppt();
    //    stu.SerID = 0;
    //    stu.pSerID = 0;    
    //}
     %>
    <div class="container text-left" style="font-size:large">
    <span class="text-left" style="font-size:20px;color:#A2A2A2"><br />查看预约</span>
    <span class="pull-right"> <a href="LoginHandler.ashx?act=<%=encryption.EnCode("logout") %>" class="btn btn-success btn-lg">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>&nbsp;注销</a> </span><br /><br />
                 <!--<div><span class="pull-right text-success" style="font-size: x-large">欢迎你，<=new Model().getPnameBySerID(new Model().getPSerIDByUserID((string)Session["uid"])) %>校长。</span></div>
                <a href="LoginHandler.ashx?act=<=encryption.EnCode("logout") %>" class="btn btn-success btn-lg  pull-right">注销</a>-->
                 <span class="text-primary" style="font-size: large"><strong><%--学生信息：--%></strong></span>
    <%if (al.Count!=0)
      { %>
                      <span style="font-size: 14px; color:Black;">
                    <ul class="nav nav-tabs">
                        <li id="w" role="presentation" class="active"><a id='wa' style="color:Black;">本周预约</a></li>
                        <li id="h" role="presentation"><a id='ha' style="color:Black;">历史预约</a></li>
                    </ul>
                </span>
                <table id="tb" class="table table-hover" style="table-layout: fixed; font-size:14px">
                <thead>
                <tr>
                    <th class="text-center">
                        <strong>班级</strong>
                    </th>
                    <th class="text-center">
                       <strong> 姓名</strong>
                    </th>
                     <th class="text-center">
                        <strong>操作时间</strong>
                    </th>
                    <th class="text-center">
                        <strong>预约周</strong>
                    </th>
<%--                      <th class="text-center">
                        状态
                    </th>--%>
                     <th class="text-center">
                     <strong>操作</strong>
                    </th>
                </tr>
            </thead>
            <tbody>
                <%
          for (int i = 0; i < al.Count; i++)
          {
              Modelx.stuAppt stu = (Modelx.stuAppt)al[i];
              if (i == 0) {
                  if (stu.weeknum !=weeknum) { 
                  %>
                  <h4 id="t0" style="font-size:14px"><br />暂无学生预约信息。<br /><br /></h4>
                <script>
                                        $('#tb').attr('class', 'hidden');
                                        $('#ha').click(function () {
                                            $('#tb').attr('class', 'table table-hover');
                                        });
                                        $('#wa').click(function () {
                                            $('#tb').attr('class', 'hidden');
                                        });
                </script>
                <%
                      b = false;
                  }
                  else if (al.Count == 1) { %>
                   <h4 id="hl" class="hidden" style="font-size:14px"><br />暂无学生预约信息。<br /><br /></h4>
                  <script>
                      $('#ha').click(function () {
                          $('#tb').attr('class', 'hidden');
                          $('#hl').attr('class', '');
                      });
                      $('#wa').click(function () {
                          $('#tb').attr('class', 'table table-hover');
                          $('#hl').attr('class', 'hidden');
                      });
                  </script>
                 <%}              
              }
                  if (b)
                       { %>
            <tr id="t<%=i %>">
            <%}
                       else
                       { %>
                       <tr id="t<%=i+1 %>">
            <%} %>
                
                    <td class="text-center">
                        <%=new Modelx().getClassnameByStuID(stu.UserID)%>
                    </td>
                    <td class="text-center">
                    <%=stu.StuName%>
                    </td>
                    <td class="text-center">
                    <%=stu.date%>
                    </td>
                    <td class="text-center">
                    <%=stu.weeknum%>
                    </td>
<%--                    <td class="text-center">
                    <%if (stu.status == 0)
                      { %>
                            <span class="text-muted">等待审核</span>
                            <%}
                      else if (stu.status == 1)
                      { %>
                            <span class="text-success">已通过</span>
                            <%}
                      else
                      { %>
                               <span class="text-danger">审核未通过</span>
                            <%} %>
                    </td>--%>
                    <td class="text-center">
                    <%
// string seridEn = encryption.EnCode(stu.SerID.ToString());    
//string seridEn = Security.Encrypt(stu.SerID.ToString(),"12345678");
string seridEn = encryption.EnCode(stu.SerID.ToString()).Replace("+", ".").Replace("&", "/");
string weeknumEn = encryption.EnCode(stu.weeknum.ToString());
                       %>
                    <%--<a href="Handler3.ashx?opt=<%=encryption.EnCode("1")%>&serid=<%= seridEn%>" class="btn btn-success" >接受</a>
                    <a href="Handler3.ashx?opt=<%= encryption.EnCode("-1") %>&serid=<%= seridEn%>" class="btn btn-danger">拒绝</a>--%>
                   <a href="pView.aspx?weeknum=<%=weeknumEn %>&sid=<%=encryption.EnCode(stu.SerID.ToString()) %>&pid=<%=encryption.EnCode(pid.ToString()) %>" target="_blank" class="btn btn-success">查看留言</a>
                    </td></tr>
          <%}%>
          <tr><td></td><td></td><td></td><td></td><td></td></tr>
            </tbody>
        </table>
      <%}
      else
      { %><div class="jumbotron">
      <h4>暂无学生预约信息。<br /><br /></h4></div>
        <%} %>
    </div>
        
    <script>
    for(var i=1;i<<%=al.Count+1 %>;i++){
    $('#t'+i).attr('class','hidden');
    }
        $('#ha').click(function () {
            $('#h').attr('class', 'active');
            $('#w').attr('class', '');
            $('#t0').attr('class', 'hidden');
            for(var i=1;i<<%=al.Count+1 %>;i++){
            $('#t'+i).attr('class','table table-hover');
    }
        });
        $('#wa').click(function () {
            $('#w').attr('class', 'active');
            $('#h').attr('class', '');
            $('#t0').attr('class', 'table table-hover');
            for(var i=1;i<<%=al.Count+1 %>;i++){
    $('#t'+i).attr('class','hidden');
    }
        });
    </script>
</asp:Content>

