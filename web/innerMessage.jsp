<%@ page import="dao.ComUserDao" %>
<%@ page import="entity.Org_user" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.CommuDao" %>
<%@ page import="daoImpl.CommuDaoImpl" %>
<%@ page import="daoImpl.ComUserDaoImpl" %>
<%@ page import="dao.MesDao" %>
<%@ page import="daoImpl.MesDaoImpl" %>
<%@ page import="entity.User_Message" %>
<%@ page import="entity.User" %>
<%@ page import="daoImpl.UserDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: wzzz
  Date: 2017/7/17
  Time: 16:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String org_id = request.getParameter("org_id");
        String uid = (String)session.getAttribute("uid");

        User user = null;
        UserDaoImpl userDao = new UserDaoImpl();
        if(uid!=null) user = userDao.queryUserByUid(uid);

    %>
    <title>邮件</title>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script>

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


</head>
<body>
<div id="userID" style="display: none"><%=uid%></div>

<%@include file="navigator.jsp"%>
<div class="container" style="margin-top:60px;background-color:rgba(256,256,256,1);height: 600px">
    <div class="col-md-2" style="margin-top: 20px">
        <div class="panel">
            <div class="panel-heading panel-title">我的信件</div>
            <div style="margin-left: 20px;margin-top: 20px">
                <%--根据receiveOrSend的值来刷新--%>
                <%
                    MesDao mesdao1= new MesDaoImpl();
                %>
                    <a href="innerMessage.jsp?queryType=receive">收件箱<span class="badge"><%=mesdao1.noReadcount(uid)%></span></a><br>
                    <a href="innerMessage.jsp?queryType=send">发件箱</a><br>
                    <a href="innerMessage.jsp?queryType=draft">草稿箱</a><br>
                    <a href="innerMessage.jsp?queryType=collect">收藏邮件</a>
            </div>
            <br>
        </div>
        <button class="btn btn-primary" data-toggle="modal" data-target="#myModal2" style="margin-left: 30px">
            新建邮件
        </button>
    </div>

    <div class="col-md-8" style="margin-top: 20px">
        <h4>我的站内信</h4>
        <%--表单 批量删除、批量已读 用--%>
        <form action="UserMes" onsubmit="return false">
            <%--隐藏的type值--%>
            <input type="hidden" id="type" name="type">
                <input type="hidden"  name="queryType" value=<%=request.getParameter("queryType")%>>
        <table class="table" style="margin-top: 10px;table-layout: fixed">
            <tr>
                <th></th>
                <th width="100">标题</th>
                <th width="100">内容</th>
                <th width="100">日期</th>
                <th width="100">发件人姓名</th>
                <th width="100">操作</th>
            </tr>
            <%--此处插入for循环--%>
            <%
                MesDao mesdao = new MesDaoImpl();
                List<User_Message> list1 = null;

                System.out.println(request.getParameter("queryType"));
                if(request.getParameter("queryType").equals("receive"))
                    list1 = mesdao.ShowReceive(uid);//session.getuid
                else if(request.getParameter("queryType").equals("send"))
                    list1 = mesdao.ShowSend(uid);
                else if(request.getParameter("queryType").equals("draft"))
                    list1 =  mesdao.ShowDraf(uid);
                else if(request.getParameter("queryType").equals("collect"))
                    list1 =mesdao.showCollect(uid);
                int PAGESIZE = 6;
                int pageCount;
                int curPage;
                pageCount = (list1.size()+PAGESIZE-1)/PAGESIZE;
                String tem = request.getParameter("curPage");
                if(tem==null||tem.equals("0"))
                    curPage = 1;
                else
                    curPage = Integer.parseInt(request.getParameter("curPage"));
                if(curPage > pageCount)
                    curPage = pageCount;

                if(list1.size()>0){
                    int t=(curPage-1)*PAGESIZE;
                    for(int i=0;i<PAGESIZE&&(t+i)<list1.size();i++){
                        User_Message user_mes=list1.get(t+i);
            %>
            <tr>
                <td>
                    <input type="checkbox" name="mes_id" value="<%=user_mes.getMes_id()%>">
                <%

                    if(request.getParameter("queryType").equals("receive")){
                    if(user_mes.getStat()==2)
                    {
                %>
                    <img src="image/未读.png" width="40" height="30" alt="0">
                <%
                    }
                    else if(user_mes.getStat()==1)
                    {
                %>
                <img src="image/已读.png" width="40" height="30" alt="1">
                <%}
                }
                else
                {
                %>
               <img src="image/已读.png" width="40" height="30" alt="1">
                <%}%>
                    <%if(user_mes.getType()==1)
                    {
                    %>
                    系统邮件
                    <%}%>
                </td>
                <td><%=user_mes.getMes_title()%></td>
                <input type="hidden" id="boxtype" value=<%=request.getParameter("queryType")%>>
                <td  width="100px" style="white-space: nowrap;text-overflow:ellipsis;overflow: hidden"><a onclick="myDetail(this)"><%=user_mes.getMes_content()%></a> </td>
                <td><%=user_mes.getMes_date().substring(0,19)%></td>
                <td><%=user_mes.getFrom_uid()%></td>
                <%--储存发送者ID 用户不可见 回复/收藏函数用--%>
                <td style="display: none"><%=user_mes.getFrom_uid()%></td>
                <%--储存接受者ID 用户不可见 收藏函数用--%>
                <td style="display: none"><%=user_mes.getTo_uid()%></td>
                <%--储存邮件ID 用户不可见 收藏函数用--%>
                <td style="display: none" id="#"><%=user_mes.getMes_id()%></td>
                <td>
<%--收藏发送按钮--%>


                    <%
                        if(request.getParameter("queryType").equals("receive"))
                        {
                            %>
                    <button class="btn btn-primary" onclick="huifuModal(this)">
                        回复
                    </button>
                    <%
                            if(user_mes.getCollectT()==1)
                            {
                    %>
                    <img src="image/已收藏.png" onclick="collect(this)" width="20" height="20">
                    <%
                            }
                            else
                            {
                    %>
                    <img src="image/未收藏.png" onclick="collect(this)" width="20" height="20">
                    <%
                            }
                        }
                        else if(request.getParameter("queryType").equals("send"))
                            {
                                if(user_mes.getCollectF()==1)
                                {
                    %>

                    <img src="image/已收藏.png" onclick="collect(this)" width="20" height="20">

                    <%
                        }
                        else
                        {
                    %>

                    <img src="image/未收藏.png" onclick="collect(this)" width="20" height="20">

                    <%
                        }
                    }
                          else if(request.getParameter("queryType").equals("draft"))
                          {
                              %>
                       <button class="btn btn-primary" onclick="collectModal(this)">
                       发送
                       </button>
                    <%
                              if(user_mes.getCollectF()==1) {
                    %>
                      <img src="image/已收藏.png" onclick="collect(this)" width="20" height="20">
                     <%
                              }
                              else
                              {
                     %>
                        <img src="image/未收藏.png" onclick="collect(this)" width="20" height="20">
                     <%         }
                          }
                        else if(request.getParameter("queryType").equals("collect"))
                        {
                    %>

                    <img src="image/已收藏.png" onclick="collect(this)" width="20" height="20">

                    <%
                        }
                    %>

                    <%--<button class="btn btn-primary" onclick="collect(this)">--%>
                        <%--收藏--%>
                    <%--</button>--%>
                </td>
            </tr>
            <%}}%>
        </table>
                <%--<input type="hidden" name="type" value="delete">--%>
                <button class="btn btn-default" onclick="myDelete()">删除</button>
                <button class="btn btn-default" onclick="myRead()">已读</button>
        </form>
        <div class="row" style="text-align: center">
            <a href = "innerMessage.jsp?curPage=1&org_id=<%=request.getParameter("org_id")%>&queryType=<%=request.getParameter("queryType")%>" >首页</a>
            &nbsp
            <a href = "innerMessage.jsp?curPage=<%=curPage-1%>&org_id=<%=request.getParameter("org_id")%>&queryType=<%=request.getParameter("queryType")%>">上一页</a>
            &nbsp
            <a href = "innerMessage.jsp?curPage=<%=curPage+1%>&org_id=<%=request.getParameter("org_id")%>&queryType=<%=request.getParameter("queryType")%>">下一页</a>
            &nbsp
            <a href = "innerMessage.jsp?curPage=<%=pageCount%>&org_id=<%=request.getParameter("org_id")%>&queryType=<%=request.getParameter("queryType")%>">尾页</a>
        </div>

    </div>

    <div class="col-md-2" style="margin-top: 20px">
        <div class="panel">
           <div class="panel-heading panel-title">常用联系人</div>
            <div style="margin-top: 20px;margin-left: 20px">
            <%
                String [] str=mesdao.rencentUser(uid);//session
                for(int i=0;i<5;i++) {
                    if(str[i]!=null){
                        System.out.println(str[i]);
            %>
            <a onclick="contact(this)"><%=str[i]%></a><br>
            <%
                    } }
            %>
            </div>
            <br>
        </div>
    </div>
</div>
<!-- 回复模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    站内信
                </h4>
            </div>
            <div class="modal-body">
                <%--信息发送处理Servlet--%>
                <form action="#">
                    收件人ID：<input type="text" id="receiverID">
                    <div>
                        标题：<input  type="text" id="huifuTitle">
                    </div>
                    <div>
                        内容：<textarea cols="50" rows="10" id="huifuContent"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">放弃
                </button>
                <%--提交表单--%>
                <button type="button" class="btn btn-primary" onclick="huifu()">
                    发送
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->



</div>
<!-- 发送模态框（Modal） -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabe2">
                    站内信发送
                </h4>
            </div>
            <div class="modal-body">
                <%--信息发送处理Servlet--%>
                <form action="#">
                    <div>
                        收件人ID：<input type="text" id="receiverID1">
                    </div>
                    <div>
                        标题：<input  type="text" id="sendTitle">
                    </div>
                    <div>
                        内容：<textarea cols="50" rows="10" id="sendContent"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    放弃
                </button>
                <button type="button" class="btn btn-primary" onclick="send('save')">
                存草稿
                </button>
                <button type="button" class="btn btn-primary" onclick="send('send')">
                    发送
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<%--详情模态框--%>
<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabe3">
                    详情页
                </h4>
            </div>
            <div class="modal-body">
                    <div>
                        标题：<input type="text" id="detailTitle" readonly>
                    </div>
                    <div>
                        <br>内容：<textarea  id="detailContent" cols="50" rows="10" readonly></textarea>
                    </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<script>
    <%--回复函数--%>
    function huifu() {
//        alert($('#ceshi').val());
        //  alert(document.getElementById('ceshi').innerHTML);
        $.ajax({
            data:{
                "type":'send',
                "from_id":'<%=uid%>',//$("#uid").val(),
                "to_id":$("#receiverID").val(),
                "mes_title":$('#huifuTitle').val(),
                "mes_content":$('#huifuContent').val()
            },
            url:"UserMes",
            success:function (data) {
                if (data.toString() == 'success') {
//                    alert("chenggong");//换成想要的效果
//                    setTimeout("location.reload()", 5000);
                    location.reload();
                }
            },
            error:function () {
                $('#alter-fail-alert').show();
            }
        })
        ($(".huifu").siblings(".ssss").html());
    }
    //    发送、草稿函数
    //        obj为发送类型 分为 send（发送） 或 save（存草稿）
    function send(obj) {

        $.ajax({
            data:{
                "type":obj,
                "from_id":'<%=uid%>',//$("#uid").val(),// session不可用 应在body设置标签获得uid
                "to_id":$("#receiverID1").val(),
                "mes_title":$('#sendTitle').val(),
                "mes_content":$('#sendContent').val()
            },
            url:"UserMes",
            success:function (data) {
                if (data.toString() == 'success') {
//                    alert("成功");
                    //setTimeout("location.reload()", 2000);
                    location.reload();
                }
            },
            error:function () {
//                alert(shibai);
            }
        })
        //($(".huifu").siblings(".ssss").html());
    }

    //    收藏函数
    function collect(obj) {
        $.ajax({
            data:{
                "type":'collect',
                "from_id":$(obj).parent().parent().find('td').eq(5).text(),
                "to_id":$(obj).parent().parent().find('td').eq(6).text(),
                "uid":'<%=uid%>',//session$("#uid").val(),
                "mes_id":$(obj).parent().parent().find('td').eq(7).text()
            },
            url:"UserMes",
            success:function (data) {
                if (data.toString() == 'success') {
//                    alert("成功");
                    //setTimeout("location.reload()", 2000);
                    location.reload();
                }
            },
            error:function () {
                $('#alter-fail-alert').show();
            }
        })
    }
    //    批量删除函数
    function myDelete() {
        if($("input:checkbox:checked").length==0)
        {
            alert("未选择要删除的信息")
            return ;
        }
        document.forms[0].type.value='delete';
        document.forms[0].submit();
    }
    //批量已读函数
    function myRead() {
        if($("input:checkbox:checked").length==0)
        {
            alert("未选择标记已读的信息")
            return ;
        }
        document.forms[0].type.value='multiread';
        document.forms[0].submit();
    }
    // 显示模态框函数
    function huifuModal(obj) {
        var tds = $(obj).parent().parent().find('td');
        $('#receiverID').val(tds.eq(4).text());
        $('#myModal').modal('show');
    }

    function collectModal(obj) {
        var tds = $(obj).parent().parent().find('td');
        $('#receiverID').val(tds.eq(6).text());
        $('#huifuTitle').val(tds.eq(1).text());
        $('#huifuContent').val(tds.eq(2).text());
        $('#myModal').modal('show');
    }

    function myDetail(obj) {
        $.ajax({
            data: {
                "boxtype":$('#boxtype').val(),
                "type": 'read',
                "mes_id": $(obj).parent().parent().find('td').eq(7).text()
            },
            url: "UserMes"
        })
        var tds = $(obj).parent().parent().find('td');
        $('#detailTitle').val(tds.eq(1).text());
        $('#detailContent').val(tds.eq(2).text());
        $('#myModal3').modal('show');
    }
    function contact(obj) {
        $('#receiverID').val($(obj).text());
        $('#myModal').modal('show');
    }

    $(function () { $('#myModal3').on('hide.bs.modal', function () {
        location.href="innerMessage.jsp?queryType=<%=request.getParameter("queryType")%>";
    })});
</script>
</body>
</html>
