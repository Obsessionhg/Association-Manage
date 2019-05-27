<%@ page import="wzy.CommunitySquare.Recruitment" %>
<%@ page import="wzy.CommunitySquare.CommSquare" %>
<%@ page import="entity.Community" %>
<%@ page import="dao.RecDao" %>
<%@ page import="daoImpl.RecDaoImp" %>
<%@ page import="dao.ComUserDao" %>
<%@ page import="daoImpl.ComUserDaoImpl" %>
<%@ page import="dao.CommuDao" %>
<%@ page import="daoImpl.CommuDaoImpl" %>
<%@ page import="entity.Img" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>社团详情</title>

    <%--key的名字填在下面--%>
    <%
        int org_id=Integer.parseInt(request.getParameter("org_id"));
        int rec_id=Integer.parseInt(request.getParameter("rec_id"));
    %>

    <link href="css/bootstrap.css"  rel="stylesheet">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
<%--这里需要获取参数，根据参数判断需要获取哪个社团的信息request.getParameter--%>
<%
    boolean has_table=false;
    boolean is_member=false;
%>
<div class="container">
    <div class="row">
        <ul class="breadcrumb">
            <li>
                <a href="club-square.jsp">社团广场</a> <span class="divider">></span>
            </li>
            <%
                if(rec_id!=-1){
            %>
            <li>
                <a href="club-square.jsp#recruiting-club-list">招新中的社团</a> <span class="divider">></span>
            </li>
            <%}%>
            <li class="active">社团详情</li>
        </ul>
    </div>

    <div class="row">
        <%
        Recruitment recruitment;
        if(rec_id!=-1){
            recruitment= CommSquare.getRecruitmentFromId(org_id,rec_id);
            int recruitmentOrg_id=org_id;
            Community community=CommSquare.getCommunity(recruitmentOrg_id);
        %>
        <div class="col-md-9">
            <%--左侧所有信息--%>
            <div>
                <%--标题栏+报名按钮--%>
                    <%--<div class="col-md-10"><h2><%=recruitment.getRec_title()%></h2></div>--%>
                    <%--<div class="col-md-2  pull-right">--%>
                        <%--<%--%>
                            <%--ComUserDao comuserdao = new ComUserDaoImpl();--%>
                            <%--int norg_id=(Integer.parseInt(request.getParameter("org_id")));--%>
                            <%--String uid =(String)session.getAttribute("uid");--%>
                            <%--if(comuserdao.queryUserByOrgUid(norg_id,uid).size()==0){--%>
                                <%--if(recruitment.getRec_need().equals("0,0,0,0,0,0")){--%>
                        <%--%>--%>

                        <%--该社团还未建立报名表，请等一等--%>
                        <%--<%--%>
                        <%--}else {--%>
                        <%--%>--%>
                        <%--<a class="btn btn-primary" target="_blank" href="sign-up-table.jsp?rec_id=<%=recruitment.getRec_id()%>&org_id=<%=recruitment.getOrg_id()%>">点我报名</a>--%>
                        <%--<%}--%>
                        <%--}--%>
                        <%--else--%>
                        <%--{--%>
                        <%--%>--%>
                        <%--你已经是该社团的成员了--%>
                        <%--<%}%>--%>
                    <%--</div>--%>
                    <div style="margin:10px 0;">
                        <%
                            ComUserDao comuserdao = new ComUserDaoImpl();
                            int norg_id=org_id;
                            String uid =(String)session.getAttribute("uid");
                            if(comuserdao.queryUserByOrgUid(norg_id,uid).size()==0){
                                if(recruitment.getRec_need().equals("0,0,0,0,0,0")){
                                    has_table=false;
                                    System.out.println("set false");
                                }else {
                                    has_table=true;
                                    System.out.println("set true");
                                }
                            }else{
                                is_member=true;
                            }%>

                        <h2><%=recruitment.getRec_title()%></h2>
                        <p><i class="fa fa-group"></i>&nbsp;&nbsp;<%=community.getOrg_name()%></p>
                        <hr>
                    </div>
                    <%
                        if(has_table){
                            System.out.println("has_table "+has_table);
                    %>
                    <a class="btn btn-primary pull-right" target="_blank" href="sign-up-table.jsp?rec_id=<%=recruitment.getRec_id()%>&org_id=<%=recruitment.getOrg_id()%>">点我报名</a>
                    <%}
                    if(is_member){%>
                        <div class="alert alert-info">您已经是社团成员了~</div>
                    <%}
                    if(!has_table&&!is_member){
                        %><div class="alert alert-info">该社团还未发布报名表~请稍等</div>
                    <%
                    }%>
                    <p><%=recruitment.getContent()%></p>

            </div>

        </div>
        <div class="col-md-3">
            <h5>社团图片</h5>
        <%List<Img> imgList= CommSquare.getCommImgList(org_id,0);
        Img temp_img;
            if(imgList!=null && imgList.size()>0){
                for(int i=0;i<imgList.size();i++){
                    temp_img=imgList.get(i);
                    %>
                <%--图片区--%>
                    <div class="row" style="margin:8px 0">
                        <img src="uploadImg/<%=temp_img.getImg_name()%>" style="width: 100%">
                    </div>
        <%
                }
            }else{%>
            <div class="row" style="margin:8px 0">
                <img src="/image/default-portrait.jpg" style="width: 100%">
            </div>
            <%}%>
        </div>

    </div>
</div>
<%}else{%>
    <div class="row">
        <%
            CommuDao cd=new CommuDaoImpl();
            Community cm= cd.queryCommuByOrg(org_id);
            //Community community=CommSquare.getCommunity(i);
            System.out.println(cm.getOrg_name());
        %>
        <div class="col-md-9">
            <h2><%=cm.getOrg_name()%></h2>
            <p><i class="fa fa-clock-o"></i>&nbsp;&nbsp;成立时间:<%=cm.getOrg_found_date()%></p>
            <p><%=cm.getOrg_intro()%></p>
        </div>


        <div class="col-md-3">
            <h5>社团图片</h5>
            <%List<Img> imgList= CommSquare.getCommImgList(org_id,0);
                Img temp_img;
                if(imgList!=null && imgList.size()>=0){
                    for(int i=0;i<imgList.size();i++){
                        temp_img=imgList.get(i);
            %>
            <%--图片区--%>
            <div class="row" style="margin:8px 0">
                <img src="uploadImg/<%=temp_img.getImg_name()%>" style="width: 100%">
            </div>
            <%
                    }
                }%>
        </div>
    </div>
</div>
<%}%>


<script>

</script>
</body>
</html>
