<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jackPage.aspx.cs" Inherits="_2017Jack.Webpage.jackPage" %>

 
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>插座信息</title>

    <link href="../css/example.css" rel="stylesheet" type="text/css" />
    <link href="../css/weui.css" rel="stylesheet" type="text/css" />
    <link href="../css/example.css" rel="stylesheet" type="text/css" />
    <script src="../javascript/JavaScript.js" type="text/javascript"></script>
    <script src="../javascript/jquery-3.2.1.js"></script>
    <script src="../javascript/jquery.cookie.js"></script>

    
    <link href="../javascript/jquery-ui-1.7.3.custom.css" rel="stylesheet" />
    <script src="../javascript/zn_datepicker.js"></script>
    <script src="../javascript/ui.datepicker.js"></script>
    <script src="../javascript/jquery-1.3.2.min.js"></script>
    <script src="../javascript/jquery-weui.min.js"></script>

    <script type="text/javascript">
        $(function () {

            var $androidActionSheet = $('#androidActionsheet');
            var $androidMask = $androidActionSheet.find('.weui-mask');
            $("#showAndroidActionSheet").on('click', function () {
                $androidActionSheet.fadeIn(200);
                $androidMask.on('click', function () {
                    $androidActionSheet.fadeOut(200);
                });
            })
            //重命名dialog
            var $androidDialog1 = $('#androidDialog1');
            
            $('#dialogs').on('click', '.showdialog', function () {
                $(this).parents('.js_dialog').fadeOut(200);
            });

            $('#showdialog').on('click', function () {
                $androidDialog1.fadeIn(200);
            });

            $('#cancel','#confirm').on('click', function () {
                $androidDialog1.fadeOut(200);
            });


        });

    

        function initial() {

            $.get("./jackPage.aspx", { "action": "initial" }, function (resultString) {
                var resultJson = eval('(' + resultString + ')');
                if (resultJson.errcode == "0") {
                    var ShowJnameArray = resultJson.ShowJnameRecords;
                    var htmlString = "<div class='weui-actionsheet__menu'>";
                    $(ShowJnameArray).each(function (index, ShowJnameRecord) {
                        htmlString += "<div class='weui-actionsheet__cell'id='jack_" + ShowJnameRecord.id + "' onclick='showJackInfor(" + ShowJnameRecord.id+");'>";
                        htmlString += ShowJnameRecord.JackName + "</div>";
                    });
                    htmlString += "</div>";
                    $("#menu_list").html(htmlString);
                }
                //错误
                else
                {
                    alert("error");
                }
            });
         }
        function showJackInfor(JackId) {
            //quit the action sheet
            $("#jack_" + JackId).on('click', function () {
                $("#androidActionsheet").hide();
            });
            //get the jackinfor by id
            $.get("./jackPage.aspx", { "action": "showJackInfor", "JackId": JackId }, function (resultString) {
                //alert(ShowJackInforRecord.operateTime)
                var resultJson = eval('(' + resultString + ')');
                if (resultJson.errcode == "0") {
                    var ShowJackInforArray = resultJson.ShowJackInforRecords;
                    $(ShowJackInforArray).each(function (index, ShowJackInforRecord) {
                        $("#JackName").html(ShowJackInforRecord.JackName);
                        $("#JackType").html(ShowJackInforRecord.JackType);
                        $("#JackId").html(ShowJackInforRecord.id);
                        if (ShowJackInforRecord.LinkState == "1") {
                            $("#LinkState").html("已经连接啦");
                        }
                        else {
                            $("#LinkState").html("连接丢失啦哭唧唧");
                        }
                        if (ShowJackInforRecord.WorkState == "1") {
                            $("#WorkState").html("工作中");
                        }
                        if (ShowJackInforRecord.WorkState == "0")
                        {
                            $("#WorkState").html("休息中");
                        }
                        if (ShowJackInforRecord.IsWaiting == "1")
                        {
                            $("#operateTime").html(ShowJackInforRecord.operateTime);
                        }
                    });
                }
            });
        }
        function submitChange() {
            if ($("#WorkState").html() == "工作中") {
                WorkState = "1";
            }
            else {
                WorkState = "0";
            }
            waitingTime = $('input:radio:checked').val();
            $.get("./jackPage.aspx", { "action": "submitChange", "JackId": $("#JackId").html(), "WorkState": WorkState, "waitingTime": waitingTime });
            showJackInfor($("#JackId").html());

        }
        function getName() {
            $('#androidDialog1').fadeOut(200);
            JackName = $("#newName").val();
            $.get("./jackPage.aspx", { "action": "saveName", "JackId": $("#JackId").html(), "JackName": JackName });
            showJackInfor($("#JackId").html());
        }
  
    </script>
</head>
<body>
  <form id="form1" runat="server">
        <div class="weui-cells">

            <div class="weui-cells__title">我的插座信息</div>

                <a href="javascript:;" class=" weui-cell weui-cell__ft weui-msg" id="showAndroidActionSheet" onclick="initial();">选择插座</a>
          
             <div class="weui-cell">
                 <div class="weui-cell__hd">插座名称</div>
                 
                 <div class="weui-cells__tips weui-cell__ft weui-cell__primary weui-label" id="JackName"></div>  
             </div>
             <div class="weui-cell">
                 <div class="weui-cell__hd">插座型号</div>
                 <div class="weui-cells__tips weui-cell__ft weui-cell__primary weui-label" id="JackType"></div>
             </div>
             <div class="weui-cell">
                 <div class="weui-cell__hd">连接状态</div>
                 <div class="weui-cell__ft">
                     <div class="weui-label weui-cells__tips " id="LinkState"></div>
                 </div>
             </div>

            <div class="weui-cell">
                 <div class="weui-cell__hd">开断状态</div>
                 <div class="weui-cells__tips weui-cell__ft weui-label" id="WorkState"></div>
             </div>
            <div class="weui-cell">
                 <div class="weui-cell__hd" >预定转换时间</div>
                 <div class="weui-cells__tips weui-cell__ft weui-label" id="operateTime"></div>
             </div> 
            <!--JackId 藏在这里-->
            <div class="weui-cell" style="display:none">
                 <div class="weui-cell__hd" ></div>
                 <div class="weui-cells__tips weui-cell__ft weui-label" id="JackId"></div>
             </div> 

         </div>

         <div class="weui-cells weui-cells_radio">
            <label class="weui-cell weui-check__label" for="after0">
                <div class="weui-cell__bd">
                    <p>立即</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="radio1" id="after0" value="0" />
                    <span class="weui-icon-checked"></span>
                </div>
            </label>

            <label class="weui-cell weui-check__label" for="after30">
                <div class="weui-cell__bd">
                    <p>30分钟后</p>
                </div>
                <div class="weui-cell__ft">
                <!-- 注意checked属性，可以获取checked属性的值判断是否被选择 -->
                    <input type="radio" name="radio1" class="weui-check" id="after30" checked="checked" value="30"/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
   


 
           <div class="weui-cell">
               <div class="weui-cell__bd">
                     <a href="javascript:;" class="weui-btn weui-dialog__btn" id="submitChange" onclick="submitChange();">ON/OFF</a>                
               </div>
           </div>
           <div class="weui-cell">
               <div class="weui-cell__bd">
                    <a href="javascript:;" class="weui-btn weui-dialog__btn" id="showdialog">重命名</a>
               </div>
           </div>

             </div>




     
       <!-- change Jack 菜单 原版 -->
                <div class="weui-skin_android" id="androidActionsheet" style="display: none">
                    <div class="weui-mask"></div>
                    <div class="weui-actionsheet" id="menu_list">
            <!-- 
                           <div class="weui-actionsheet__cell" id="menu1"></div>
                           <div class="weui-actionsheet__cell" id="menu2">示例菜单</div>
                              
           菜单 -->   
                        </div>
                    </div>
                    
               

      

        <!--BEGIN dialog-->
        <div class="js_dialog" id="androidDialog1" style="display: none;">
            <div class="weui-mask"></div>
            <div class="weui-dialog">
                <div class="weui-dialog__hd"><strong class="weui-dialog__title">起一个新名字ღ( ´･ᴗ･` )</strong></div>
                <div class="weui-dialog__bd">
                    <input class="weui-input" id="newName" placeholder="叫什么呢(๑･w･๑)" />
                </div>
                <div class="weui-dialog__ft">
                    <a href="javascript:;" class="weui-dialog__btn default" id="confirm" onclick="getName();">起好啦</a>
                    <a href="javascript:;" class="weui-dialog__btn primary" id="cancel">不换啦</a>
                </div>
            </div>
        </div>
        <!--END dialog-->

     
    </form>

</body>
</html>
