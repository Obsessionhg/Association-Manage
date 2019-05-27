<%@ page import="javax.sql.CommonDataSource" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.CommuDao" %>
<%@ page import="wzy.CommunitySquare.CommSquare" %>
<%@ page import="wzy.CommunitySquare.Recruitment" %>
<%@ page import="wzy.CommunitySquare.Notice" %>
<%@ page import="dao.ComUserDao" %>
<%@ page import="daoImpl.ComUserDaoImpl" %>
<%@ page import="daoImpl.CommuDaoImpl" %>
<%@ page import="daoImpl.UserDaoImpl" %>
<%@ page import="dao.NotiDao" %>
<%@ page import="daoImpl.NotiDaoImpl" %>
<%@ page import="entity.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="javax.sound.midi.SysexMessage" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserDaoImpl userDao = new UserDaoImpl();
    String uid=(String)session.getAttribute("uid");
    User user=null;
    if(uid!=null) user = userDao.queryUserByUid(uid);
%>
<html>
<head>
    <title>社团广场</title>
    <link href="css/bootstrap.css"  rel="stylesheet">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script>
        function tiaozhuan() {
            console.log($('#uid').val());
            console.log($('#uid').val()==null);
            if($('#user-id').val()==null){
                alert("您还没有登录,无法创建社团~请登录后继续操作");
                location.href="index.jsp";
            }
            else{
                location.href="createClub.jsp?uid=1";
            }
        }
    </script>

    <style>
        body{
            background:url("image/campus_blur_3.jpg");
            background-size: cover;
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
    <%
        List<homepage_news> newsList=CommSquare.getHomepageNewsList();
//        newsList= CommSquare.getCommNewsList(0,false);
        List<Notice> noticeList=CommSquare.getCommNoticeList(0,false);
    %>
</head>
<body>
<%@include file="navigator.jsp"%>

<div class="container col-md-offset-2 col-md-8" style="margin-top:60px;background-color:rgba(92,184,92,0.3)">

    <%--顶部 搜索栏+按钮--%>
    <div class="row" style="margin-top:0px;z-index:1">
        <div class="input-group" style="margin-top:0px;positon:relative;z-index: 1">
            <input style="border-color:#5cb85c " type="text" class="form-control" placeholder="请输入社团名" id="keywd">
            <span class="input-group-btn">
                <button class="btn btn-info btn-search" onclick="search()">搜索社团</button>
                <button class="btn btn-info btn-search" style="margin-left:3px" onclick="{location.href='club-list.jsp'}">查看社团列表</button>
                <%
                    if(user!=null){
                %>
                <button class="btn btn-info btn-search" style="margin-left:3px" onclick="tiaozhuan()">创建社团</button>
                <%}%>
            </span>
        </div>
    </div>

        <%--视频+轮播--%>
    <div class="row" style="margin-top:20px">
        <%--轮播区--%>
        <div class="col-md-6">
            <div id="imageCarousel" class="carousel slide">
                <!-- 轮播（Carousel）指标 -->
                <ol class="carousel-indicators">
                    <li data-target="#imageCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#imageCarousel" data-slide-to="1"></li>
                    <li data-target="#imageCarousel" data-slide-to="2"></li>
                </ol>
                <!-- 轮播（Carousel）项目 -->
                <div class="carousel-inner" style="overflow: hidden ;height: 258px" >
                    <%
                        List<homepage_img> imgs=CommSquare.getHomepageImgList();
                        int length;
                        if(imgs.size()<3){
                            length=imgs.size();
                        }else{
                            length=3;
                        }
                        homepage_img temp_hpi;
                        for(int i=0;i<length;i++){
                            temp_hpi=imgs.get(i);
                            if(i==0){
                                %>
                    <div class="item active">
                        <img height="258px" src="uploadImg/<%=temp_hpi.getImg_name()%>" alt="slide <%=i%>">
                    </div>
                    <%
                            }else{
                                %>
                    <div class="item">
                        <img height="258px" src="uploadImg/<%=temp_hpi.getImg_name()%>" alt="slide <%=i%>">
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
                <!-- 轮播（Carousel）导航 -->
                <a class="carousel-control left" href="#imageCarousel"
                   data-slide="prev">&lsaquo;
                </a>
                <a class="carousel-control right" href="#imageCarousel"
                   data-slide="next">&rsaquo;
                </a>
            </div>
        </div>

        <%--视频区--%>
        <div class="col-md-6">
            <div class="panel">
                <div class="panel-heading panel-title">社团视频</div>
                <div class="panel-body">
                    <%
                        List<homepage_video> videos=CommSquare.getHomepageVideoList();
                        if(videos==null||videos.size()<=0){
                            %>
                    <video src="video/test_video.mp4" width="400px" height="200px" controls="controls"></video>

                    <%
                        }else{
                            homepage_video hpv;
                            int max_apply_id=0;
                            int max_index=0;
                            for(int i=0;i<videos.size();i++){
                                hpv=videos.get(i);
                                if(max_apply_id<=hpv.getApply_id()) {
                                    max_apply_id = hpv.getApply_id();
                                    max_index=i;
                                }
                            }
                            hpv=videos.get(max_index);
                            %>
                    <video src="uploadVideo/<%=hpv.getVideo_name()%>" width="400px" height="200px" controls="controls"></video>
                    <%
                        }
                    %>
                    </div>
            </div>
        </div>

    </div>

    <%--新闻+公告--%>
    <div class="row" style="margin-top:20px" id="news">
        <%--新闻区--%>
        <div class="col-md-6">
            <div class="panel">
                <div class="panel-heading panel-title">社团新闻
                    <%--跳转到某个servlet上加载--%>
                    <a style="display: inline-block;position: absolute;right: 30px" href="">更多</a>
                </div>
                <div class="panel-body">
                    <table class="table" style="table-layout:fixed">
                        <%

                            if(newsList==null||newsList.size()==0){
                                %>
                                还没有任何新闻...
                        <%
                            }else{
                                homepage_news homepage_news;
                                News news;
                            for(int i=0;i<newsList.size();i++){
                                homepage_news=newsList.get(i);
                                news=CommSquare.getNewsFormId(homepage_news.getNews_id());
                        %>
                        <tr>
                            <%--这里需要获取对应新闻的id--%>
                            <td width="70%" style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap"><a href="news-detail.jsp?type=news&id=<%=homepage_news.getNews_id()%>&org_id=<%=homepage_news.getOrg_name()%>">
                                <%=news.getNews_title()%></a></td>
                            <td width="30%"><%=news.getNews_date().substring(0,10)%></td>
                        </tr>

                        <%}
                            }%>
                    </table>
                </div>
            </div>
        </div>

        <%--公告区--%>
        <div class="col-md-6">
            <div class="panel">
                <div class="panel-heading panel-title">社团公告</div>
                <div class="panel-body">
                    <table class="table" style="table-layout: fixed">
                        <%
                            NotiDao notidao = new NotiDaoImpl();
                            List<entity.Notice> list = notidao.queryAllAgreed();
                            for(int i=0;i<list.size();i++){
                                entity.Notice notice= list.get(i);
                        %>
                        <tr>
                            <%--这里需要获取对应通知的id--%>
                            <td width="70%" style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap"><a href="news-detail.jsp?type=notice&id=<%=notice.getNoti_id()%>&org_id=<%=notice.getOrg_id()%>"><%=notice.getNoti_title()%></a></td>
                            <td width="30%" style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap"><%=notice.getNoti_date()%></td>
                        </tr>

                        <%}%>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%--招新中的社团--%>
        <%//String uid = (String)session.getAttribute("uid");
            if(uid==null)
        {
        %>
        <div class="row" style="margin-top: 20px;text-align: center">
            <hr>
            <h3 style="display: inline-block">登陆后了解更多</h3>
        </div>
        <%
        }
        else
        {
        %>
    <div class="row" style="margin-top: 20px;text-align: center;color:white">
        <hr>
        <h3 style="display: inline-block">正在招新中的社团……</h3>
    </div>

    <div class="row" style="margin-top: 20px" id="recruiting-club-list">
        <%--一个社团卡片--%>
        <%
            List<Recruitment> recruitments=CommSquare.getRecruitmentList(0,false);
            Recruitment recruitment;
            //System.out.println("before for");
            for(int i=0;i<recruitments.size();i++){
                recruitment=recruitments.get(i);
                System.out.println(recruitment.getRec_title());
        %>
        <div class="col-sm-6 col-md-4">
            <div class="thumbnail">
                <%
                    Img temp;
                    List<Img> temp_list=CommSquare.getCommImgList(recruitment.getOrg_id(),1);
                    if(temp_list!=null && temp_list.size()>0){
                        temp=temp_list.get(0);
                    %>
                <img style="width:240px;height: 160px" src="uploadImg/<%=temp.getImg_name()%>" alt="社团图片">
                <%
                    }else{
                        %><img style="width:240px;height: 160px" src="image/default_img.jpg" alt="默认图片"><%
                    }
                %>
                <div class="caption">
                    <h4><b><%=recruitment.getRec_title()%></b></h4>
                    <%--<p style="width:100%;overflow: hidden;text-overflow:ellipsis;white-space: nowrap"><%=recruitment.getContent()%></p>--%>
                    <p style="text-align: center;">
                        <%--这里需要跳转到servlet--%>
                        <a href="club-detail.jsp?rec_id=<%=recruitment.getRec_id()%>&org_id=<%=recruitment.getOrg_id()%>" target="_blank" class="btn btn-primary" role="button">
                            了解更多
                        </a>
                    </p>
                </div>
            </div>
        </div>

        <%}}%>



    </div>
</div>

    <script>
        function search(){
            var keywd=$('#keywd').val().trim();
            console.log("===search");
            console.log(keywd=="");
            if(keywd!=""){
                window.open('club-list.jsp?keywd='+keywd);
//                location.herf='club-list.jsp?keywd='+$('#keywd').val();
            }else{
                alert("请输入社团名关键字");
            }
        }
    </script>
</body>
</html>
