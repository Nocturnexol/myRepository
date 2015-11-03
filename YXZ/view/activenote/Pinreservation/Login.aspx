<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <title>登陆</title>
    <script src="js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container">
<%--<form id="form1" runat="server" action="LoginHandler.ashx?act=login">
    <div class="col-md-6">
    <table class="table" border="0" style="table-layout: fixed; border:0;" >
                    <caption class="text-center">
                    用户登录
                    </caption>
                    <thead>
                        <tr>
                            <th class="text-center">
                            </th>
                            <th class="text-center">
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="text-center">
                                <span class=" pull-right" >用户名：</span>
                            </td>
                            <td>
                            <input type="text" name="uid" placeholder="用户名"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-right">
                                <span class=" pull-right">密码：</span>
                            </td>
                            <td class="text-left">
                               <input type="password" name="pwd" placeholder="密码"/>
                            </td>
                        </tr>
                        <tr>
                        <td class="text-right"><input type="submit" class="btn btn-default" /></td><td><input type="reset" class="btn btn-default" /></td>
                        </tr>
                       <%-- <% HttpCookie cookie = new HttpCookie("user");
                           cookie.Values.Add("UID", "T104");
                           cookie.Values.Add("UserType", "T");
                           Response.AppendCookie(cookie);
                            
                        <tr><td class="text-right"><a href="AccessHandler.ashx" class="btn btn-success">login</a></td></tr>
                    </tbody>
                </table>
    </div>
    </form>--%>
    <br /><br /><br />
    <div class="form-group">
            <label for="recipient-name" class="control-label" style="font-size:17px">User ID:</label>
            <input type="text" class="form-control" id="uid" placeholder="User ID"><br />
          </div>
    <div class="col-offset-4"><a class="btn btn-default btn-lg btn-block" disabled="disabled" href="#" id="s">Student</a>&nbsp;
    <a class="btn btn-success btn-block btn-lg"  disabled="disabled" href="#" id="t">Principal</a>&nbsp;
    <a class="btn btn-primary btn-block btn-lg" disabled="disabled" href="#" id="m">Administrator</a>&nbsp; </div>
       
    <div class="modal fade" id="myModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
        <h4 class="modal-title" id="exampleModalLabel">Password Required</h4>
      </div>
      <div class="modal-body">
      <div id='dx'></div>
        <form>
          <div class="form-group">
            <label for="recipient-name" class="control-label" style="font-size:17px">Input password:</label>
            <input type="password" class="form-control" id="pwd" placeholder="Password">
          </div>
          <%--<div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div>--%>
        </form>
      </div>
      <div class="modal-footer">
        <%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
        <button type="button" class="btn btn-primary" id="bv">Validate</button>
      </div>
    </div>
  </div>
</div>

        </div>
        <script>
            $('#myModal').modal({
                keyboard: false
            });
            $('#myModal').modal('show');
            $('#bv').click(function () {
                var pwd = $('#pwd').val();
                if (pwd == '...') {
                    $('.alert').remove();
                    $('#myModal').modal('hide');
                } else {
                    $('#pwd').val('');
                    $('.alert').remove();
                    var d = $("#dx");
                    var a = $("<div id='myAlert' class='alert alert-danger text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>Invalidate password！</strong></div>");
                    a.appendTo(d);
                }
            });
            $('div').mouseover(function () {
                var t = $('#uid').val();
                if (t != '') {
                    $('a').removeAttr("disabled");
                } else {
                    $('a').attr("disabled", "disabled");
                }
            });
            $('#s').click(function () {
                var uid = $('#uid').val();
                $('#s').attr('href', 'Intro.aspx?UserID='+uid);
            });
            $('#t').click(function () {
                var uid = $('#uid').val();
                $('#t').attr('href', 'pList.aspx?UserID=' + uid);
            });
            $('#m').click(function () {
                var uid = $('#uid').val();
                $('#m').attr('href', 'AllDetails.aspx?UserID=' + uid);
            });
            $(document).keydown(function (e) {
                if (e.which == 13) {
                    e.preventDefault();
                    $('#bv').click();
                }
            });
        </script>
</body>
</html>
