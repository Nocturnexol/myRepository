<%@ Page Title="" Language="C#" MasterPageFile="master/list_main.master" AutoEventWireup="true" CodeFile="Intro.aspx.cs" Inherits="Intro" %>

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
    <div class="container text-left" style="font-size:large">
    <br />
    <div class="jumbotron">
    <h4 style="font-size:20px;color:#A2A2A2">基本介绍<br /><br /></h4>
        <p style="font-size:17px">我约校长是一个很好的平台，可以为学生们提供与校长进行面对面沟通交流的机会，同时帮助校长了解学生们的情况，拉近了学生们与校长的距离，改善学生们与校长之间传统意义上的关系与理念，给我们一种全新的体验。现在就开始你的预约吧！
    </p>
    <br /><br />
    <p><a class="btn btn-success btn-lg btn-block" href="List.aspx" data-loading-text="请稍候...">开始预约</a></p><br />
    </div>
    </div>
    <script>
        $('.jumbotron').css('background-color', 'rgba(248, 248, 248, 0.8)');
        $("body").css({ "background-color": "#ecf0f0", "background": "url('child.jpg')", "background-repeat": "no-repeat", "width": "100%", "min-height": "800px", "background-attachment": "fixed", "background-size": "1400px 1833px", "background-position": "0px 0px" });
    </script>
</asp:Content>

