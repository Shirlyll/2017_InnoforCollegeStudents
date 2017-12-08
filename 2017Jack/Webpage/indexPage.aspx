<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="indexPage.aspx.cs" Inherits="_2017Jack.Webpage.indexPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>初始页</title>
    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/example.css" rel="stylesheet" />
    <link href="../css/weui.min.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">
   <div class="weui-cells">
    <div class="weui-cells__title">个人中心</div>
           <div class="weui-cell">
                <div class="weui-cell__hd">
                    <img src="../image/m.jpg" width="100""/>
                </div> 
                <div class="weui-cell__bd">
                    <div class="weui-cells__tips">name:</div>
                </div>
                <div class="weui-cell__ft">
                    <div class="weui-label weui-cells__tips" >Shirly</div>
                </div>
               
           </div>
           <div class="weui-cell">
               <a href="jackPage.aspx" class="weui-cell__ft weui-msg">
                    ❤ 我的插座
               </a>
           </div>

           <div class="weui-cell">
               <a href="store.aspx" class="weui-cell__ft weui-msg">
                    ❤ 商城
               </a>
           </div>

           <div class="weui-cell">
               <a href="aboutUs.aspx" class="weui-cell__ft weui-msg">
                    ❤ 关于我们
               </a>
           </div>
       </div>

          <a href="javascript;;" class="weui-btn weui-btn_warn ">退出此账号ヾ(･w･)</a>
    </form>

</body>
</html>
