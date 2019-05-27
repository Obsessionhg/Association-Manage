<%--
  Created by IntelliJ IDEA.
  User: wzzz
  Date: 2017/7/15
  Time: 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加通知</title>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script>

    <script>
        function mysubmit() {//提交函数,进行参数的检验
            var name_msg=document.getElementById("sid");
            var name=document.forms[0].noti_title;
            name_msg.innerHTML="";

            //判断name和password值不为空 否则警告
            if(name.value.length==0) {
                name_msg.innerHTML = "<font color='red'>*姓名为必填项</font>";
                return;//中断函数
            }

            document.forms[0].submit();
        }
        function myback(org_id) {//返回函数，跳转到活动页面
            location.href="message.jsp?org_id="+org_id;
            //request.getRequestDispatcher("activity.jsp").forward(request,response);
            //response.sendRedirect("activity.jsp");
        }
    </script>
</head>
<body>

<form action="notiServlet">
    <div class="container">
        <h2 id="xinjian">发布新通知</h2>
        <div class="col-md-offset-1 col-md-6" style="padding-top: 40px">
            <table class="table-cell">
                <tr>
                    <td>
                        标题：
                    </td>
                    <td>
                        <input type="hidden"  name="org_id" value=<%=request.getParameter("org_id")%>>
                        <input type="text" id="noti_title" name="noti_title" class="form-control" style="width: 200px">
                        <br>
                    </td>
                    <td>
                        <div ID="sid"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div> 内容：</div>
                    </td>
                    <td>
                        <textarea cols="50" rows="10" id="noti_content" name="noti_content"></textarea>
                    </td>
                </tr>

                <tr>
                   <td>
                        <br>
                        <div>
                            <input type="hidden"  name="op" value=<%=request.getParameter("op")%>>
                            <input type="button" onclick="mysubmit()"  class="btn btn-default" value="添加">
                            <input type="button" onclick="myback(<%=request.getParameter("org_id")%>)"  class="btn btn-default" value="返回">
                        </div>
                    </td>
                </tr>
            </table>
            <br>
        </div>
    </div>
</form>
</body>
</html>
