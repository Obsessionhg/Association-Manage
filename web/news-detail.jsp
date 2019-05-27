<%@ page import="wzy.CommunitySquare.CommSquare" %>
<%@ page import="entity.News" %>
<%@ page import="wzy.CommunitySquare.Notice" %><%--
  Created by IntelliJ IDEA.
  User: Elber
  Date: 2017/7/13
  Time: 18:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>咨询详情</title>
    <link href="css/bootstrap.css"  rel="stylesheet">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.js"></script>

    <%
        String id=request.getParameter("id");
        String org_id=request.getParameter("org_id");
        String type=request.getParameter("type");
        String content;//从数据库根据id读通知/新闻的方法，返回String
        String title;
        String date;
    %>
</head>
<body>

<div class="container">
    <div class="row">
        <ul class="breadcrumb">
            <li>
                <a href="club-square.jsp">社团广场</a> <span class="divider">></span>
            </li>
            <li>
                <%if(type.equals("news")){%>
                <a href="club-square.jsp#news">新闻</a> <span class="divider">></span>
                <%
                        News news=CommSquare.getNewsFormId(Integer.parseInt(id));
                    content=news.getNews_content();
                    title=news.getNews_title();
                    date=news.getNews_date();
                }else{%>
                <a href="club-square.jsp#news">通知</a> <span class="divider">></span>
                <%  Notice notice=CommSquare.getNoticeFormId(Integer.parseInt(org_id),Integer.parseInt(id));
                    content=notice.getNoti_content();
                    title=notice.getNoti_title();
                    date=notice.getNoti_date();
                }%>
            </li>
            <li class="active">详情</li>
        </ul>
    </div>

    <div class="row">
        <h2><%=title%></h2>
        <small><%=date%></small>
        <p><%=content%></p>
    </div>
</div>
</body>
</html>
