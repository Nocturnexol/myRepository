<%@ Page Title="" Language="C#" MasterPageFile="master/list_main.master" AutoEventWireup="true" CodeFile="pView.aspx.cs" Inherits="view_activenote_Pinreservation_pView" %>

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
<%    int pageNow = Convert.ToInt32(Request["pageNow"]);
      ArrayList al = (ArrayList)Context.Items["al"];
      decimal SerID = Convert.ToDecimal(encryption.DeCode(Request["sid"]));
      decimal pSerID = Convert.ToDecimal(encryption.DeCode(Request["pid"]));
      string editEn = encryption.EnCode("edit");
      string role1 = encryption.EnCode("1");
      int weeknum = new Modelx().getWeeknum();
      string stuWeeknumEn = Request["weeknum"];
      int stuWeeknum = Convert.ToInt32(encryption.DeCode(stuWeeknumEn));
       %>
       <div class="container" style="font-size:17px">
<h4 class="text-left" style="font-size:20px;color:#A2A2A2"><br />学生留言<br /><br /></h4>
        <!--<button class="btn btn-primary btn-lg pull-right" data-toggle="modal" data-target="#myModal1">回复</button>-->
        <div id='dd'></div>
        <div id="d1" class="jumbotron text-left"  style='font-size:17px;'>
        <% 
              if (al==null||al.Count == 0)
              { 
            %>
            <span id="s1">暂无相关留言信息。</span>
            <%              
              }
              else
              {
                  for (int i = 0; i < al.Count; i++)
                  {
                       %>
            <p style='font-size:17px;'>
                <span class='text-primary '><%=new Modelx().getSnameBySerID(SerID)%>：</span><span><%=((Modelx.rec)al[i]).question%></span></p>
            <%
                      if (((Modelx.rec)al[i]).msg != "")
                      { %>
            <p  style='font-size:17px;'>
               <span class='text-success'>我：</span><span id="s<%=i %>"><%=((Modelx.rec)al[i]).msg%></span>
               <span class="pull-right"><button data-toggle="modal" data-target="#myModal1" class="btn btn-success btn-sm su1" onclick="edit(<%=i %>,<%=((Modelx.rec)al[i]).recID%>)"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>&nbsp;编辑</button>&nbsp;<a href="Handler2.ashx?weeknum=<%=stuWeeknumEn%>&recID=<%=encryption.EnCode((((Modelx.rec)al[i]).recID).ToString())%>&sid=<%=encryption.EnCode(SerID.ToString()) %>&pid=<%=encryption.EnCode(pSerID.ToString()) %>&type=<%=encryption.EnCode("delete") %>&who=<%=encryption.EnCode("1") %>" class="btn btn-danger btn-sm su2 ld" data-loading-text="请稍候..."><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;删除</a></span>
               </p>
            <%}
                      else { %>
                      <br />
                      <form action='Handler2.ashx?weeknum=<%=stuWeeknumEn%>&recID=<%=((Modelx.rec)al[i]).recID%>&sSerID=<%=encryption.EnCode(SerID.ToString()) %>&pSerID=<%=encryption.EnCode(pSerID.ToString()) %>&type=<%=encryption.EnCode("insert") %>&who=<%=encryption.EnCode("1") %>' method="post">
                      <!--<span class="pull-right">
                      <input type="text" name="txt1" placeholder="回复..." style="width:241px;height:32px;"/>
                      <input type="submit" class="btn btn-primary" value="回复"></span>-->
                      <div class="col-lg-12 pull-right" style="padding:0 0 0 39px;">
                          <div class="input-group">
                              <input name="txt1" placeholder="回复..." type="text" class="form-control" style=" height:30px"/>
                              <span class="input-group-btn">
                                  <input class="btn btn-primary btn-sm su3 ld" data-loading-text="请稍候..." type="submit" value=" 回复 "/>
                              </span>
                          </div>
                      </div>
                      <br />
                      <br />
                      </form>
                      <% 
                      }
                 %>
                 <br/>
                 <%
                  }  }%>
</div>
        <div class="text-center" style="font-size:14px">
                 <ul class="pagination">
                <% 
                   if (pageNow == 0) { pageNow = 1; }
                   if (pageNow != 1)
                   { %>
                <li><a href="pView.aspx?weeknum=<%=stuWeeknumEn%>&sid=<%=encryption.EnCode(SerID.ToString()) %>&pid=<%=encryption.EnCode(pSerID.ToString()) %>&pageNow=<%=pageNow-1 %>">&laquo;</a></li>
                <%}
               int pageTotal = Convert.ToInt32(Context.Items["pageTotal"]);
               for (int i = 0; i < pageTotal; i++)
               {%>
                <li id="l<%=i+1 %>"><a href="pView.aspx?weeknum=<%=stuWeeknumEn%>&sid=<%=encryption.EnCode(SerID.ToString()) %>&pid=<%=encryption.EnCode(pSerID.ToString()) %>&pageNow=<%=i+1 %>">
                    <%=i+1 %></a></li>
                <%}
                  if (pageNow < pageTotal)
                  { %>
                <li><a href="pView.aspx?weeknum=<%=stuWeeknumEn%>&sid=<%=encryption.EnCode(SerID.ToString()) %>&pid=<%=encryption.EnCode(pSerID.ToString()) %>&pageNow=<%=pageNow+1 %>">&raquo;</a></li>
                <%} %>
            </ul>
                  </div>
                  <hr />
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
                    <button id="b1" class="btn btn-success" data-loading-text="请稍候...">
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
    <span id="spi" class="hidden"></span>
    <span id="sph" class="hidden"></span><span id="spc" class="hidden"></span>
                  </div>
                  <script>
                  $('.ld').click(function () {
            $(this).button('loading').delay(1000).queue(function () { });
        });
                  if(<%=weeknum %>><%=stuWeeknum %>){
                  $('.su1').attr('class','btn btn-sm btn-success disabled');
                  $('.su2').attr('class','btn btn-sm btn-danger disabled');
                  $('.su3').attr('class','btn btn-primary disabled');
                  }
                      $("#l<%=pageNow %>").attr("class", "active");
                      function edit(i,id){
                          var x = $("#s" + i).html();
                          $("textarea").val(x);
                          $("#spc").html(x);
                          $("#sph").html(id);
                          $('#spi').html(i);
                          $("#b1").button('reset');
                          $('.alert').remove();
                      }
                      $("#b1").click(function () {
                          var j = $("#sph").html();
                          var c=$("#spc").html();
                          var inum=$("#spi").html();
                          var n = $("textarea").val();
                          if(n!=c&&n!=''){
                          $('#b1').removeAttr('data-dismiss');
                          $.ajax({
                              type: "POST",
                              url: 'Handler2.ashx?recID=' + j + '&type=' + '<%=editEn %>' + '&who=' + '<%=role1 %>' + '&txt=' + n,
                              success: function () { //location.href = "pView.aspx?weeknum=<%=stuWeeknumEn%>&sid=<%=encryption.EnCode(SerID.ToString()) %>&pid=<%=encryption.EnCode(pSerID.ToString())%>"; 
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
                                      var ax = $("<div id='myAlert1' class='alert alert-danger text-center' style='font-size:17px'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>编辑失败！</strong></div>");
                                      dx.append(ax);
                                      $('.alert').fadeTo('fast', 0.9);
                              }
                          });
                          $(this).button('loading').delay(1000).queue(function () {
                              $(this).button('reset');
                          });
                          }else {
                          $('#b1').attr('data-dismiss','modal');
                          }
                      });
//                     for(var i=0;i<c;i++){
//                      var x = $("#s"+i).html();
//                     var recIndex=i;
//                      $("#bt"+i).click(function () {
//                          $("textarea").html(x);
//                                $.ajax({
//                                type: "POST",
//                               url: 'pView.aspx?recID='+recIndex,
//                               success: function () { alert(recIndex); 
//                               }, 
//                               error: function () { alert("error!"); }
//                            }); 
//                      });
//                      }

//                          $("#b1").click(function(){
//                          var n = $("textarea").val();
//                          var nn = n.split("\n").join("<br />");
//                          if (n!="") {
//                              $.ajax({
//                                type: "POST",
//                               url: 'Handler2.ashx?recID='+'<%=encryption.EnCode(this.getRecID().ToString())%>'+'&type='+'<%=editEn %>'+'&who='+'<%=role1 %>' + '&txt=' + n,
//                               success: function () { alert(<%=this.getRecID() %>);},
//                               error: function () { alert("error!"); }
//                            }); 
//                       }
//                         $("textarea").val("");
//                          });

                      $(function () {
                          $(document).keydown(function (e) {
                              if (e.which == 13 && e.ctrlKey) {
                                  document.getElementById("tx1").value += "\n";
                              } else if (e.which == 13) {
                                  e.preventDefault();
                                  $("#b1").click();
                              }
                          });
                      });
                  </script>
</asp:Content>

