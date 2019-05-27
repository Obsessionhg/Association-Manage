<%@ page import="daoImpl.CommuDaoImpl" %>
<%@ page import="dao.CommuDao" %>
<%@ page import="java.util.List" %>
<%@ page import="daoImpl.ComUserDaoImpl" %>
<%@ page import="dao.ComUserDao" %>
<%@ page import="daoImpl.PriDaoImpl" %>
<%@ page import="dao.PriDao" %>
<%@ page import="daoImpl.UserDaoImpl" %>
<%@ page import="wzy.CommunitySquare.CommSquare" %>
<%@ page import="entity.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    String org_id = request.getParameter("org_id");
    String uid=(String)session.getAttribute("uid");
    UserDaoImpl userDao = new UserDaoImpl();
    User user =null;
    if(uid!=null) user=userDao.queryUserByUid(uid);

%>
<html>
<head>
    <title>我加入的社团</title>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script>
<script>
    function mytest() {
        document.getElementById("testdiv").style.display="none";
    }

</script>

<style>
    .portrait{
        width:14px;
        height:14px;
        background-image: url('image/night.jpg');
        background-size: cover;
        diplay:block;
        border-radius: 50%;
        overflow: hidden;
    }
</style>

    <style>
    body{
        /*background:url("image/body_bg.jpg")*/
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
        .top-bar li,a{
            color:white;
        }

        .left-nav-bar ul{
            padding:0;
        }
        .left-nav-bar li{
            display: inline-block;
            list-style-type: none;
            width:100%;
        }
        .left-nav-bar li :hover{
            /*background-color: #FFAE40;*/
            background-color: #89dc89;
        }

        .left-nav-bar a{
            text-decoration: none;
            display: inline-block;
            list-style-type: none;
            width:100%;
            line-height:20px;
            padding:15px 20px;
        }

        body{
            /*background-color: white;*/
            background-image: url('image/campus_blur_3.jpg');
            background-size: cover;
        }

        #left-bar{
            background-color:rgba(92,184,92,0.8);
            padding-bottom: 80px
        }

        .glyphicon{
            font-size:14px;
            line-height:20px;
        }

    </style>
</head>

<body>

<%@include file="navigator.jsp"%>

<div class="container" style="margin-top:60px">
    <div class="row clearfix">
    <div class="col-md-2" id="left-bar">
        <%--社团名称 职位区--%>
        <div class="row" style="color:white;text-align: center;margin-top: 20px">
            <%--这里还要取图片--%>
            <%
                Img p_img=CommSquare.getCommPortrait(Integer.parseInt(org_id));
                ComUserDao comuserdao = new ComUserDaoImpl();
                CommuDao commdao = new CommuDaoImpl();
                if(p_img==null){
                    %><img alt="100x100" src="image/default-portrait.jpg" width="100px" height="100px"/>
                <%}else{
            %>
            <img alt="100x100" src="uploadImg/<%=p_img.getImg_name()%>"
                 width="100px" height="100px"/>
                <%}
                    entity.Community community=commdao.queryCommuByOrg(Integer.parseInt(org_id));
                    if(community.getOrg_status().equals("0")){
                %>
                <script type="text/javascript">
                    alert("社团未被审核");
                    setTimeout(function(){
                        history.back();
                        },1000);
                </script>
                <%}%>
                <h5><%=commdao.queryCommuByOrg(Integer.parseInt(org_id)).getOrg_name()%></h5>
                <small>我的职位：<%=comuserdao.queryUserByOrgUid(Integer.parseInt(org_id),uid).get(0).getPosition()%></small>
            <p>——————————</p>
        </div>

        <div class="row" style="margin: 10px -15px;">
            <nav>
                <div class="left-nav-bar">
                    <ul>
                        <li><a href="member-info.jsp?org_id=<%=org_id%>" target="mainframe" style="color: white">人员信息</a><br></li>
                        <li><a href="message.jsp?org_id=<%=org_id%>" target="mainframe"style="color: white">公告通知</a><br></li>
                        <li><a href="activity.jsp?org_id=<%=org_id%>" target="mainframe"style="color: white">活动管理</a><br></li>
                        <%
                            PriDao pridao = new PriDaoImpl();
                            if(1==pridao.queryPri(uid,Integer.parseInt(org_id),"priManaUser")){
                        %>
                        <%--<div id="testdiv"><a href="recurit-sys.jsp?org_id=<%=org_id%>" target="mainframe"style="color: white">招新系统</a></div>--%>
                        <li><a href="recurit-sys.jsp?org_id=<%=org_id%>" target="mainframe"style="color: white">招新系统</a></li>
                        <%}
                          if(1==pridao.queryPri(uid,Integer.parseInt(org_id),"priNoNews")){
                        %>
                        <li><a href="releasingNotices.jsp?org_id=<%=org_id%>" target="mainframe"style="color: white">对外发布</a><br></li>
                        <%}%>
                    </ul>
                </div>
            </nav>
        </div>
        <%--<textarea name=" " id="" cols="20" rows="10"><%=commdao.queryCommuByOrg(Integer.parseInt(org_id)).get(0).getOrg_intro()%></textarea>--%>
    </div>

        <div class="col-md-10">
            <%--<div class="panel">--%>
                <%--<div id="p-title" class="panel-header" style="padding: 10px;">--%>

                <%--</div>--%>
            <%--</div>--%>
            <div id="iframepage">
                <iframe id="right-info-panel" src="member-info.jsp?org_id=<%=org_id%>" name="mainframe"  width="100%" height="90%" frameborder="0"  style="border-radius:5px"></iframe>
            </div>
        </div>

</div>
</div>
<script>
    //调整panel高度对齐
    var left_height=$('#left-bar').height();
    var right_height=$('#right-info-panel').height();
    console.log(left_height);
    console.log(right_height);
    if(left_height>right_height){
        $('#right-info-panel').css('padding-bottom',left_height-right_height);
    }else{
        $('#left-bar').css('padding-bottom',right_height-left_height);
    }
</script>
</body>
</html>
