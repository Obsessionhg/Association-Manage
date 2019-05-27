<%@ page import="java.util.List" %>
<%@ page import="dao.ComUserDao" %>
<%@ page import="daoImpl.ComUserDaoImpl" %>
<%@ page import="daoImpl.CommuDaoImpl" %>
<%@ page import="dao.CommuDao" %>
<%@ page import="daoImpl.UserDaoImpl" %>
<%@ page import="wzy.CommunitySquare.CommSquare" %>
<%@ page import="entity.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserDaoImpl userDao = new UserDaoImpl();
    String uid=(String)session.getAttribute("uid");
    User user=null;
    if(uid!=null) user = userDao.queryUserByUid(uid);
    String keywd=request.getParameter("keywd");
    if(keywd==null) keywd="";
%>
<html>
<head>
    <title>社团列表</title>
    <meta charset="UTF-8">
    <link href="css/bootstrap.css"  rel="stylesheet">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
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
            background-image: url(image/campus_1.jpg);
            background-size: cover;
            overflow: hidden;
        }

        .form-group input{
            margin:15px 0;
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
        .top-bar li,a{
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
            z-index: 2;
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
    </style>
</head>
<%
//    String org_id = request.getParameter("org_id");
    System.out.println("[list]: keywd="+keywd);

    Community cm;
    List<Community> communities;
    CommuDao cd= new CommuDaoImpl();

    if(keywd.equals("")){
        communities=cd.queryCommuBystat(1);
    }else{
        communities=cd.queryOrgBykey(keywd);
    }
%>
<body>
<%@include file="navigator.jsp"%>

<div class="row col-md-8 col-md-offset-2" style="margin-top: 60px;border-radius:5px;padding:10px;background-color: rgba(255,255,255,0.8)" >
    <%--一个社团卡片--%>
    <%
        if(communities==null || communities.size()==0){
            %>
            没有找到符合条件的社团，换个关键词试试吧~
        <%
        }else{
        for(int i=0;i<communities.size();i++){
            cm=communities.get(i);
    %>
    <div class="col-sm-6 col-md-4">
        <div class="thumbnail">
            <%
                Img temp;
                List<Img> temp_list= CommSquare.getCommImgList(cm.getOrg_id(),1);
                if(temp_list!=null && temp_list.size()>0){
                    temp=temp_list.get(0);
            %>
            <img style="height: 160px;width:240px" src="uploadImg/<%=temp.getImg_name()%>" alt="社团图片">
            <%
            }else{
            %><img style="width:240px;height: 160px" src="image/default_img.jpg" alt="默认图片"><%
            }
        %>
            <div class="caption">
                <h4><b><%=cm.getOrg_name()%></b></h4>
                <p style="width:100%;overflow: hidden;text-overflow:ellipsis;white-space: nowrap"><%=cm.getOrg_intro()%></p>
                <p style="text-align: center;">
                    <%--这里需要跳转到servlet--%>
                    <a href="club-detail.jsp?rec_id=-1&org_id=<%=cm.getOrg_id()%>" target="_blank" class="btn btn-primary" role="button">
                        了解更多
                    </a>
                </p>
            </div>
        </div>
    </div>

    <%}}%>
</div>
</body>
</html>
