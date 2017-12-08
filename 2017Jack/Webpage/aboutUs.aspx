<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="aboutUs.aspx.cs" Inherits="_2017Jack.Webpage.aboutUs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>关于我们</title>
    <link href="../css/weui.min.css" rel="stylesheet" />
    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/example.css" rel="stylesheet" />
    <script src="../javascript/JavaScript.js"></script>
    <script src="../javascript/jquery-3.2.1.js"></script>
    <script src="../javascript/jquery.validate.js"></script>

    <style type="text/css">
        .weui_grid {
          position: relative;
          float: left;
          padding: 20px 10px;
          width: 100%;
          box-sizing: border-box;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var validate = $("#form1").validate({
                rules: {
                    suggestion: "required"
                },
                messages: {
                    suggestion: "人家还是空的"
                    
                },
                errorPlacement: function (error, element) {
                 /*   if (element.is(":radio"))
                        error.appendTo(element.parent().next().next());
                    else if (element.is(":checkbox"))
                        error.appendTo(element.next());
                    else
                        error.appendTo(element.parent().next());*/
                    error.appendTo(element.parent().next());
                },

                submitHandler: function () {

                    saveSuggestion();
                    //toast
                    $(function () {
                        var $toast = $('#toast');
                        $('#submit').on('click', function () {
                            if ($toast.css('display') != 'none') return;

                            $toast.fadeIn(50);
                            setTimeout(function () {
                                $toast.fadeOut(50);
                            }, 2000);
                        });
                    });

                },
                success: function (label) {
                    // set &nbsp; as text for IE
                    label.html("&nbsp;").addClass("checked");
                    
                },
                highlight: function (element, errorClass) {
                    $(element).parent().next().find("." + errorClass).removeClass("checked");
                }
            })

        });

        function saveSuggestion()
        {
            $.get("./aboutUs.aspx", { "action": 'saveSuggestion', "suggestion": $("#suggestion").val() }, function (resultString) {
                var resultJson = eval('(' + resultString + ')');

            });
        }


      
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="weui-cells__title">关于我们</div>
        <div class="weui-cell weui-cell_primary">
            <div class="weui-cell__hd weui-cells__tips" >所有权：</div>
            <div class="weui-cell__bd weui-cells__tips">上海师范大学2015级大创_智能插座团队</div>
        </div>
        <div class="weui-cell weui-cell_primary">
            <div class="weui-cell__hd weui-cells__tips">插座设计：</div>
            <div class="weui-cell__bd weui-cells__tips">纪文清、于孙甫、程小镇</div>
        </div>
        <div class="weui-cell weui-cell_primary">
            <div class="weui-cell__hd weui-cells__tips">软件设计：</div>
            <div class="weui-cell__bd weui-cells__tips">李述</div>
        </div>
        <div class="weui-cell weui-cell_primary">
            <div class="weui-cell__hd weui-cells__tips">测试：</div>
            <div class="weui-cell__bd weui-cells__tips">李述</div>
        </div>
        <div class="weui-cell weui-cell_primary">
            <div class="weui-cell__hd weui-cells__tips">您的建议：</div>
            <input id="suggestion" name="suggestion" class="weui-cell__bd weui-input" type="text" placeholder="想说的建议..." />

            <div class="status"></div>
        </div>
               
        <div class="weui-cell weui-cell_primary">
            <input id="submit" type="submit" class="weui-btn weui-btn_plain-primary" value="提交"/>
        </div>
      

        <!--BEGIN toast-->
             <div id="toast" style="display: none;">
                <div class="weui-mask_transparent"></div>
                    <div class="weui-toast">
                        <i class="weui-icon-success-no-circle weui-icon_toast"></i>
                        <p class="weui-toast__content">提交啦</p>
                    </div>
            </div>
    <!--end toast-->
 
    </form>

</body>
</html>
