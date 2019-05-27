<%@ page import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新建活动</title>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script>
</head>
<script>
    function mysubmit() {//提交函数,进行参数的检验
        var name_msg=document.getElementById("sid");
        var password_msg=document.getElementById("pid");
        var name=document.forms[0].uname;
        var password=document.forms[0].upwd;
        name_msg.innerHTML="";
        password_msg.innerHTML="";

        //判断name和password值不为空 否则警告
        if(name.value.length==0) {
            name_msg.innerHTML = "<font color='red'>*姓名为必填项</font>";
            return;//中断函数
        }
        if(password.value.length==0) {
            password_msg.innerHTML = "<font color='red'>*密码为必填项</font>";
            return;//中断函数
        }
        document.forms[0].submit();
    }
    function myback() {//返回函数，跳转到活动页面
        location.href="activity.jsp";
        //request.getRequestDispatcher("activity.jsp").forward(request,response);
        //response.sendRedirect("activity.jsp");
    }
</script>
<body>
<%--
将数据提交到servlet进行存入数据库操作
--%>
<form action="#" method="post">
    <div class="container">
        <h2>新建活动</h2>
        <div class="col-md-offset-1 col-md-6 input-group" align="center" style="padding-top: 40px">
            <div class="row" style="margin-bottom: 20px">

            </div>
            <table class="table-cell">
                <tr>
                    <td>
                        姓名：
                    </td>
                    <td>
                        <input type="text" id="uname" name="uname" class="form-control">
                    </td>
                    <td>
                        <div ID="sid"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        密码：
                    </td>
                    <td>
                        <input type="text" id="upwd" name="upwd" class="form-control">
                    </td>
                    <td>
                        <div ID="pid"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="usex">性别:</label><br>
                    </td>
                    <td>
                        <input type="radio" id="usex" name="usex" value="男" checked="checked">男
                        <input type="radio" name="usex" value="女">女<br>
                    </td>
                </tr>
            <tr>
                <td>
                    生日：
                </td>
                <td>
                    <input type="text" id="ubirth" name="ubirth" class="form-control">
                </td>
            </tr>
            </table>
            <br>
            <div>
                <button onclick="mysubmit()"  class="btn btn-default">添加</button>
                <button onclick="myback()" type="button" class="btn btn-default">返回</button>
            </div>
        </div>
    </div>
</form>

</body>
</html>