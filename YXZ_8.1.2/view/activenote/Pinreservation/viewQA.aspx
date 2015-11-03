<%@ Page Title="" Language="C#" MasterPageFile="master/list_main.master" AutoEventWireup="true" CodeFile="viewQA.aspx.cs" Inherits="viewQA" %>

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
<%ArrayList al =(ArrayList) Context.Items["conv"];
  int pageNow = Convert.ToInt32(Request["pageNow"]);
  int pageTotal = Convert.ToInt32(Context.Items["pageTotal"]);
  string editEn = encryption.EnCode("edit");
  string role0 = encryption.EnCode("0");
  %>
<div class="container" style="font-size:15px">
         <span class="pull-left" style="font-size:20px;color:#A2A2A2"><br />我的问答</span><br />
        <span class="pull-right"><a href="List.aspx" class="btn btn-success btn-lg " data-loading-text="请稍候..."><span class="glyphicon glyphicon-share-alt" aria-hidden="true"></span>&nbsp;返回</a></span><br /><br /><br />
        <div id="dd"></div>
        <div id="d2" class="jumbotron text-left" style='font-size:17px;'>
            <%if (al==null||al.Count == 0)
              { %>
            <h4>
                暂无问答信息。</h4>
            <%}
              else
              {
                  for (int i = 0; i < al.Count; i++)
                  {
                       %>
                       <p style='font-size:17px;'>
                <span class='text-success'>我：</span><span id="s<%=i %>"><%=((Modelx.rec)al[i]).question%></span>
                <span class="pull-right"><button data-toggle="modal" data-target="#myModal1" class="btn btn-success btn-sm" onclick="edit(<%=i %>,<%=((Modelx.rec)al[i]).recID%>)"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>&nbsp;编辑</button>&nbsp;<a href="Handler2.ashx?recID=<%=encryption.EnCode((((Modelx.rec)al[i]).recID).ToString())%>&type=<%=encryption.EnCode("delete") %>&who=<%=encryption.EnCode("0") %>" class="btn btn-danger btn-sm" data-loading-text="请稍候..."><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;删除</a></span>
                  </p>
            <%if (((Modelx.rec)al[i]).msg != "")
              {%>
                  <p style='font-size:17px;'>
                <span class='text-primary'><%=(new Modelx().getPnameBySerID(((Modelx.rec)al[i]).pSerID)).ToString().Substring(0, 1)%>校长：</span><span> <%=((Modelx.rec)al[i]).msg%></span>
                </p><br />
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
                <li><a href="viewQA.aspx?pageNow=<%=pageNow-1 %>">&laquo;</a></li>
                <%}
               for (int i = 0; i < pageTotal; i++)
               {%>
                <li id="l<%=i+1 %>"><a href="viewQA.aspx?pageNow=<%=i+1 %>">
                    <%=i+1 %></a></li>
                <%}
                  if (pageNow < pageTotal)
                  { %>
                <li><a href="viewQA.aspx?pageNow=<%=pageNow+1 %>">&raquo;</a></li>
                <%} %>
            </ul>
        </div>
        <br />
        <div class="modal fade" style="font-size:18px;" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <p class="modal-title" id="myModalLabel">
                        编辑
                    </p>
                </div>
                <div class="modal-body">
                    <div>
                        <textarea style="resize: none;font-size:medium; height:157px; width:503px" id="tx1" rows="5" cols="40"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="b1" class="btn btn-success">
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
    <span id='spi' class="hidden"></span>
        <span id="sph" class="hidden"></span><span id='spc' class='hidden'></span>
</div>
    <script>
        $('.btn-lg').click(function () {
            $(this).button('loading').delay(1000).queue(function () { });
        });
        $('.btn-danger').click(function () {
            $(this).button('loading').delay(1000).queue(function () { });
        });
        $('.btn-lg').fadeTo('fast', 0.9);
        $('li').find('a').fadeTo('fast', 0.8);
        $("body").css({ "background-color": "#ecf0f0", "background": "url('child.jpg')", "background-repeat": "no-repeat", "width": "100%", "min-height": "800px", "background-attachment": "fixed", "background-size": "1400px 1833px", "background-position": "0px 0px" });
        $('.jumbotron').css('background-color', 'rgba(248, 248, 248, 0.8)');
        $("#l<%=pageNow %>").attr("class", "active");
        function edit(i, id) {
            var x = $("#s" + i).html();
            $("textarea").val(x);
            $("#sph").html(id);
            $('#spc').html(x);
            $('#spi').html(i);
            $("#b1").button('reset');
            $('.alert').remove();
        }
        $("#b1").click(function () {
            var j = $("#sph").html();
            var c = $('#spc').html();
            var inum=$('#spi').html();
            var n = $("textarea").val();
            if (n.length >= 6 && n != c) {
                $("#b1").removeAttr("data-dismiss");
                $.ajax({
                    type: "POST",
                    url: 'Handler2.ashx?recID=' + j + '&type=' + '<%=editEn%>' + '&who=' + '<%=role0%>' + '&txt=' + n,
                    success: function () {
                        //location.href = "viewQA.aspx"; 
                        $('#myModal1').modal('hide');
                        $('.alert').remove();
                        var dx = $("#dd");
                        var ax = $("<div id='myAlert1' class='alert alert-success text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>编辑成功！</strong></div>");
                        dx.append(ax);
                        $('.alert').fadeTo('fast', 0.9);
                        $("#s" + inum).html(n);
                    },
                    error: function () {
                        $('.alert').remove();
                        $('#myModal1').modal('hide');
                        var dx = $("#dd");
                        var ax = $("<div id='myAlert2' class='alert alert-danger text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>编辑失败！</strong></div>");
                        dx.append(ax);
                        $('.alert').fadeTo('fast', 0.9);
                    }
                });
                $(this).button('loading').delay(1000).queue(function () {
                    //$(this).button('reset');
                });
            } else if (n.length < 6) {
                $("#b1").attr("data-dismiss", "modal");
                $("#myAlert").remove();
                var d = $("#dd");
                var a = $("<div id='myAlert' class='alert alert-warning' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>请输入至少6个字符！</strong></div>");
                a.appendTo(d);
                $('.alert').fadeTo('fast', 0.9);
            } else if (n == c) {
                $("#myAlert").remove();
                $("#b1").attr("data-dismiss", "modal");
            }
        });
    </script>
</asp:Content>

