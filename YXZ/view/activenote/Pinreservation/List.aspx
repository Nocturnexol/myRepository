<%@ Page Title="" Language="C#" MasterPageFile="master/list_main.master" AutoEventWireup="true"
    CodeFile="List.aspx.cs" Inherits="List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="lmain" runat="Server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="lcontent" runat="Server">
    <% 
        string aptflagEn = Request["aptflag"];
        int aptflag=Convert.ToInt32(encryption.DeCode(aptflagEn));
        Modelx.stuAppt stu = new Modelx.stuAppt();
         int weeknum=Convert.ToInt32(Context.Items["weeknum"]);
        //conversation arraylist
        ArrayList al = (ArrayList)Context.Items["al"];
        //principal arraylist
        ArrayList al1 = (ArrayList)Context.Items["al1"];
        ArrayList al2 = (ArrayList)Context.Items["al2"];
        stu = (Modelx.stuAppt)Session["stu"];
        int weekleft = Convert.ToInt32(Context.Items["weekleft"]);
    %>
    <div class="container text-left" style="font-size: large">
        <h5 class="text-left" style="font-size: 20px; color: #A2A2A2">
            <br />
        </h5>
        <!--<span class="pull-right text-success" style="font-size: x-large">欢迎你，<=stu.StuName %>同学。<br /><br /></span>-->
        <!-- <span class="text-primary pull-left" style="font-size: x-large"><strong>我的校长</strong></span><br />-->
        <!--<a href="LoginHandler.ashx?act=<=encryption.EnCode("logout") %>" class="btn btn-success btn-lg  pull-right">注销</a>-->
        <%if (stu.semavail == 1&&stu.SerID!=0)
          {
              if (weekleft > 0)
              {
        %>
        <a class="btn btn-danger btn-lg pull-left" title="点击预约校长" data-toggle="modal" data-target="#myModal2">
            我要预约</a>
        <%
              }
              else
              { 
        %>
        <button id="btn1" class="btn btn-danger btn-lg pull-left" data-toggle="tooltip" data-placement="bottom"
            title="本周名额已用完">
            我要预约</button>
        <%
              }
          }
          else
          { %>
        <button class="btn btn-lg disabled pull-left" data-toggle="tooltip" data-placement="top"
            title="本學期名額已使用">
            我要预约</button>
        <%} %>
        <span class="pull-right"><a href="LoginHandler.ashx?act=<%=encryption.EnCode("logout") %>"
            class="btn btn-success btn-lg"><span class="glyphicon glyphicon-off" aria-hidden="true"></span>&nbsp;注销</a> </span>
        <br />
        <br />
        <br />
        <%
        if(stu.SerID!=0){
      if(stu.weeknum==weeknum){
        if (stu.semavail == 0)
          { %>
        <div id="dd">
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title text-left" style="font-size: 14px">
                    预约列表
                </h3>
            </div>
            <div class="panel-body">
                <table class="table table-responsive" style="table-layout: fixed; font-size: 12px">
                    <thead>
                        <tr>
                            <th class="text-center">
                                <strong>校长</strong>
                            </th>
                            <th class="text-center">
                                <strong>所属校区</strong>
                            </th>
                            <th class="text-center">
                                <strong>操作时间</strong>
                            </th>
                            <%-- <th class="text-center">
                                审核状态
                            </th>--%>
                            <th class="text-center" colspan="2">
                                <strong>操作</strong>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <%
                            if(stu.pSerID!=0){%>
                            <td class="text-center">
                                <span>
                                    <%=new Modelx().getPnameBySerID(stu.pSerID).ToString().Substring(0, 1)%>校长</span>
                            </td>
                            <%}else {%>
                            <td>
                            </td>
                            <%} %>
                            <td class="text-center">
                                <%= new Modelx().getPdistrictBySerID(stu.pSerID)%>
                            </td>
                            <td class="text-center">
                                <span>
                                    <%=stu.date%></span>
                            </td>
                            <%--<td class="text-center">
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
                                <%}%>
                            </td>--%>
                            <td class="text-center" colspan="2">
                                <a data-toggle="modal" data-target="#myModal1" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-comment" aria-hidden="true"></span>&nbsp;我要提问</a>
                                <a href="Handler1.ashx?opt=<%=encryption.EnCode("cancel") %>&val=<%=encryption.EnCode(stu.pSerID.ToString() )%>"
                                    class="btn btn-success btn-sm" data-loading-text="请稍候..." onclick="return confirm('确定取消预约？');"><span class="glyphicon glyphicon-ban-circle" aria-hidden="true"></span>&nbsp;取消预约</a>
                                <a href="viewQA.aspx?sid=<%=encryption.EnCode(stu.SerID.ToString()) %>&pid=<%=encryption.EnCode(stu.pSerID.ToString()) %>"
                                    class="btn btn-info btn-sm" data-loading-text="请稍候..."><span class="glyphicon glyphicon-search" aria-hidden="true"></span>&nbsp;查看问答</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td class="text-center">
                            </td>
                            <td>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <%}
          else
          {%>
        <div id="d2">
        </div>
        <div class="jumbotron">
            <h4>
                您还没有预约任何校长。</h4>
        </div>
        <%} }
        else {
        %>
        <div class="jumbotron text-left">
            <h4>
                本学期名额已经使用。</h4>
        </div>
        <%
        }
        }else{%>
        <div class="jumbotron text-left">
            <h4>
                您不是学生，请登陆相应页面进行操作。</h4>
        </div>
        <%}
        
        
        /*if (stu.semavail == 0)
          {%>
        <!--   <div id="d1" class="well">
            <% 
              if (al.Count == 0)
              { 
            %>
            <span id="s1" class='text-info ' style='font-size: x-large; font-style: inherit'>暂无相关留言信息。</span>
            <%              
              }
              else
              {
                  for (int i = 0; i < al.Count; i++)
                  {
                      %>
            <p>
                <span class='text-success ' style='font-size: x-large; font-style: inherit'>我：</span><span
                    style='font-size: x-large; font-style: inherit'><%=((Model.rec)al[i]).question%></span></p>
           

            <%
                      if (((Model.rec)al[i]).msg!="")
                      { %>
            <p class="text-right">
                <span style='font-size: x-large; font-style: inherit'>
                    <%=((WebApplication4.Model.rec)al[i]).msg%>
                </span><span class='text-primary' style='font-size: x-large; font-style: inherit'>：<%=new Model().getPnameBySerID(((WebApplication4.Model.rec)al[i]).pSerID).ToString().Substring(0,1)%>校长</span></p>-->
        <%}
                  }
              }%>
    </div>
    <%} */%>
    </div>
    <!--Question Modal-->
    <div class="modal fade" style="font-size: 18px;" id="myModal1" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <p class="modal-title" id="myModalLabel">
                        提问
                    </p>
                </div>
                <div class="modal-body">
                    <div>
                        <textarea style="resize: none; font-size: medium; height: 157px; width: 503px" id="tx1"
                            rows="5" cols="40"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="b1" class="btn btn-primary" data-dismiss="modal">
                        提交
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        关闭
                    </button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
    <!--Appointment Modal-->
    <div class="modal fade text-left" style="font-size: 14px;" id="myModal2" tabindex="-1"
        role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h3 class="modal-title" id="H1">
                        <span style="font-size: 18px">我要预约</span>
                    </h3>
                </div>
                <div class="modal-body">
                    <div>
                        <div>
                            <table id="tb1" class="table text-left" style="table-layout: fixed; font-size: 14px">
                                <thead>
                                    <tr>
                                        <th class="text-center">
                                            <p>
                                                <strong>江锦校区</strong></p>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < al1.Count; i++)
                                      { %>
                                    <tr>
                                        <td>
                                            <%=((Modelx.principal)al1[i]).name.ToString().Substring(0, 1)%>校长 <a href="Handler1.ashx?opt=<%=encryption.EnCode("apptmt") %>&val=<%=encryption.EnCode((((Modelx.principal)al1[i]).SerID).ToString()) %>"
                                                class="btn btn-success pull-right" data-loading-text="Loading...">预约</a>
                                            <!--<button id="buttn1"  class="btn btn-success pull-right l"  data-loading-text="Loading...">预约</a>-->
                                        </td>
                                    </tr>
                                    <%} %>
                                </tbody>
                            </table>
                        </div>
                        <div>
                            <table id="tb2" class="table" style="table-layout: fixed; font-size: 14px">
                                <caption>
                                </caption>
                                <thead>
                                    <tr>
                                        <th class="text-center">
                                            <p>
                                                <strong>采荷校区</strong></p>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < al2.Count; i++)
                                      { %>
                                    <tr>
                                        <td>
                                            <%=((Modelx.principal)al2[i]).name.ToString().Substring(0, 1)%>校长 <a id="a2" type="button"
                                                href="Handler1.ashx?opt=<%=encryption.EnCode("apptmt")%>&val=<%=encryption.EnCode((((Modelx.principal)al2[i]).SerID).ToString())%>"
                                                class="btn btn-success pull-right" data-loading-text="Loading...">预约</a>
                                        </td>
                                    </tr>
                                    <%} %>
                                </tbody>
                            </table>
                        </div>
                        <!-- </form>-->
                        <br />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            关闭
                        </button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal -->
        </div>
        <%if(al1.Count==0){ %>
        <script>
            $("#tb1").hide();
        </script>
        <%} 
                        if(al2.Count==0){%>
        <script>
            $("#tb2").hide();
        </script>
        <%} %>
        <script>
        $('.btn-info').click(function(){$(this).button('loading').delay(1000).queue(function () {});});
        $('.btn-sm.btn-success').click(function(){$(this).button('loading').delay(1000).queue(function () {});});
            //$(function () { $("[data-toggle='tooltip']").tooltip(); });
            $("body").css({ "background-color": "#ecf0f0", "background": "url('child.jpg')", "background-repeat": "no-repeat", "width": "100%", "min-height": "800px", "background-attachment": "fixed", "background-size": "1400px 1833px", "background-position": "0px 0px" });
            $('.panel').css('background-color', 'rgba(248, 248, 248, 0.8)');
            $('tr').css('background-color', 'rgba(248, 248, 248, 0.4)');
            $('th').css('background-color', 'rgba(248, 248, 248, 0.4)');
            $('.btn-lg').fadeTo('fast', 0.9);
            $('.jumbotron').fadeTo('fast', 0.9);
            $('.btn-primary').click(function(){$('.alert').remove();});
            $("#btn1").click(function () {
                //alert("本週預約名額已經用完啦，請下周再試！");
                $(".alert").remove();
                var d = $("#d2");
                var a = $("<div id='myAlert' class='alert alert-danger text-center'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>预约失败，本周名额已用完，请下周再试！</strong></div>");
                a.appendTo(d);
                $('.alert').fadeTo('fast', 0.9);
            });
            $("#b1").click(function () {
                var n = $("textarea").val();
                var l = n.length;
                var nn = n.split("\n").join("<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                var divObj = $("#d1");
                if (l >= 6) {
                    $.ajax({
                        type: "POST",
                        url: 'Handler2.ashx?sSerID=' + '<%=encryption.EnCode(stu.SerID.ToString()) %>' + '&pSerID=' + '<%=encryption.EnCode(stu.pSerID.ToString()) %>' + '&type=' + '<%=encryption.EnCode("insert") %>' + '&who=' + '<%=encryption.EnCode("0") %>' + '&txt=' + n,
                        //data: "txt=" + n,
                        success: function () {
                            location.href = "viewQA.aspx?sid=" + "<%=encryption.EnCode(stu.SerID.ToString()) %>" + "&pid=" + "<%=encryption.EnCode(stu.pSerID.ToString()) %>";
                        }, //跳转页面
                        error: function () {
                            var d = $("#dd");
                            var a = $("<div id='myAlert' class='alert alert-danger text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>提交失败！</strong></div>");
                            a.appendTo(d);
                            $('.alert').fadeTo('fast', 0.9);
                    }
                    });
                    // var chat = $("<p><span class='text-success popover-toggle' id='sp1' style='font-size: x-large; font-style: inherit' data-container='body' data-toggle='popover' data-content='<h4>123</h4>' data-placement='right' data-html='true'>我：</span></p><br/>");
                    // var chat = $("<p><a href='#' class='text-success ' id='sp1' rel='popover' style='font-size: x-large; font-style: inherit' data-container='body'  data-content='<h4>123</h4>' data-placement='right' data-html='true'>我：</a></p><br/>");
                    //$("#s1").remove();
                    //var chat = $("<p><span class='text-success '  style='font-size: x-large; font-style: inherit'>我：</span><span  style='font-size: x-large; font-style: inherit'>" + nn + "</span></p><br/>");
                    //chat.appendTo(divObj);
                    //$("#sp1").attr("data-content", n);
                    // $(function () {
                    //   $("#sp1").popover('toggle');
                    // });
                    //$("#sp1").attr("id", "deserted");
                } else {
                    $(".alert").remove();
                    var d = $("#dd");
                    var a = $("<div id='myAlert' class='alert alert-warning text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>请输入至少6个字符！</strong></div>");
                    a.appendTo(d);
                    $('.alert').fadeTo('fast', 0.9);
                }
                //$("textarea").val('');
            });
                $("#myModal2").find("a").click(function () {
                    $(this).button('loading').delay(1000).queue(function () {
                        // $(this).button('reset');
                    });
                });
                $(document).keydown(function (e) {
                    if (e.which == 13 && e.ctrlKey) {
                        document.getElementById("tx1").value += "\n";
                        //$("#tx1").val() += "\n";
                    } else if (e.which == 13) {
                        e.preventDefault();
                        $("#b1").click();
                    }
                });
    if(<%=aptflag%>==635653084){
        var dx = $("#dd");
        var ax = $("<div id='myAlert1' class='alert alert-success text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>预约成功！</strong></div>");
        dx.append(ax);
        $('.alert').fadeTo('fast', 0.9);
        }
        </script>
</asp:Content>
