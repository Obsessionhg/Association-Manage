<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>大学生社团管理平台</title>
    <link href="css/bootstrap.css"  rel="stylesheet">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        .bg-img{
            background-size:cover;
            background-repeat: no-repeat;
            height: 100%;
            width:100%;
            overflow: hidden;
            position:fixed;
            transform: scale(1);
            transition:all 2s ease;
        }
        .bg-img :hover{
            transform:scale(1.15);
            transition:all 2s ease;
        }

        .sign-up-card{
            /*width:400px;*/
            /*margin: 60px auto;*/
            padding: 30px 50px 30px;
            background-color: rgba(255,255,255,0.9);
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0,0,0,.1);
            vertical-align: middle;
            display: inline-block;
            height:400px;
        }

        .input-group{
            margin: 5px;
        }

        .btn-sign-in{
            background-color: #5cb85c;
            color:white;
        }

        body{
            /*background-color: #f5f5f5;*/
            /*background-image: url(image/campus_1.jpg);*/
            overflow: hidden;
        }

        .form-group input{
            margin:15px 0;
        }
    </style>
    <style>
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
            z-index: 2;
        }
        .navbar{
            /*background-color: #0e00cd;*/
            background-color:rgba(92,184,92,0.2);
            box-shadow: 0 0 8px rgba(0,0,0,1);
        }
        .top-li-item{
            color:white;
            text-decoration: none;
        }
    </style>
</head>
<%
    Object obj = session.getAttribute("uid");
    if(obj!=null){
        response.sendRedirect("club-square.jsp");
    }
%>
<body>
<img src="image/campus_1.jpg" style="position: fixed;width: 100%;overflow: hidden;left:0;top:0" id="bg">
<div class="top-bar">
    <div class="navbar" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand top-li-item" href="#">社团管理系统</a>
            </div>

            <div>
                <ul class="nav navbar-nav pull-right">
                    <li><a class="top-li-item" href="club-square.jsp">社团广场</a></li>
                    <%--这里要加头像--%>
                    <li><a class="top-li-item" href="register.jsp">注册</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>


<div class="container" style="margin-top: 80px">
    <div class="row col-md-4 col-md-offset-4 sign-up-card" style="text-align: center">
        <div class="row" style="margin:0;padding:0;text-align: center">
            <ul class="nav nav-tabs">
                <li class="active">
                    <a href="#panel-user" data-toggle="tab">普通用户登录</a>
                </li>
                <li>
                    <a href="#panel-admin" data-toggle="tab">管理员登录</a>
                </li>
            </ul>

            <div class="tab-content column col-md-12" style="margin-top: 40px">
                <div id="panel-user" class="tab-pane fade in active">
                    <form class="form-group">
                        <input type="text" required="required" id="user-name" class="form-control" placeholder="用户名">
                        <input type="password" required="required" id="user-pwd" id="name" class="form-control" placeholder="姓名">
                        <%--<input type="submit" value="注册">--%>
                        <input type="button" onclick="user_login()"  class="btn btn-sign-in" value="登录">
                        <input type="button" onclick="myback()"  class="btn btn-default" value="返回">
                    </form>
                    <div><a href="register.jsp">还没有账号？点我注册~</a></div>
                </div>

                <div id="panel-admin" class="tab-pane fade">
                    <form class="form-group">
                        <input type="text" class="form-control" id="admin-name" placeholder="管理员用户名">
                        <input type="password" class="form-control" id="admin-pwd" placeholder="管理员密码">
                        <input type="button" onclick="admin_login()"  class="btn btn-sign-in" value="登录">
                        <input type="button" onclick="myback()"  class="btn btn-default" value="返回">
                    </form>
                </div>
            </div>
        </div>
        <div class="row">
            <div  id="alert-list"  class="alert alert-warning" style="display: none;margin-left: 10px;margin-right: 10px;text-align: left">
                <ul>
                    <li id="for-uid-illegal" style="display: none">用户名只能由数字和字母组成，至少包含一个字符且长度应为3-12位</li>
                    <li id="for-uid-dup" style="display: none">用户名已被占用</li>
                    <li id="for-pwd" style="display: none">密码只能由数字和字母组成，且长度应为3-16位</li>
                </ul>
            </div>
        </div>
    </div>

</div>
<script>

    function admin_login(){
        $.ajax({
            data:{
                'user-name':document.getElementById('admin-name').value,
                'user-pwd':document.getElementById('admin-pwd').value,
                'type':'admin'
            },
            url:'/userLoginServlet',//servlet
            success:function(data){
                if(data.toString()=='fail'){
                    alert('fail');
                }else if(data.toString()=='success'){
                    window.location='admin.jsp';
                }
            },error:function () {
                alert('请重试！');
            }
        })
    }

    function user_login(){
        $.ajax({
            data:{
                'user-name':document.getElementById('user-name').value,
                'user-pwd':document.getElementById('user-pwd').value,
                'type':'user'
            },
            url:'/userLoginServlet',//servlet
            success:function(data){
                if(data.toString()=='fail'){
                    alert('fail');
                }else if(data.toString()=='success'){
                    window.location='club-square.jsp';
                }
            },error:function () {
                alert('请重试！');
            }
        })
    }

    $(document).ready(
        function () {
            var width=1.5 * $('#bg').width();
            var height=1.5*$('#bg').height();
            $('#bg').animate({
                width:width,
                height:height,
                left:("-"+(0.5 * $(this).width())/2),
                top:("-"+(0.5 * $(this).height())/2)
            },10000,'linear');
        }
    )
</script>
</body>
</html>
