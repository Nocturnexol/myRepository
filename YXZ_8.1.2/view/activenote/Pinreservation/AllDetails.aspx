<%@ Page Title="" Language="C#" MasterPageFile="master/list_main.master" AutoEventWireup="true"
    CodeFile="AllDetails.aspx.cs" Inherits="AllDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="lmain" runat="Server">
    <link rel="icon" href="http://www.bestsch.com/bestsch.ico" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/animate.css" rel="stylesheet" />
    <link href="css/spage-style.css" rel="stylesheet" />
    <link href="css/ScreenStyle.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="lcontent" runat="Server">
    <%  
        ArrayList p = (ArrayList)Context.Items["p"];
        ArrayList allApptmt = (ArrayList)Context.Items["allApptmt"];
        ArrayList b = new ArrayList();
        int weeknum = new Modelx().getWeeknum();
        string optflag = encryption.DeCode(Request["optflag"]);
        int optflagint = 0;
        if (optflag == "True") { optflagint = 1; }
        else if (optflag == "False") { optflagint = 2; }
    %>
    <div class="container text-left" style="font-size: large">
        <span class="text-left" style="font-size: 20px; color: #A2A2A2">
            <br />
            预约情况 </span>
        <%--<span class="text-primary" style="font-size:large"><strong>所有校长：</strong></span>--%>
        <span class="pull-right">
            <button id="bo" data-toggle="modal" data-target="#myModal1" class="btn btn-lg btn-warning">
                设置</button>&nbsp;<a role="button" href="AnnouncedQA.aspx" target="_blank" class="btn btn-success btn-lg">
                    已发布的问答</a> <a role="button" href="LoginHandler.ashx?act=<%=encryption.EnCode("logout") %>"
                        class="btn btn-success btn-lg"><span class="glyphicon glyphicon-off" aria-hidden="true"></span>&nbsp;注销</a> </span>
        <br />
        <br />
        <div id="d1">
        </div>
        <%for (int i = 0; i < allApptmt.Count; i++)
          {
              ArrayList apptmt = (ArrayList)allApptmt[i];
              bool bb = true;
              b.Add(bb);
        %>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title text-left" style="font-size: 14px">
                    <%=((Modelx.principal)p[i]).name.ToString().Substring(0, 1)%>校长
                </h3>
            </div>
            <div class="panel-body" style="font-size: 14px">
                <%if (apptmt.Count != 0)
                  { %>
                <p style="font-size: 14px">
                    <ul class="nav nav-tabs">
                        <li id="w<%=i+1 %>" role="presentation" class="active"><a id='wa<%=i+1 %>' style="color: Black;">
                            本周预约</a></li>
                        <li id="h<%=i+1 %>" role="presentation"><a id='ha<%=i+1 %>' style="color: Black;">历史预约</a></li>
                    </ul>
                </p>
                <table id="tb<%=i %>" class="table table-hover" style="table-layout: fixed; font-size: 12px">
                    <thead>
                        <tr>
                            <th class="text-center">
                                <span><strong>学号</strong></span>
                            </th>
                            <th class="text-center">
                                <span><strong>班级</strong></span>
                            </th>
                            <th class="text-center">
                                <span><strong>姓名</strong></span>
                            </th>
                            <th class="text-center">
                                <span><strong>操作时间</strong></span>
                            </th>
                            <th class="text-center">
                                <span><strong>预约周</strong></span>
                            </th>
                            <th class="text-center" colspan="2">
                                <span><strong>操作</strong></span>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                  for (int j = 0; j < apptmt.Count; j++)
                  {
                      Modelx.stuAppt stu = (Modelx.stuAppt)apptmt[j];
                      if (j == 0)
                      {
                          if (stu.weeknum != weeknum)
                          { 
                        %>
                        <h4 id="t<%=i %>0" style="font-size: 14px">
                            <br />
                            暂无学生预约信息。<br />
                            <br />
                        </h4>
                        <script>
                            $('#tb<%=i %>').attr('class', 'hidden');
                            $('#ha<%=i+1 %>').click(function () {
                                $('#tb<%=i %>').attr('class', 'table table-hover');
                            });
                            $('#wa<%=i+1 %>').click(function () {
                                $('#tb<%=i %>').attr('class', 'hidden');
                            });
                        </script>
                        <%
                      b[i] = false;
                  }
                  else if (apptmt.Count == 1)
                  { %>
                        <h4 id="hl<%=i %>" class="hidden" style="font-size: 14px">
                            <br />
                            暂无学生预约信息。<br />
                            <br />
                        </h4>
                        <script>
                            $('#ha<%=i+1 %>').click(function () {
                                $('#tb<%=i %>').attr('class', 'hidden');
                                $('#hl<%=i %>').attr('class', '');
                            });
                            $('#wa<%=i+1 %>').click(function () {
                                $('#tb<%=i %>').attr('class', 'table table-hover');
                                $('#hl<%=i %>').attr('class', 'hidden');
                            });
                        </script>
                        <%
                  }
                       } if ((bool)b[i])
                       {%>
                        <tr id="t<%=i %><%=j %>">
                            <td class="text-center">
                                <%=new Modelx().getStuIDBySerID(stu.SerID)%>
                            </td>
                            <td class="text-center">
                                <%=new Modelx().getClassnameByStuID(new Modelx().getUserIDBySerID(stu.SerID))%>
                            </td>
                            <td class="text-center">
                                <%=stu.StuName%>
                            </td>
                            <td class="text-center">
                                <%=stu.date%>
                            </td>
                            <%--<td class="text-center">
                                <%if (((Model.prst)alprst[i]).status == 0)
                                  { %>
                                <span class="text-muted">等待审核</span>
                                <%}
                                  else if (((Model.prst)alprst[i]).status == 1)
                                  { %>
                                <span class="text-success">已通过</span>
                                <%}
                                  else
                                  { %>
                                <span class="text-danger">审核未通过</span>
                                <%} %>
                            </td>--%>
                            <td class="text-center">
                                第<%=stu.weeknum%>周
                            </td>
                            <td class="text-center" colspan="2">
                                <a href="Details.aspx?type=<%=encryption.EnCode("view") %>&pid=<%=encryption.EnCode(stu.pSerID.ToString())%>&sid=<%=encryption.EnCode(stu.SerID.ToString())%>"
                                    class="btn btn-success btn-sm ld" data-loading-text="请稍候...">查看问答</a> <a href="Handler2.ashx?type=<%=encryption.EnCode("announce") %>&pid=<%=encryption.EnCode(stu.pSerID.ToString())%>&sid=<%=encryption.EnCode(stu.SerID.ToString())%>"
                                        class="btn btn-primary btn-sm ld" data-loading-text="请稍候..." onclick="return confirm('确认发布？');">发布问答</a>
                            </td>
                        </tr>
                        <%}
                      else
                      { %>
                        <tr id="t<%=i %><%=j+1 %>">
                            <td class="text-center">
                                <%=new Modelx().getStuIDBySerID(stu.SerID)%>
                            </td>
                            <td class="text-center">
                                <%=new Modelx().getClassnameByStuID(new Modelx().getUserIDBySerID(stu.SerID))%>
                            </td>
                            <td class="text-center">
                                <%=stu.StuName%>
                            </td>
                            <td class="text-center">
                                <%=stu.date%>
                            </td>
                            <%--<td class="text-center">
                                <%if (((Model.prst)alprst[i]).status == 0)
                                  { %>
                                <span class="text-muted">等待审核</span>
                                <%}
                                  else if (((Model.prst)alprst[i]).status == 1)
                                  { %>
                                <span class="text-success">已通过</span>
                                <%}
                                  else
                                  { %>
                                <span class="text-danger">审核未通过</span>
                                <%} %>
                            </td>--%>
                            <td class="text-center">
                                第<%=stu.weeknum%>周
                            </td>
                            <td class="text-center" colspan="2">
                                <a href="Details.aspx?type=<%=encryption.EnCode("view") %>&pid=<%=encryption.EnCode(stu.pSerID.ToString())%>&sid=<%=encryption.EnCode(stu.SerID.ToString())%>"
                                    class="btn btn-success btn-sm ld" data-loading-text="请稍候...">查看问答</a> <a href="Handler2.ashx?type=<%=encryption.EnCode("announce") %>&pid=<%=encryption.EnCode(stu.pSerID.ToString())%>&sid=<%=encryption.EnCode(stu.SerID.ToString())%>"
                                        class="btn btn-primary btn-sm ld" data-loading-text="请稍候..." onclick="return confirm('确认发布？');">发布问答</a>
                            </td>
                        </tr>
                        <%} %>
                        <%
                  }

              }
                  else
                  {
                        %>
                        <h4 style="font-size: 14px">
                            暂无学生预约信息。</h4>
                        <%} %>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <%
          }%>
        <div class="modal fade" style="font-size: 18px;" id="myModal1" tabindex="-1" role="dialog"
            aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <p class="modal-title text-left" id="myModalLabel">
                            设置
                        </p>
                    </div>
                    <div class="modal-body">
                        <div id='da'>
                        </div>
                        <div>
                            <div class="well well-sm">
                                <p class="help-block" style="font-size: 14px">
                                    温馨提示：该设置功能只需要在第一次使用我约校长功能或者是进入新学期的时候设置一次，以后系统每周会自动进入下一周，无需再重复设置。回退到之前周会<b>清空所有数据</b>，务必谨慎操作。</p>
                            </div>
                            <br />
                            <span id="sp1" style="color: #A2A2A2">本周是第&nbsp;<span id="spw"><strong style="color: Red"><%=weeknum%></strong></span>&nbsp;周&nbsp;
                                <button id="be" class="btn btn-warning btn-sm">
                                修改</button></span> <span id="sp2" style="color: #A2A2A2">本周是第<strong style="color: Red"><input
                                    id="iw" type="text" style="width: 25px; padding-left: 5px" value="<%=weeknum %>" /></strong>周<br />
                                    <span id="spwd">请输入管理员密码：&nbsp;<input type="password" id="ipwd" placeholder="密码" /></span><br />
                                    <a id="ab" class="btn btn-sm btn-success" data-loading-text="请稍候...">确定</a>&nbsp;
                                    <button id="bc" class="btn btn-sm btn-default">
                                        取消</button></span>
                            <br />
                            <br />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <%--<button id="b1" class="btn btn-success">
                        提交
                    </button>--%>
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            关闭
                        </button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal -->
        </div>
    </div>
    <%  string eannounced = Request["announced"];
        string announced = encryption.DeCode(eannounced);
        string sid = Request["sid"];
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
        else if (announced == "4")
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
    </script>
    <%
        }
        else if (announced == "3")
        { 
        
    %>
    <script>
        var d = $("#d1");
        var a = $("<div id='myAlert' class='alert alert-danger text-center'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>无校长回复过的问答，不能发布！</strong></div>");
        a.appendTo(d);
    </script>
    <%
        }
    %>
    <script>
    if(<%=optflagint %>==1){
    var d = $("#d1");
        var a = $("<div id='myAlert' class='alert alert-success text-center'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>设置成功！</strong></div>");
        a.appendTo(d);
    }else if(<%=optflagint %>==2){
    var d = $("#d1");
        var a = $("<div id='myAlert' class='alert alert-danger text-center'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>设置失败！</strong></div>");
        a.appendTo(d);
    }
    $('.ld').click(function () {
            $(this).button('loading').delay(1000).queue(function () { });
        });
    $('#bo').click(function(){
    $('.btn-sm').button('reset');
    $('.alert').remove();
    $('#sp2').hide();
    $('#sp1').show();
    $('#ab').button('reset');
    });
    $('#bc').click(function(){
        $('#sp2').hide();
    $('#sp1').show();
    $('#spwd').hide();
    $('#ipwd').val('');
    $('.alert').remove();
    });
   $('#be').click(function(){
   $('#iw').val(<%=weeknum %>);
   $('#sp1').hide();
   $('#sp2').show();
   $('#spwd').hide();
   });
   $('#ab').click(function(){
   var txt=$('#iw').val();
    if (txt.search("^-?\\d+$") != 0){
        $('.alert').remove();
        var d = $("#da");
        var a = $("<div id='myAlert' class='alert alert-danger text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>请输入一个 1 ~ 30 的正整数！</strong></div>");
        a.appendTo(d);
   }else {
   if(txt>0&&txt<=30){
   if(txt!=<%=weeknum %>){
   if(txt<<%=weeknum %>){ 
   $('#spwd').show();
    var conf=confirm("回退到之前的星期会由于数据间的约束关系导致之前所有预约数据及留言数据消失，请务必慎谨操作！确认继续?");
   if(conf==true){ 
  var pwd=$('#ipwd').val();
  if(pwd=='q123456'){
   $(this).attr('href','Handler2.ashx?type=<%=encryption.EnCode("set") %>&week='+txt);
   $(this).button('loading').delay(1000).queue(function () {});
   }else if(pwd==''){
   $('.alert').remove();
   var d = $("#da");
        var a = $("<div id='myAlert' class='alert alert-warning text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>请输入密码！</strong></div>");
        a.appendTo(d);
   }
   else{
   $('.alert').remove();
   var d = $("#da");
        var a = $("<div id='myAlert' class='alert alert-danger text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>密码错误！</strong></div>");
        a.appendTo(d);
   }
   }
   }else{
   $(this).attr('href','Handler2.ashx?type=<%=encryption.EnCode("set") %>&week='+txt);
   $(this).button('loading').delay(1000).queue(function () {});}
//   $.ajax({
//                        type: "POST",
//                        url: 'Handler2.ashx?type=<%=encryption.EnCode("set") %>&week='+txt,
//                        //data: "txt=" + n,
//                        success: function () {
//                        alert(txt);
//                            location.href = "AllDetails.aspx";
//                        }, //跳转页面
//                        error: function () {
//                            $('.alert').remove();
//                            var d = $("#da");
//                            var a = $("<div id='myAlert' class='alert alert-danger text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>修改失败！</strong></div>");
//                            a.appendTo(d);
//                    }
//                    });

}else{$('.modal').modal('hide');}
   }else{
   $('.alert').remove();
        var d = $("#da");
        var a = $("<div id='myAlert' class='alert alert-danger text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>请输入一个 1 ~ 30 的正整数！</strong></div>");
        a.appendTo(d);
   }
   }
   
   });

    for(var i=1;i<<%=((ArrayList)allApptmt[0]).Count+1 %>;i++){
    $('#t0'+i).attr('class','hidden');
    }
    for(var i=1;i<<%=((ArrayList)allApptmt[1]).Count +1%>;i++){
    $('#t1'+i).attr('class','hidden');
    }
    for(var i=1;i<<%=((ArrayList)allApptmt[2]).Count+1 %>;i++){
    $('#t2'+i).attr('class','hidden');
    }
    for(var i=1;i<<%=((ArrayList)allApptmt[3]).Count +1%>;i++){
    $('#t3'+i).attr('class','hidden');
    }
        $('#ha1').click(function () {
            $('#h1').attr('class', 'active');
            $('#w1').attr('class', '');
            $('#t00').attr('class','hidden');
            for(var i=1;i<<%=((ArrayList)allApptmt[0]).Count +1%>;i++){
              $('#t0'+i).attr('class','table table-hover');
            }
        });
        $('#wa1').click(function () {
            $('#w1').attr('class', 'active');
            $('#h1').attr('class', '');
            $('#t00').attr('class', 'table table-hover');
            for(var i=1;i<<%=((ArrayList)allApptmt[0]).Count +1%>;i++){
              $('#t0'+i).attr('class','hidden');
            }
        });
        $('#ha2').click(function () {
            $('#h2').attr('class', 'active');
            $('#w2').attr('class', '');
            $('#t10').attr('class', 'hidden');
           for(var i=1;i<<%=((ArrayList)allApptmt[1]).Count +1%>;i++){
              $('#t1'+i).attr('class','table table-hover');
            }
        });
        $('#wa2').click(function () {
            $('#w2').attr('class', 'active');
            $('#h2').attr('class', '');
            $('#t10').attr('class', 'table table-hover');
            for(var i=1;i<<%=((ArrayList)allApptmt[1]).Count +1%>;i++){
              $('#t1'+i).attr('class','hidden');
            }
        });
        $('#ha3').click(function () {
            $('#h3').attr('class', 'active');
            $('#w3').attr('class', '');
            $('#t20').attr('class', 'hidden');
            for(var i=1;i<<%=((ArrayList)allApptmt[2]).Count+1 %>;i++){
              $('#t2'+i).attr('class','table table-hover');
            }
        });
        $('#wa3').click(function () {
            $('#w3').attr('class', 'active');
            $('#h3').attr('class', '');
            $('#t20').attr('class', 'table table-hover');
            for(var i=1;i<<%=((ArrayList)allApptmt[2]).Count +1%>;i++){
              $('#t2'+i).attr('class','hidden');
            }
        });
        $('#ha4').click(function () {
            $('#h4').attr('class', 'active');
            $('#w4').attr('class', '');
            $('#t30').attr('class', 'hidden');
            for(var i=1;i<<%=((ArrayList)allApptmt[3]).Count+1 %>;i++){
              $('#t3'+i).attr('class','table table-hover');
            }
        });
        $('#wa4').click(function () {
            $('#w4').attr('class', 'active');
            $('#h4').attr('class', '');
            $('#t30').attr('class', 'table table-hover');
            for(var i=1;i<<%=((ArrayList)allApptmt[3]).Count +1%>;i++){
              $('#t3'+i).attr('class','hidden');
            }
        });
//        $('.ct').click(function () {
//            for (var i = 0; i < 4; i++) {

//                $('#h' + i).attr('class', 'active');
//                $('#w' + i).attr('class', '');
//                //$('#w' + i).attr('class', 'active');
//                //$('#h' + i).attr('class', '');
//            }
//        });
    </script>
</asp:Content>
