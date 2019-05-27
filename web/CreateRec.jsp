<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2017/7/16
  Time: 8:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>招新</title>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script>

</head>
<body>
<%--<h2 style="padding-left: 30px">创建招新事件</h2>--%>
<div class="container">
    <div class="col-md-offset-1 col-md-6" style="padding-top: 40px">

            <div class="panel panel-primary">
                <div class="panel-heading">创建招新事件</div>
                <div class="panel-body">
                    <form action="createRec">
                    <table class="table-cell">
                        <tr>
                            <td>
                                <p>招新标题：</p>
                            </td>
                            <td>
                                <input type="text" id="club_name" name="rec_title" class="form-control" style="width: 200px">
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div>招新简介：</div>
                            </td>
                            <td>
                                <textarea cols="50" rows="10" id="club_content" name="rec_content"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <br>
                                <div>
                                    <input type="hidden" name="org_id" value=<%=request.getParameter("org_id")%>>
                                    <input type="submit"   class="btn btn-default" value="添加">

                                </div>
                            </td>
                        </tr>
                    </table>
                    </form>

                </div>
            </div>



    </div>
</div>
<script>


</script>
</body>
</html>
