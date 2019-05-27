<%@ page import="entity.User" %>
<%@ page import="daoImpl.UserDaoImpl" %>
<%@ page import="daoImpl.CommuDaoImpl" %>
<%@ page import="dao.CommuDao" %>
<%@ page import="entity.Org_user" %>
<%@ page import="daoImpl.ComUserDaoImpl" %>
<%@ page import="dao.ComUserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="wzy.CommunitySquare.CommSquare" %>
<%@ page import="entity.Img" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = null;
    UserDaoImpl userDao = new UserDaoImpl();
    String uid=(String)session.getAttribute("uid");
    if(uid!=null) user = userDao.queryUserByUid(uid);
%>
<html>
<head>
    <title>个人信息--<%=user.getUname()%></title>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <%--<script src="js/fileinput.min.js"></script>--%>
    <%--<script src="js/locales/zh.js"></script>--%>
    <%--<link href="css/fileinput-rtl.min.css">--%>
    <%--<link href="css/fileinput.min.css">--%>
    <%--<link href="css/tinybox-style.css" rel="stylesheet">--%>
    <%--<script src="js/tinybox.js"></script>--%>
</head>
<body >
<style>
    body{
        background:url("image/campus_1.jpg")
        /*background-color: transparent;*/
    }
</style>

<style>
    .top-bar{
        position:fixed;
        top:0;
        width:100%;
        z-index: 2;
    }
    .navbar{
        /*background-color: #0e00cd;*/
        background-color:rgba(92,184,92,0.8);
        box-shadow: 0 0 8px rgba(0,0,0,1);
    }
    .top-bar  a{
        color:white;
    }
    .top-bar a:hover{
        font-weight: bold;
        color:white;
    }

    /*清空tab的标签样式*/
    .nav-tabs > li.active > a,
    .nav-tabs > li.active > a:hover,
    .nav-tabs > li.active > a:focus{
        border-left:none;
        border-right:none;
        border-top:none;
        background-color: transparent;
        border-bottom-color: #1b6d85;
        border-bottom-width: 2px;
    }
    .nav-tabs{
        border:none;
    }

    .nav{
        padding-left:20px;
        padding-right:20px;
    }

    /*标签hover背景变色的样式清除*/
    .nav-tabs > li > a:hover{
        border-color: transparent;
    }
    .nav > li > a:hover, .nav > li > a:focus{
        background-color:transparent;
        /*border-bottom-color: #1b6d85;*/
        /*border-bottom-width: 2px;*/
    }
    .top-bar{
        position:fixed;
        top:0;
        width:100%;
        z-index: 3;
    }
    .navbar{
        /*background-color: #0e00cd;*/
        background-color:rgba(92,184,92,0.8);
        box-shadow: 0 0 8px rgba(0,0,0,1);
    }
    .top-li-item{
        color:white;
        text-decoration: none;
    }
    .btn{
        background-color:#b3d76b;
        border-color:#b3d76b;
        color:white;
    }
    .btn-info:focus, .btn-info.focus{
        background-color:#b3d76b;
        border-color:#b3d76b;
        color:white;
    }

    .btn:hover{
        background-color: #a7c965;
        border-color: #a7c965;
        color:white;
    }
    .panel > .panel-heading{
        background-color:#b3d76b;
        color:white;
    }
    .panel,.panel-heading{
        border-color: #b3d76b;
    }

</style>

<%--导航栏--%>
<%@include file="navigator.jsp"%>
<%--内容主题--%>
<div class="container">
    <div class="row col-md-8 col-md-offset-2" style="margin-top: 60px">

    <div class="row panel panel-heading">
        <h4><b>人员信息</b></h4>
    </div>
    <div class="row clearfix">
        <%--<div class="col-md-offset-2 col-md-8" style="padding: 20px 30px 1px 100px">--%>
            <div class="row">
                <div class="col-md-6">
                    <div class="panel panel-success" id="right-info-panel">
                        <div class="panel-heading panel-title">基本信息<a data-target="#alter-info" data-toggle="modal"><i class="fa fa-pencil pull-right"></i></a></div>
                        <div class="panel-body">
                            <%--放头像的区域--%>
                            <div class="row">
                                <div class="col-md-4">
                                    <%
                                        Img user_portrait=CommSquare.getUserImg(user.getUid());
                                        if(user_portrait==null){
                                            %>
                                    <img width="100" height="100" src="image/default-portrait.jpg">
                                    <%
                                        }else{
                                    %>
                                    <img width="100" height="100" src="uploadImg/<%=user_portrait.getImg_name()%>">
                                    <%}%>
                                    <button class="btn btn-primar" data-toggle="modal" data-target="#alter-img">修改头像</button>
                                </div>

                                <div class="col-md-8">
                                    <table class="table">
                                        <tr>
                                            <th>ID</th>
                                            <td><%=user.getUid()%></td>
                                        </tr>
                                        <tr>
                                            <th>姓名</th>
                                            <td><%=user.getUname()%></td>
                                        </tr>
                                        <%--<tr>--%>
                                            <%--<th>密码</th>--%>
                                            <%--<td><%=user.getUpwd()%></td>--%>
                                        <%--</tr>--%>
                                        <tr>
                                            <th>性别</th>
                                            <td><%=user.getSex()%></td>
                                        </tr>
                                        <tr>
                                            <th>生日</th>
                                            <td><%=user.getBirth()%></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="panel panel-success" id="left-info-panel">
                        <div class="panel-heading">我加入的社团</div>
                        <div class="panel-body">
                            <%
                                ComUserDao comuserdao = new ComUserDaoImpl();
                                List<Org_user> list =comuserdao.queryOrgByUid(uid);
                                CommuDao commdao = new CommuDaoImpl();
                                if(list.size()==0){
                            %>你还没有加入任何社团~快去社团广场看看看吧~<%
                        }else{
                        %><ul><%
                            for(int i =0;i<list.size();i++) {
                                Org_user org_user = list.get(i);
//                              System.out.println(org_user.getOrg_id());
//                              System.out.println(commdao.queryCommuByOrg(org_user.getOrg_id()).get(0).getOrg_name());
                        %>
                            <li><a href="outer-frame.jsp?org_id=<%=commdao.queryCommuByOrg(org_user.getOrg_id()).getOrg_id()%>"><%=commdao.queryCommuByOrg(org_user.getOrg_id()).getOrg_name()%></a></li>
                            <%      }
                            %></ul><%
                            }%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <%--</div>--%>
    </div>
</div>

<div class="modal fade" id="alter-info" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <%--<div class="row">--%>
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4>修改个人信息</h4>
                </div>

            <div class="row">
                <div class="modal-body">
                    <div class="col-md-offset-3 col-md-6">
                        <div class="form-group">
                            <form action="Modiperson">
                            <table width="100%">
                                <tr>
                                    <td><label for="uid">ID</label></td>
                                    <td><input type="text" id="uid" value="<%=user.getUid()%>" readonly></td>
                                </tr>
                                <tr>
                                    <td><label for="uid">姓名</label></td>
                                    <td><input type="text" name="name" value="<%=user.getUname()%>"></td>
                                </tr>
                                <tr>
                                    <td><label for="uid">密码</label></td>
                                    <td><input type="password" name="paswd" value="请输入新密码"></td>
                                </tr>
                                <tr>
                                    <td><label for="uid">性别</label></td>
                                    <td><input type="text" name="sex" value="<%=user.getSex()%>"></td>
                                </tr>
                                <tr>
                                    <td><label for="uid">生日</label></td>
                                    <td><input type="text" name="birth" value="<%=user.getBirth()%>"></td>
                                </tr>
                            </table>
                            </form>
                            <%--<label for="uid">简介</label>--%>
                            <%--<input type="textarea" id="uintro" palceholder="<%=user.get%>">--%>
                        </div>
                    </div>
                </div>
            </div>

                <div  id="alert-list"  class="alert alert-warning" style="display:none;margin-left: 10px;margin-right: 10px;text-align: left">
                    <ul>
                        <li id="for-uid-illegal">请输入正确格式:</br>密码必须为3-16位字母或数字</br>性别为男或女<br>日期格式为yyyy-mm-dd</li>
                    </ul>
                </div>
            <%--<div class="row">--%>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="mysubmit()">修改</button>
                </div>
            <%--</div>--%>

        </div>
    </div>
</div>

<div class="modal fade" id="alter-img" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <%--<div class="row">--%>
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4>修改头像</h4>
            </div>
            <%--</div>--%>
            <form action="/servlet/UserImgLoadServlet" method="post" enctype="multipart/form-data">
                <div class="modal-body"><input id="input-img" type="file" class="file" name="img">
                </div>
            <%--<div class="row">--%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <input type="submit" class="btn btn-primary" onclick="mysubmit()">
            </div>
            <%--</div>--%>
            </form>

        </div>
    </div>
</div>
<script>
    //调整panel高度对齐
    var left_height=$('#left-info-panel').height();
    var right_height=$('#right-info-panel').height();
    console.log(left_height);
    console.log(right_height);
    if(left_height>right_height){
        $('#right-info-panel').css('padding-bottom',left_height-right_height);
    }else{
        $('#left-info-panel').css('padding-bottom',right_height-left_height);
    }

    function mysubmit() {
        var pwd=$("input[name='paswd']").val();
        var sex=$("input[name='sex']").val();
        var birth=$("input[name='birth']").val();
        if(pwd.match(/^[a-zA-Z0-9]{3,16}$/)&&sex.match(/^[男女]$/)&&birth.match(/^((((19|20)\d{2})-(0?[13-9]|1[012])-(0?[1-9]|[12]\d|30))|(((19|20)\d{2})-(0?[13578]|1[02])-31)|(((19|20)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|((((19|20)([13579][26]|[2468][048]|0[48]))|(2000))-0?2-29))$/))
            document.forms[0].submit();
        else
            $("#alert-list").show();
    }
</script>

</body>
</html>
