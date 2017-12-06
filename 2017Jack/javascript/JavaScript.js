

//function fnOpenModal() {
//    window.showModalDialog("callee.htm");
//}
function a() {
    //菜单
    var menu = new Object;
    menu.button = new Array[3];

    //子菜单1
    var sub_menu1 = menu.button[0];
    sub_menu1.name = "name1";
    sub_menu1.sub_button = new Array[5];
    //子菜单2
    var sub_menu2 = menu.button[1];
    sub_menu2.name = "name2";
    sub_menu2.sub_button = new Array[5];
    //子菜单3
    var sub_menu3 = menu.button[2];
    sub_menu3.name = "name3";
    sub_menu3.sub_button = new Array[5];

    //子菜单1的项
    var item11 = sub_menu1.sub_button[0];
    item11.name = "item11";
    item11.type = "click";
    item11.key = "item11";
    //var item12 = sub_menu1.sub_button[1];
    //var item13 = sub_menu1.sub_button[2];
    //var item14 = sub_menu1.sub_button[3];
    //var item15 = sub_menu1.sub_button[4];
    //子菜单2的项
    var item21 = sub_menu2.sub_button[0];
    item21.name = "item11";
    item21.type = "click";
    item21.key = "item11";
    //var item22 = sub_menu2.sub_button[1];
    //var item23 = sub_menu2.sub_button[2];
    //var item24 = sub_menu2.sub_button[3];
    //var item25 = sub_menu2.sub_button[4];
    //子菜单3的项
    var item31 = sub_menu3.sub_button[0];
    item31.name = "item11";
    item31.type = "click";
    item31.key = "item11";
    //var item32 = sub_menu3.sub_button[1];
    //var item33 = sub_menu3.sub_button[2];
    //var item34 = sub_menu3.sub_button[3];
    //var item35 = sub_menu3.sub_button[4];
}
    var button = document.getElementById("button");
    button.setAttribute("value", "{\"button\":[{\"type\":\"click\",\"name\":\"今日歌曲\",\"key\":\"V1001_TODAY_MUSIC\"},}");
    button.setAttribute("onclick", "a()");
