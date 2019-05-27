<%--
  Created by IntelliJ IDEA.
  User: wzzz
  Date: 2017/7/15
  Time: 18:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>创建社团</title>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script>
    <script>
        function mysubmit() {
            document.forms[0].submit();
        }
        function myback() {//返回函数，跳转到活动页面
            location.href="club-square.jsp";
            //request.getRequestDispatcher("activity.jsp").forward(request,response);
            //response.sendRedirect("activity.jsp");
        }
    </script>
</head>
<body>
<h2 style="padding-left: 30px">创建社团</h2>
<div class="container">
    <div class="col-md-offset-1 col-md-6" style="padding-top: 40px">
        <form action="createOrg">
        <table class="table-cell">
            <tr>
                <td>
                    <p>社团名称：</p>
                </td>
                <td>
                    <input maxlength="12" type="text" id="club_name" name="club_name" class="form-control" style="width: 200px">
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    <div>社团简介：</div>
                </td>
                <td>
                    <textarea style="resize: none" cols="50" rows="10" id="club_content" name="club_content"></textarea>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <br>
                    <div>
                        <%--<input type="hidden"  name="uid" value=<%=request.getParameter("uid")%>>--%>
                        <input type="button" onclick="mysubmit()"  class="btn btn-default" value="添加">
                        <input type="button" onclick="myback()"  class="btn btn-default" value="返回">
                    </div>
                </td>
            </tr>
        </table>
        </form>
    </div>
</div>
</body>
</html>
