<%@ Page Title="" Language="C#" MasterPageFile="master/list_main.master" AutoEventWireup="true" CodeFile="Details.aspx.cs" Inherits="Detailsx" %>

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
  <%        ArrayList al = (ArrayList)Context.Items["al"];
              int pageNow = Convert.ToInt32(Request["pageNow"]);
              int pageTotal = Convert.ToInt32(Context.Items["pageTotal"]);
              string pidEn = Request["pid"];
              string sidEn = Request["sid"];
              decimal pid = Convert.ToDecimal(encryption.DeCode(pidEn));
              decimal sid = Convert.ToDecimal(encryption.DeCode(sidEn));
               %>
    <div class="container text-left" style="font-size:large">
        <span style="font-size:20px;color:#A2A2A2"><br />
            问答详情
        </span>
        <span class="pull-right">
            <%if (al.Count == 0)
              { %>
            <a href="#" class="btn btn-info btn-lg disabled">发布</a>
            <%}
              else
              {%>
            <a href="Handler2.ashx?page=<%=encryption.EnCode("1") %>&type=<%=encryption.EnCode("announce") %>&pid=<%=encryption.EnCode(((Modelx.rec)al[0]).pSerID.ToString())%>&sid=<%=encryption.EnCode(((Modelx.rec)al[0]).sSerID.ToString())%>"
                class="btn btn-info btn-lg" data-loading-text="请稍候..." onclick="return confirm('确认发布？');">发布</a>
            <%} %>
<a href="AllDetails.aspx" class="btn btn-success btn-lg" data-loading-text="请稍候...">返回</a></span><br /><br />
        <div id="d1"></div>
        <div id="d2" class="jumbotron" style="font-size:17px">
            <%if (al.Count == 0)
              { %>
            <span style="font-size:17px">
                暂无问答信息。</span>
            <%}
              else
              {
                  for (int i = 0; i < al.Count; i++)
                  {
                       %>
            <p class="text-left" style='font-size:17px;'>
                <span class='text-success'>
                    <%= new Modelx().getSnameBySerID(((Modelx.rec)al[i]).sSerID)%>：</span><span><%=((Modelx.rec)al[i]).question%></span></p>
            <%if (((Modelx.rec)al[i]).msg != "")
              {%>
            <p class="text-left" style='font-size:17px;'>
<span class='text-primary'><%=(new Modelx().getPnameBySerID(((Modelx.rec)al[i]).pSerID)).ToString().Substring(0, 1)%>校长：</span><span><%=((Modelx.rec)al[i]).msg%></span></p>
            <br />
            <%}
              else { %><br /><%}
              }
          }%>
        </div>
        <div class="text-center" style='font-size:14px;'>
            <ul class="pagination">
                <%if (pageNow == 0) { pageNow = 1; }
                   if (pageNow != 1)
                   { %>
                <li><a href="Details.aspx?pageNow=<%=pageNow-1 %>&sid=<%=encryption.EnCode(sid.ToString()) %>&pid=<%=encryption.EnCode(pid.ToString()) %>">&laquo;</a></li>
                <%}
               for (int i = 0; i < pageTotal; i++)
               {%>
                <li id="l<%=i+1 %>"><a href="Details.aspx?pageNow=<%=i+1 %>&sid=<%=encryption.EnCode(sid.ToString()) %>&pid=<%=encryption.EnCode(pid.ToString()) %>">
                    <%=i+1 %></a></li>
                <%}
                  if (pageNow < pageTotal)
                  { %>
                <li><a href="Details.aspx?pageNow=<%=pageNow+1 %>&sid=<%=encryption.EnCode(sid.ToString()) %>&pid=<%=encryption.EnCode(pid.ToString()) %>">&raquo;</a></li>
                <%} %>
            </ul>
        </div>
        <hr />
        <br />
    </div>
    <%  string eannounced = Request["announced"];
        string announced = encryption.DeCode(eannounced);
        if (announced == "1")
        {
            //Response.Write("<script>alert('发布成功！');</script>");
            %>
            <script>
                var d = $("#d1");
                var a = $("<div id='myAlert' class='alert alert-success text-center'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>发布成功！</strong></div>");
                a.appendTo(d);
            </script>
            <%
        }
        else if (announced == "0")
        {
            //Response.Write("<script>alert('发布失败！');</script>");
            %>
            <script>
                var d = $("#d1");
                var a = $("<div id='myAlert' class='alert alert-danger text-center'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>发布失败！</strong></div>");
                a.appendTo(d);
            </script>
            <%
        }
        else if (announced == " 4")
        {
            //Response.Write("<script>alert('无问答信息，不能发布！');</script>");
            %>
            <script>
                var d = $("#d1");
                var a = $("<div id='myAlert' class='alert alert-danger text-center'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>无问答信息，不能发布！</strong></div>");
                a.appendTo(d);
            </script>
            <%
        }
        else if (announced == "2")
        {
            //Response.Write("<script>alert('审核未通过，不能发布！');</script>");
                %>
            <script>
                var d = $("#d1");
                var a = $("<div id='myAlert' class='alert alert-danger text-center'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>审核未通过，不能发布！</strong></div>");
                a.appendTo(d);
            </script><%
        }
        else if (announced == "3") { 
            %>
            <script>
                var d = $("#d1");
                var a = $("<div id='myAlert' class='alert alert-danger text-center'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>无校长回复过的问答，不能发布！</strong></div>");
                a.appendTo(d);
            </script><%
        }
    %>
    <script>
        $('.btn-lg').click(function () {
            $(this).button('loading').delay(1000).queue(function () { });
        });
        $("#l<%=pageNow %>").attr("class", "active");
    </script>
</asp:Content>

