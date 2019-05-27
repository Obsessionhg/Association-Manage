<%@ page import="java.util.List" pageEncoding="UTF-8" %>
<%@ page import="wzy.CommunitySquare.CommSquare" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.*" %>
<%@ page import="dao.*" %>
<%@ page import="daoImpl.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>管理系统</title>
    <link href="/css/bootstrap.css"  rel="stylesheet">
    <script src="/js/jquery-3.2.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>
    <style>
        body{
            background:url("image/campus_1.jpg")
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

        Manager manager = new Manager();
        ManagerDao managerDao = new ManagerDaoImpl();
        manager = managerDao.queryUserByUid((String)session.getAttribute("mid"));
        if(manager==null) response.sendRedirect("manager.jsp");
    %>
</head>
<body>
<%--<ul class="nav nav-pills pull-right" style="padding-top: 20px">--%>
    <%--<li class="pull-right">--%>
        <%--&lt;%&ndash;此处用户名应调用接口获得  &ndash;%&gt;--%>
        <%--<a href="exit" class="thumbnail">--%>
            <%--<img src="#" alt="通" class="pull-left">--%>
            <%--退出--%>
        <%--</a>--%>
    <%--</li>--%>
<%--</ul>--%>

<div class="top-bar">
    <div class="navbar" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">社团管理系统</a>
            </div>

            <div>
                <ul class="nav navbar-nav pull-right">

                    <li><a href="club-square.jsp">社团广场</a></li>
                    <%--这里要加头像--%>
                    <li><a href="#" >管理员</a></li>
                    <li><a href="admin.jsp" >管理页面</a></li>
                    <%--<li><a href="innerMessage.jsp?queryType=receive"><span class="glyphicon glyphicon-envelope"></span></a></li>--%>
                    <%--<li><a href="exit"><span class="glyphicon glyphicon-log-out"></span></a></li>--%>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="container" style="margin-top: 60px;background-color:rgba(256,256,256,0.94);height: 600px;overflow:auto">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="tabbable" id="tabs-308180" style="padding-top: 20px">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="#panel-635820" data-toggle="tab">社团审批</a>
                    </li>
                    <li>
                        <a href="#panel-635821" data-toggle="tab">公告审批</a>
                    </li>
                    <li>
                        <a href="#panel-582637" data-toggle="tab">新闻审批</a>
                    </li>
                    <li>
                        <a href="#panel-582638" data-toggle="tab">图片审批</a>
                    </li>
                    <li>
                        <a href="#panel-582639" data-toggle="tab">视频审批</a>
                    </li>
                    <li class="pull-right">
                        <div>
                            <label style="font-size: 20px">管理员界面</label>
                        </div>
                    </li>
                </ul>

                <div class="tab-content">
                    <%--社团审批 panel--%>
                    <div class="tab-pane active" id="panel-635820">
                    <form action="manacom">
                        <table class="table" style="table-layout:fixed;">
                            <tr>
                                <th width="100">社团名称</th>
                                <th width="100">创建人</th>
                                <th width="200">简介</th>
                                <th width="100">操作</th>
                            </tr>
                            <%
                                CommuDao commudao = new CommuDaoImpl();
                                List<Community> list = commudao.queryCommuBystat(0);//申请未审核
                                UserDao userdao = new UserDaoImpl();
                                for(int i =0;i<list.size();i++){
                                    Community comm= list.get(i);

                            %>
                            <tr>
                                <td width="100" style="word-wrap:break-word;"><%=comm.getOrg_name()%></td>
                                <td width="100" style="word-wrap:break-word;"><%=userdao.queryUserNameByUid(comm.getUid())%></td>
                                <td width="200" style="word-wrap:break-word;"><%=comm.getOrg_intro()%></td>
                                <td>
                                    <div>
                                        <input type="checkbox" name="examination" value="<%=comm.getOrg_id()%>">
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                        <input type="hidden" id="type" name="type">
                        <button class="btn btn-default" onclick="myDelete()">不通过</button>
                        <button class="btn btn-default" onclick="agree()">通过</button>
                        <%--<input type="submit" value="不通过" class="btn btn-default pull-right">--%>

                    </form>
                </div>
                    <%--公告审批 panel--%>
                    <div class="tab-pane" id="panel-635821">
                        <form action="applyNoti" onsubmit="return false">
                            <input type="hidden" id="type" name="type">
                            <table class="table" style="table-layout:fixed;">
                                <tr>
                                    <th width="200">社团名称</th>
                                    <th width="200">公告标题</th>
                                    <th width="300">公告内容</th>
                                    <th width="100">申请时间</th>
                                </tr>
                                <%
                                    NotiDao notidao = new NotiDaoImpl();
                                    List<Notice> list1 =notidao.queryAllApply();

                                    for(int i=0;i<list1.size();i++)
                                    {
                                        Notice noti = list1.get(i);
                                        Community comm = commudao.queryCommuByOrg(noti.getOrg_id());
                                %>
                                <tr>
                                    <td width="100" style="word-wrap:break-word;"><%=comm.getOrg_name()%></td>
                                    <td width="100" style="word-wrap:break-word;"><%=noti.getNoti_title()%></td>
                                    <%--<td width="200" style="word-wrap:break-word;"><%=noti.getNoti_content()%></td>--%>
                                    <td width="40%" style="white-space: nowrap;text-overflow:ellipsis;overflow: hidden">
                                        <a  data-toggle="modal" data-target="#noti-detail" onclick='
                                                $("#detail-title").html("<%=noti.getNoti_title()%>");
                                                $("#detail-content").html("<%=noti.getNoti_content()%>");
                                                $("#detail-date").html("<%=noti.getNoti_date()%>");'>
                                            <%=noti.getNoti_content()%></a>
                                    </td>
                                    <td width="100" style="word-wrap:break-word;"><%=noti.getNoti_date().substring(0,19)%></td>
                                    <td>
                                        <div>
                                            <input type="checkbox" name="noti_id" value="<%=noti.getNoti_id()%>">
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </table>
                            <input type="submit" value="审批首页" class="btn btn-default pull-right" onclick="notice('agree')">
                            <input type="submit" value="删除公告" class="btn btn-default pull-right" onclick="notice('delete')">
                        </form>
                    </div>
                    <%--新闻审批 panel--%>
                    <div class="tab-pane" id="panel-582637">
                    <form action="servlet/NewsExaServlet">
                        <%--表格内容 根据后台来更改--%>
                        <table class="table" style="table-layout:fixed;">
                            <tr>
                                <th width="100">新闻ID</th>
                                <th width="200">标题</th>
                                <th width="300">内容</th>
                                <th width="100">时间</th>
                            </tr>
                            <%
//
                                List<homepage_news> nhplist = CommSquare.getHomepageNewsApplyList(0);//获取申请表记录
                                List<Integer> idlist=new ArrayList<Integer>();
                                for (homepage_news n : nhplist
                                     ) {
                                    idlist.add(n.getNews_id());
                                }
                                List<News> newsList=CommSquare.getNewsFormIdS(idlist);
                                int nlenth=newsList.size();

                                for(int i =0;i<nlenth;i++){

                            %>
                            <tr>
                                <td width="100" style="word-wrap:break-word;"><%=newsList.get(i).getNews_id()%></td>
                                <td width="100" style="word-wrap:break-word;"><%=newsList.get(i).getNews_title()%></td>
                                <%--<td width="100" style="word-wrap:break-word;"><%=newsList.get(i).getNews_content()%></td>--%>
                                <td width="40%" style="white-space: nowrap;text-overflow:ellipsis;overflow: hidden">
                                    <a  data-toggle="modal" data-target="#noti-detail" onclick='
                                            $("#detail-title").html("<%=newsList.get(i).getNews_title()%>");
                                            $("#detail-content").html("<%=newsList.get(i).getNews_content()%>");
                                            $("#detail-date").html("<%=newsList.get(i).getNews_date()%>");'>
                                        <%=newsList.get(i).getNews_content()%></a>
                                </td>
                                <td width="200" style="word-wrap:break-word;"><%=nhplist.get(i).getApplytime().substring(0,19)%></td>
                                <td>
                                    <div>
                                        <input type="checkbox" name="examination_news" value="<%=nhplist.get(i).getApply_id()%>">同意
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                        <input type="submit" value="提交" class="btn btn-default pull-right">
                    </form>
                </div>
                    <%--图片审批 panel--%>
                    <div class="tab-pane" id="panel-582638">
                    <form action="servlet/ImgExaServlet">
                        <table class="table" style="table-layout:fixed;">
                            <tr>
                                <th width="100">申请图片的社团名</th>
                                <%--<th width="100">图片名字</th>--%>
                                <th width="200">内容</th>
                                <th width="100">时间</th>
                            </tr>
                        <%
                            List<homepage_img> ihplist = CommSquare.getHomepageImgApplyList(0);//获取申请表记录
                            int ilenth=ihplist.size();

                            for(int i =0;i<ilenth;i++){
                        %>
                        <tr>
                            <td width="100" style="word-wrap:break-word;"><%=ihplist.get(i).getOrg_name()%></td>
                            <%--<td width="100" style="word-wrap:break-word;"><%=ihplist.get(i).getImg_name()%></td>--%>
                            <td> <img width="200" hight="60" src="uploadImg/<%=ihplist.get(i).getImg_name()%>"></img></td>
                            <td width="200" style="word-wrap:break-word;"><%=ihplist.get(i).getApplytime()%></td>
                            <td>
                                <div>
                                    <input type="checkbox" name="examination_img" value="<%=ihplist.get(i).getApply_id()%>">同意
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </table>
                        <input type="submit" value="提交" class="btn btn-default pull-right">
                    </form>
                </div>
                    <%--视频审批 panel--%>
                    <div class="tab-pane" id="panel-582639">
                        <form action="servlet/VideoExaServlet">
                        <table class="table" style="table-layout:fixed;">
                            <tr>
                                <th width="100">申请视频的社团名</th>
                                <th width="100">视频名字</th>
                                <th width="300">内容</th>
                                <th width="100">时间</th>
                            </tr>
                            <%
                                List<homepage_video> vhplist = CommSquare.getHomepageVideoApplyList(0);//获取申请表记录
                                int vlenth=vhplist.size();

                                for(int i =0;i<vlenth;i++){
                                    String videoname=vhplist.get(i).getVideo_name();
                            %>
                            <tr>
                                <td width="100" style="word-wrap:break-word;"><%=vhplist.get(i).getOrg_name()%></td>
                                <td width="100" style="word-wrap:break-word;"><%=videoname%></td>
                                <td>
                                    <video  width="260" height="200" controls="controls">
                                        <source src="uploadVideo/<%=videoname%>" type="video/ogg">
                                        <source src="uploadVideo/<%=videoname%>" type="video/mp4">
                                        <object data="uploadVideo/<%=videoname%>" width="320" height="240">
                                        </object>
                                        Your browser does not support the video tag.

                                    </video>
                                </td>
                                <td width="200" style="word-wrap:break-word;"><%=vhplist.get(i).getApplytime().substring(0,19)%></td>
                                <td>
                                    <div>
                                        <input type="checkbox" name="examination_video" value="<%=vhplist.get(i).getApply_id()%>">同意
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                            <input type="submit" value="提交" class="btn btn-default pull-right">
                        </form>
                    </div>
                </div>
            </div>
        </div><!--end column-->
    </div>

    <div class="modal fade" id="noti-detail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="">&times;</button>
                    <h4 class="modal-title" >通知详情</h4>
                </div>

                <div class="modal-body">
                    <b><h4 id="detail-title"></h4></b>
                    <p id="detail-date"></p>
                    <hr>
                    <p id="detail-content"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>

            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div><!--end row-->
</div><!--end container-->
</body>
</html>
<script>
    function myDelete() {
        if($("input:checkbox:checked").length==0)
        {
            alert("未选择要删除的信息")
            return ;
        }
        document.forms[0].type.value='delete';
        document.forms[0].submit();
    }
    function agree() {
        if($("input:checkbox:checked").length==0)
        {
            alert("未选择要标记为已读的信息")
            return ;
        }
        document.forms[0].type.value='agree';
        document.forms[0].submit();
    }

    function notice(obj) {
        document.forms[1].type.value=obj;
        document.forms[1].submit();
    }
</script>
