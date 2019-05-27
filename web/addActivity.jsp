<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加活动</title>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script>
</head>
<script>

//    function mysubmit() {
//        document.forms[0].submit();
//    }

    function myback(org_id) {//返回函数，跳转到活动页面
        location.href="activity.jsp?org_id="+org_id;
        //request.getRequestDispatcher("activity.jsp").forward(request,response);
        //response.sendRedirect("activity.jsp");
    }

</script>
<body onload="isUpdate()">
<span id="op" style="display: none"><%=request.getParameter("op")%></span>
<%--
将数据提交到servlet进行存入数据库操作
--%>

    <div class="container">
        <div class="panel panel-success" style="margin-top: 40px">
            <div class="panel-heading">
                <%
                    String operation=request.getParameter("op");
                    if(operation.equals("add")){
                %>
                    <h2 id="xiugai">新建活动</h2>
                <%}else if(operation.equals("update")){%>
                    <h2 id="xinjian">修改活动</h2>
                <%}%>
            </div>

            <div class="panel-body">
                <form action="actiServlet" class="form-group">
                        <label for="act_title">标题</label>
                        <% if(operation.equals("update")){
                            %>
                        <input class="form-control" type="text" id="act_title" name="act_title" class="form-control" style="width: 200px" placeholder="<%=request.getParameter("title")%>">
                        <%}else{%>
                        <input class="form-control" type="text" id="act_title" name="act_title" class="form-control" style="width: 200px">
                        <%}%>

                            <input  type="hidden" name="id" value=<%=request.getParameter("id")%>>
                            <input  type="hidden" name="op" value=<%=request.getParameter("op")%>>
                            <input  type="hidden" name="org_id" value=<%=request.getParameter("org_id")%>>

                        <label for="act_content">内容</label>
                        <% if(operation.equals("update")){
                        %>
                        <textarea cols="50" rows="10" id="act_content" name="act_content" class="form-control" style="resize: none;" maxlength="1024"><%=request.getParameter("content")%></textarea>
                        <%}else{%>
                        <textarea cols="50" rows="10" id="act_content" name="act_content" class="form-control" style="resize: none;" maxlength="1024"></textarea>
                        <%}%>
                        <input type="submit" class="btn btn-default" value="添加">
                        <input type="button" onclick="myback(<%=request.getParameter("org_id")%>)"  class="btn btn-default" value="返回">
                    </form>

                </div>
        </div>
    </div>
<script>
<%--function isUpdate() {--%>
    <%--document.getElementById("act_title").placeholder="<%=request.getParameter("title")%>";--%>
    <%--document.getElementById("act_content").placeholder="<%=request.getParameter("content")%>";--%>
<%--}--%>
</script>
</body>
</html>