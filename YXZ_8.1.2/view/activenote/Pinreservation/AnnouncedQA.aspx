<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AnnouncedQA.aspx.cs" Inherits="view_activenote_Pinreservation_AnnouncedQA" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <link rel="icon" href="http://www.bestsch.com/bestsch.ico"/>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/animate.css" rel="stylesheet" />
    <link href="css/spage-style.css" rel="stylesheet" />
    <link href="css/ScreenStyle.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <%--<script src="http://apps.bdimg.com/libs/angular.js/1.3.9/angular.min.js"></script>--%>
    <title>全部问答</title>
</head>
<body>
 <%ArrayList al = (ArrayList)Context.Items["date"];
      ArrayList msgbox = (ArrayList)Context.Items["msgbox"];
      string act = Request["act"];
      string date1=Request["date1"];
      string date2 = Request["date2"];
      Modelx m = new Modelx();
    %>
    <div class="container text-left" style="font-size: 15px">
        <h4 style="font-size:20px;color:#A2A2A2"><br />“我约校长”对话录<br />
                <br />
        </h4>
        <!--<span class="text-success" style="font-size:large"><strong>今天</strong></span><br /><br />-->
        <%if (al.Count == 0)
          {
              if (act == null)
              {
              %><div class="jumbotron text-left">
        <h4>暂无问答信息。</h4>
        </div>
        <%
              }
              else { %>
<%--              <div id="dd">
              从&nbsp;<input id="i1" type="text" class="Wdate" placeholder="请选择日期..." style="height:25px;" onclick="WdatePicker()"/>&nbsp;到&nbsp;<input id="i2" type="text" class="Wdate" placeholder="请选择日期..." style="height:25px;" onclick="WdatePicker()"/>&nbsp;&nbsp;<a href="#" id="a1" class="btn btn-primary disabled">查询</a>&nbsp;<a href="AnnouncedQA.aspx" class="btn btn-success">查看全部问答</a><br /><br />
              </div>
              <h2 class="text-primary">
              暂无已发布的问答信息。</h2>--%>
              <%}
            }
          else
          {
              %><%--<div id="dd">
              从&nbsp;<input id="i1" type="text" class="Wdate" placeholder="请选择日期..." style="height:25px;" onclick="WdatePicker()"/>&nbsp;到&nbsp;<input id="i2" type="text" class="Wdate" placeholder="请选择日期..." style="height:25px;" onclick="WdatePicker()"/>&nbsp;&nbsp;<a href="#" id="a1" class="btn btn-primary disabled">查询</a>&nbsp;<a href="AnnouncedQA.aspx" class="btn btn-success">查看全部问答</a><br /><br />
              </div>--%>
              <%
              for (int i = 0; i < al.Count; i++)
              {
                  ArrayList msg = (ArrayList)msgbox[i];
                  %>
             <div class="panel panel-info hidden" id="pn1<%=i %>">
            <div class="panel-heading">
                <h3 class="panel-title" style='font-size:16px;'>
                    <%=((DateTime)al[i]).Month%>月<%=((DateTime)al[i]).Day%>日&nbsp;<%=m.getPnameBySerID(m.getPSerIDByUserID("hexia")).Substring(0, 1)%>校长对话录</h3>
            </div>
            <div id="d<%=i %>1" class="panel-body" style='font-size:10px;'>
            </div></div>
                         <div class="panel panel-info hidden" id="pn2<%=i %>">
            <div class="panel-heading">
                <h3 class="panel-title" style='font-size:16px;'>
                    <%=((DateTime)al[i]).Month%>月<%=((DateTime)al[i]).Day%>日&nbsp;<%=m.getPnameBySerID(m.getPSerIDByUserID("xuyue")).Substring(0, 1)%>校长对话录</h3>
            </div>
            <div id="d<%=i %>2" class="panel-body" style='font-size:10px;'>
            </div></div>
                         <div class="panel panel-info hidden" id="pn3<%=i %>">
            <div class="panel-heading">
                <h3 class="panel-title" style='font-size:16px;'>
                    <%=((DateTime)al[i]).Month%>月<%=((DateTime)al[i]).Day%>日&nbsp;<%=m.getPnameBySerID(m.getPSerIDByUserID("wangwei")).Substring(0, 1)%>校长对话录</h3>
            </div>
            <div id="d<%=i %>3" class="panel-body" style='font-size:10px;'>
            </div></div>
                         <div class="panel panel-info hidden" id="pn4<%=i %>">
            <div class="panel-heading">
                <h3 class="panel-title" style='font-size:16px;'>
                    <%=((DateTime)al[i]).Month%>月<%=((DateTime)al[i]).Day%>日&nbsp;<%=m.getPnameBySerID(m.getPSerIDByUserID("huangshenghao")).Substring(0, 1)%>校长对话录</h3>
            </div>
            <div id="d<%=i %>4" class="panel-body" style='font-size:10px;'>
            </div></div>
                  <%
                  for (int j = 0; j < msg.Count; j++)
                  {
                      Modelx.rec r = (Modelx.rec)msg[j];
                      string p = r.question.Replace("\"","'");
                      string q = r.msg.Replace("\"", "'");
                      if (r.pSerID == m.getPSerIDByUserID("hexia"))
                      {%>
                      <script>
                          $("#pn1<%=i %>").attr("class", "panel panel-info");
                          $("<div><p style='font-size:16px;'><span class='text-success'>学生：</span><span id='sp11'><%=p%></span></p><p style='font-size:16px;'><span class='text-primary'>校长：</span><span id='sp12'><%=q%></span></p><br /></div>").appendTo($("#d<%=i %>1"));
                      </script>
            <%}
                      else if (r.pSerID == m.getPSerIDByUserID("xuyue"))
                      { %>
        <script>
            $("#pn2<%=i %>").attr("class", "panel panel-info");
             $("<div><p style='font-size:16px;'><span class='text-success'>学生：</span><span><%=p%></span></p><p style='font-size:16px;'><span class='text-primary'>校长：</span><span><%=q%></span></p><br /></div>").appendTo($("#d<%=i %>2"));
        </script>
            <%}
                      else if (r.pSerID == m.getPSerIDByUserID("wangwei"))
                      { %>
                      <script>
                          $("#pn3<%=i %>").attr("class", "panel panel-info");
                          var d3 = $("#d<%=i %>3");
                          var a3 = $("<div><p style='font-size:16px;'><span class='text-success'>学生：</span><span><%=p%></span></p><p style='font-size:16px;'><span class='text-primary'>校长：</span><span><%=q%></span></p><br /></div>");
                          a3.appendTo(d3);
        </script>
            <%}
                      else if (r.pSerID == m.getPSerIDByUserID("huangshenghao"))
                      { %>
                      <script>
                          $("#pn4<%=i %>").attr("class", "panel panel-info");
                          var d4 = $("#d<%=i %>4");
                          var a4 = $("<div><p style='font-size:16px;'><span class='text-success'>学生：</span><span><%=p%></span></p><p style='font-size:16px;'><span class='text-primary'>校长：</span><span><%=q%></span></p><br /></div>");
                          a4.appendTo(d4);
        </script>
            <%}} %>
        
        <%}
          }%>
        <div class="text-center" style="font-size:14px">
            <ul class="pagination">
                <% int pageNow = Convert.ToInt32(Request["pageNow"]);
                   if (pageNow == 0) { pageNow = 1; }
                   if (pageNow > 1)
                   {
                       if (act == null)
                       {
                       %>
                <li><a href="AnnouncedQA.aspx?pageNow=<%=pageNow-1 %>">&laquo;</a></li>
                <%}
                       else { 
                       %>
                        <li><a href="AnnouncedQA.aspx?act=<%=encryption.EnCode("search") %>&date1=<%=date1 %>&date2=<%=date2 %>&pageNow=<%=pageNow-1 %>">&laquo;</a></li>
                       <%                       
                       }
                    }
               int pageTotal = Convert.ToInt32(Context.Items["pageTotal"]);
               for (int i = 0; i < pageTotal; i++)
               {
                   if (act == null)
                   {
                   %>
                <li id="l<%=i+1 %>"><a id="a<%=i+1 %>" href="AnnouncedQA.aspx?pageNow=<%=i+1 %>">
                    <%=i + 1%></a></li>
                   <%}
                   else { 
                   %>
                   <li id="l<%=i+1 %>"><a id="a<%=i+1 %>" href="AnnouncedQA.aspx?act=<%=encryption.EnCode("search") %>&date1=<%=date1 %>&date2=<%=date2 %>&pageNow=<%=i+1 %>"><%=i + 1%></a></li>
                   <%
                   }
               }
                  if (pageNow < pageTotal)
                  {
                      if (act == null)
                      {
                      %>
                <li><a id="ar" href="AnnouncedQA.aspx?pageNow=<%=pageNow+1 %>">&raquo;</a></li>
                      <%
                      }
                      else { 
                      %>
                      <li><a id="a2" href="AnnouncedQA.aspx?act=<%=encryption.EnCode("search") %>&date1=<%=date1 %>&date2=<%=date2 %>&pageNow=<%=pageNow+1 %>">&raquo;</a></li>
                      <%                      
                      }
                    } %>
            </ul>
        </div>
    </div>
    <script>
        $("#l<%=pageNow %>").attr("class", "active");
        //$(".panel").css("background", "transparent");
        //$('.panel').fadeTo(1, 0.85);
        $('.panel').css('background-color', 'rgba(248, 248, 248, 0.8)');
        $('.panel').addClass('YX-PG YX-wrap');
        $('.container').css('min-height', '750px');
        $('li').children().css('color', '#84bf41');
        $('.active').children().css({ 'background-color': '#84bf41', 'border-color': '#73AF2E','color':''});
        $("body").css({"background-color": "#ecf0f0","background": "url('child.jpg')","background-repeat": "no-repeat","width": "100%","min-height": "800px","background-attachment": "fixed","background-size": "1400px 1833px","background-position": "0px 0px"});
        $('.jumbotron').css('background-color', 'rgba(248, 248, 248, 0.8)');
        //        $("div").mousemove(function () {
        //            var v1 = $("#i1").val();
        //            var v2 = $("#i2").val();
        //            var pageTotal=<%=pageTotal %>;
        ////           var act=<%=act%>;
        ////                   if(<%=act %>!='hi'){
        ////                   $("#al").attr('href','AnnouncedQA.aspx?act=<%=encryption.EnCode("search") %>&pageNow=<%=pageNow-1 %>&date1='+v1+'&date2='+v2);
        ////                   $("#ar").attr('href','AnnouncedQA.aspx?act=<%=encryption.EnCode("search") %>&pageNow=<%=pageNow+1 %>&date1='+v1+'&date2='+v2);
        ////                   for(var i=-1;i<pageTotal;i++){
        ////                   if(i==0){$("#a1").attr('href','AnnouncedQA.aspx?act=<%=encryption.EnCode("search") %>&pageNow=1&date1='+v1+'&date2='+v2);}
        ////                   $("#a"+(i+1)).attr('href','AnnouncedQA.aspx?act=<%=encryption.EnCode("search") %>&pageNow='+(i+1)+'&date1='+v1+'&date2='+v2);
        ////                  }
        ////                   }
        //            if (v1 != "" && v2 != "") {
        //                if (v1 <= v2) {
        //                    $("#a1").attr("class", "btn btn-primary");
        //                    $("#a1").attr('href', 'AnnouncedQA.aspx?act=<%=encryption.EnCode("search") %>&date1='+v1+'&date2='+v2);
        //                    $("#myAlert").remove();
        //                } else {
        //                    $("#a1").attr("class", "btn btn-primary disabled");
        //                    $("#myAlert").remove();
        //                    var d = $("#dd");
        //                    var a = $("<div id='myAlert' class='alert alert-danger text-center'><strong>无效的日期范围！</strong></div>");
        //                    a.appendTo(d);
        //                }
        //            } else {
        //                $("#myAlert").remove();
        //                $("#a1").attr("class", "btn btn-primary disabled");
        //             }
        //        });
    </script>
</body>
</html>
