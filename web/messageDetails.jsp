
<%@ page import="entity.Notice" %>
<%@ page import="daoImpl.NotiDaoImpl" %>
<%--
  Created by IntelliJ IDEA.
  User: wzzz
  Date: 2017/7/14
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script>
    <title>通知详情</title>
    <%
        String noti_id = request.getParameter("id");
        int noti_ID = Integer.parseInt(noti_id);
        Notice noti;
        NotiDaoImpl notiDao = new NotiDaoImpl();
        noti = notiDao.queryNotiByNoti(noti_ID);
    %>
</head>

<body>
<div>
    <h2>通知标题</h2>
    <p style="padding-left: 20px"><%=noti.getNoti_title()%></p>
    <h2>通知内容</h2>
    <p style="padding-left: 20px"><%=noti.getNoti_content()%></p>
</div>
</body>
</html>
