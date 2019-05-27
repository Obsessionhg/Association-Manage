<%@ page import="dao.RecDao" %>
<%@ page import="daoImpl.RecDaoImp" %>
<%@ page import="entity.Recruitment" %>
<%@ page import="dao.UserDao" %>
<%@ page import="daoImpl.UserDaoImpl" %>
<%@ page import="dao.EnterDao" %>
<%@ page import="daoImpl.EnterDapImpl" %>
<%@ page import="entity.Enter" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.ComUserDao" %>
<%@ page import="daoImpl.ComUserDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: Elber
  Date: 2017/7/12
  Time: 14:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>招新系统</title>
    <link href="css/bootstrap.css"  rel="stylesheet">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.js"></script>

    <link href="css/tinybox-style.css" rel="stylesheet">
    <script src="js/tinybox.js"></script>

    <%--bootstrap table 相关--%>
    <script src="js/bootstrap-table-export.js"></script>
    <link href="css/bootstrap-table.css" rel="stylesheet">
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">

</head>
<%
    RecDao recdao = new RecDaoImp();
    //System.out.println(request.getParameter("org_id"));
    //Recruitment rec=recdao.queryAllByOrg(Integer.parseInt(request.getParameter("org_id"))).get(0);
%>
<body>
    <div class="panel panel-heading" style="padding-left:40px;border-bottom-color:rgba(92,184,92,0.8);border-bottom-width:3px"><h4><b><i class="fa fa-hand-paper-o"></i>&nbsp招新系统</b></h4></div>
    <div style="height: 500px;overflow: hidden;background-color: white;border-radius: 5px;">
        <div class="col-sm-12">
            <ul id="sub-system" class="nav nav-tabs">
                <li class="active">
                    <a href="#current-recuritment" id="sub-sys-1" data-toggle="tab">当前招新</a>
                </li>
                <li>
                    <a href="#sign-up-sheet" id="sub-sys-2" data-toggle="tab">报名表</a>
                </li>
                <li>
                    <a href="#sign-up-info" id="sub-sys-3" data-toggle="tab">报名情况</a>
                </li>
                <li>
                    <a href="#inspection" id="sub-sys-4" data-toggle="tab">人员审核</a>
                </li>
            </ul>
        </div>
        <div class="col-sm-offset-2 col-sm-8">
            <div id="sub-sys-content" class="tab-content">

                <%--标签1--%>
                <div class="tab-pane fade in active" id="current-recuritment" style="padding-top: 20px;">
                    <%
                        //RecDao recdao = new RecDaoImp();

                        if(recdao.queryAllByOrg(Integer.parseInt(request.getParameter("org_id"))).size()!=0)
                        {
                            Recruitment rec=recdao.queryAllByOrg(Integer.parseInt(request.getParameter("org_id"))).get(0);
                           // UserDao userdao = new UserDaoImpl();
                            ComUserDao comuserdao = new ComUserDaoImpl();
                            int nstat = rec.getStatus();
                            String stat;
                            if(nstat==1)
                            {
                                stat="正在招新中";
                            }
                            else
                            {

                                stat="已结束";
                            }

                    %>
                    <div id="event-on">
                        <div class="row">
                            <%--左侧信息栏--%>
                            <div class="panel panel-success col-sm-offset-3 col-sm-6" style="padding:0">
                                <div class="panel-heading panel-title">
                                    招新信息
                                </div>
                                <div class="panel-body">
                                    <table class="table">
                                        <tr>
                                            <td>主题</td>
                                            <td><%=rec.getRec_title()%></td>
                                        </tr>
                                        <tr>
                                            <td>发起人</td>
                                            <td><%=comuserdao.queryLeaderName(Integer.parseInt(request.getParameter("org_id")))%></td>
                                        </tr>
                                        <tr>
                                            <td>时间</td>
                                            <td><%=rec.getRelease_date()%></td>
                                        </tr>
                                        <tr>
                                            <td>状态</td>
                                            <td><%=stat%></td>
                                        </tr>
                                        <%--<tr>--%>
                                            <%--<td>目标人数</td>--%>
                                            <%--<td>40</td>--%>
                                        <%--</tr>--%>
                                    </table>
                                </div>
                            </div>
                                <div class="row col-sm-offset-3 col-sm-6" style="padding-top: 20px;text-align:center">
                                    <input hidden id="recruit-event-id" value="<%=request.getParameter("event-id")%>">
                                    <button class="btn btn-default" onclick="finish(<%=rec.getRec_id()%>)">结束本次招新</button>
                                    <%--<button class="btn btn-warning"  onclick="startNew()">启动新一期招新</button>--%>
                                    <button class="btn btn-warning"  onclick="deleteRec(<%=rec.getRec_id()%>)">删除招新</button>
                                </div>
                    </div>
                        <%--按钮操作区--%>

                    </div>
                    <%
                    } else {
                    %>

                    <div id="event-off">
                        <div class="alert alert-info">当前没有正在进行中的招新~</div>
                        <button class="btn btn-warning" onclick="startNew()">启动新一期招新</button>
                    </div>
                    <%
                        }
                    %>
                </div>

                <%--标签2--%>
                <div class="tab-pane fade" id="sign-up-sheet" style="padding-top:20px">
                    <div class="alert alert-info"><b>Tips:</b>每一次招新只能制作一张报名表哟~报名表生成后不可修改~</div>
                    <%--需要if分支进行判断是否已经有了一张报名表--%>
                    <%--若有则直接展示--%>
                    <%

                        if(recdao.queryAllByOrg(Integer.parseInt(request.getParameter("org_id"))).size()>0) {
                            Recruitment rec = recdao.queryAllByOrg(Integer.parseInt(request.getParameter("org_id"))).get(0);
                            String hasEnter=rec.getRec_need();
                            if(!hasEnter.equals("0,0,0,0,0,0")) {
                                String sheet_item=rec.getRec_need();
                                String[] items=null;
                                if(sheet_item!=null) {
                                    items = sheet_item.split(",");
                                }
                    %>
                                <div class="row">
                                    <button class="btn btn-primary"><a style="text-decoration: none;color:white" href="sign-up-table.jsp?rec_id=<%=rec.getRec_id()%>&org_id=<%=rec.getOrg_id()%>" target="_blank">查看报名表</a></button>
                                </div>
                                    <%--<div>--%>
                                        <%--<%--%>
                                            <%--if(items[0].equals("1")){--%>
                                        <%--%>--%>
                                       <%--姓名--%>
                                        <%--<%}%>--%>
                                        <%--<%--%>
                                            <%--if(items[1].equals("1")){--%>
                                        <%--%>--%>
                                            <%--性别--%>
                                        <%--<%}%>--%>
                                        <%--<%--%>
                                            <%--if(items[2].equals("1")){--%>
                                        <%--%>--%>
                                        <%--年级--%>
                                        <%--<%}%>--%>
                                        <%--<%--%>
                                            <%--if(items[3].equals("1")){--%>
                                        <%--%>--%>
                                        <%--qq--%>
                                        <%--<%}%>--%>
                                        <%--<%--%>
                                            <%--if(items[4].equals("1")){--%>
                                        <%--%>--%>
                                        <%--电话--%>
                                        <%--<%}%>--%>
                                        <%--<%--%>
                                            <%--if(items[5].equals("1")){--%>
                                        <%--%>--%>
                                        <%--email--%>
                                        <%--<%}%>--%>
                                        <%--&lt;%&ndash;<iframe src=""></iframe>&ndash;%&gt;--%>

                                        <%--<div id="table-"></div>--%>
                                    <%--</div>--%>
                            <%
                            }else{
                            %>
                            <%--若无，则新建一张报名表--%>
                            <div row><button class="btn btn-primary" onclick="newTable(<%=rec.getRec_id()%>)">新建一张表格</button> </div>
                            <%}
                        }else{%>
                    <div class="alert alert-info">当前没有正在进行中的招新~</div><%}
                    %>
                </div>

                <%--报名情况 标签3--%>
                <div class="tab-pane fade" id="sign-up-info">
                <%
                    if(recdao.queryAllByOrg(Integer.parseInt(request.getParameter("org_id"))).size()>0)
                    {
                        Recruitment rec = recdao.queryAllByOrg(Integer.parseInt(request.getParameter("org_id"))).get(0);
                        String hasEnter=rec.getRec_need();
                    EnterDao enterdao = new EnterDapImpl();
                    int num =enterdao.queryEnterByOrg(rec.getOrg_id(),rec.getRec_id()).size();

                %>
                    <div class="row" style="margin-top:20px">
                        <div class="col-sm-6">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    报名人数
                                </div>
                                <div class="panel-body" style="font-size: 20px;">
                                    <i class="fa fa-hand-paper-o pull-left"></i>
                                    <span class="pull-right"><%=num%></span>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    性别统计
                                </div>
                                <div class="panel-body" style="font-size:20px;">
                                    <div class="row" style="padding: 0;margin: 0">
                                        <p><i class="fa fa-female pull-left"></i>
                                            <span class="pull-right"><%=enterdao.querySexNum(rec.getRec_id(),"男").size()%></span></p>
                                    </div>

                                    <div class="row" style="padding: 0;margin: 0">
                                        <p><i class="fa fa-male pull-left"></i>
                                            <span class="pull-right"><%=enterdao.querySexNum(rec.getRec_id(),"女").size()%></span></p>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    报名人数
                                </div>
                                <div class="panel-body" style="font-size: 20px;">
                                    <table class="table" style="table-layout: fixed">
                                        <tr>
                                            <td width="70%">大一</td>
                                            <td width="30%"><%=enterdao.queryGradeNum(rec.getRec_id(),"大一").size()%></td>
                                        </tr>
                                        <tr>
                                            <td width="70%">大二</td>
                                            <td width="30%"><%=enterdao.queryGradeNum(rec.getRec_id(),"大二").size()%></td>
                                        </tr>
                                        <tr>
                                            <td width="70%">大三</td>
                                            <td width="30%"><%=enterdao.queryGradeNum(rec.getRec_id(),"大三").size()%></td>
                                        </tr>
                                        <tr>
                                            <td width="70%">大四</td>
                                            <td width="30%"><%=enterdao.queryGradeNum(rec.getRec_id(),"大四").size()%></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%----%>
                    <%--大一--%>
                    <%--大二--%>
                    <%--大三--%>
                    <%--大四--%>
                    <%}
                    else{
                        %>
                    <div class="alert alert-info" style="margin-top:20px">当前没有正在进行中的招新~</div>
                    <%}
                    %>
                </div>


                    <%--人员审核--%>
                <div class="tab-pane fade" id="inspection">
                    <div id="do-query">
                        <%--<form class="form-inline" role="form" style="float: left; width: 100%" method="post" id="query-form">--%>
                            <%--<div class="form-group">--%>
                                <%--<label for="orgCode">部门:</label>--%>
                                <%--<select class="form-control" id="orgCode" name="orgCode">--%>
                                    <%--<option value="">默认选择</option>--%>
                                    <%--<c:forEach var="data" items="${orgList}">--%>
                                        <%--<option value="${data.orgCode }">${data.orgName }</option>--%>
                                    <%--</c:forEach>--%>
                                <%--</select>--%>
                            <%--</div>--%>
                            <form action="agreeServlet" onsubmit="return false">
                            <div id="toolbar" class="toolbar"></div>
                            <div class="search"></div>
                            <%--<div class="form-group">--%>
                                <%--<label for="name">姓名</label>--%>
                                <%--<input type="text" class="form-control" name="userName" id="name"  placeholder="请输入报名人员姓名">--%>
                            <%--</div>--%>

                            <%--<div class="form-group">--%>
                                <%--<button type="button" id="queryBtn" onclick="doQuery();" class="btn btn-primary">查询</button>--%>
                            <%--</div>--%>
                            <%--<div class="form-group btn-right">--%>
                                <%--<button type="button" class="btn btn-primary" id="addBtn" onclick="addUser();">新增用户</button>--%>
                            <%--</div>--%>

                                    <%
                                        if(recdao.queryAllByOrg(Integer.parseInt(request.getParameter("org_id"))).size()>0)
                                        {
                                            %>
                                <div class="form-group btn-right">
                                    <%--<button type="button" class="btn btn-primary" id="admitBtn" onclick="admitUser();">批准成员</button>--%>
                                    <%--<input type="submit" class="btn btn-primary" >批准成员</input>--%>
                                    <%--<input type="submit" value="批准成员" class="btn btn-default pull-right">--%>
                                    <button class="btn btn-default" onclick="agree()">批准成员</button>
                                </div>
                                <%
                                            Recruitment rec = recdao.queryAllByOrg(Integer.parseInt(request.getParameter("org_id"))).get(0);
                                            String hasEnter=rec.getRec_need();
                                        String sheet_item=rec.getRec_need();
                                        String[] items=null;
                                        if(sheet_item!=null) {
                                            items = sheet_item.split(",");
                                        }
                                     %>
                                    <table class="table" style="table-layout:fixed;">
                                        <tr>
                                            <th width="100">用户名</th>
                                            <%
                                                if(items[0].equals("1")){
                                            %>
                                            <th width="70">姓名</th>
                                            <%}%>
                                            <%
                                                if(items[1].equals("1")){
                                            %>
                                            <th width="50">性别</th>
                                            <%}%>
                                            <%
                                                if(items[2].equals("1")){
                                            %>
                                            <th width="50">年级</th>
                                            <%}%>
                                            <%
                                                if(items[3].equals("1")){
                                            %>
                                            <th width="100">qq</th>
                                            <%}%>
                                            <%
                                                if(items[4].equals("1")){
                                            %>
                                            <th width="100">电话</th>
                                            <%}%>
                                            <%
                                                if(items[5].equals("1")){
                                            %>
                                            <th width="100">email</th>
                                            <%}%>
                                        </tr>
                                        <%
                                            EnterDao enterdao1 = new EnterDapImpl();
                                            int norg_id = Integer.parseInt(request.getParameter("org_id"));
                                            List<Enter> list=enterdao1.queryEnterByOrg(norg_id,rec.getRec_id());
                                            Enter enter = new Enter();
                                            for(int i =0;i<list.size();i++){
                                                 enter = list.get(i);

                                        %>
                                        <tr>

                                            <td width="100" style="word-wrap:break-word;"><%=enter.getUid()%></td>

                                            <%
                                                if(items[0].equals("1")){
                                            %>
                                            <td width="200" style="word-wrap:break-word;"><%=enter.getName()%></td>
                                            <%}%>
                                            <%
                                                if(items[1].equals("1")){
                                            %>
                                            <td width="200" style="word-wrap:break-word;"><%=enter.getSex()%></td>
                                            <%}%>
                                            <%
                                                if(items[2].equals("1")){
                                            %>
                                            <td width="200" style="word-wrap:break-word;"><%=enter.getGrade()%></td>
                                            <%}%>
                                            <%
                                                if(items[3].equals("1")){
                                            %>
                                            <td width="200" style="word-wrap:break-word;"><%=enter.getQq()%></td>
                                            <%}%>
                                            <%
                                                if(items[4].equals("1")){
                                            %>
                                            <td width="200" style="word-wrap:break-word;"><%=enter.getTel()%></td>
                                            <%}%>
                                            <%
                                                if(items[5].equals("1")){
                                            %>
                                            <td width="200" style="word-wrap:break-word;"><%=enter.getMail()%></td>
                                            <%}%>
                                            <td>
                                                <div>
                                                    <input type="hidden" name="org_id" value="<%=enter.getOrg_id()%>">
                                                    <input type="hidden" name="rec_id" value="<%=enter.getRec_id()%>">
                                                    <input type="checkbox" name="uid" value="<%=enter.getUid()%>">
                                                </div>
                                            </td>
                                        </tr>
                                        <%
                                            }

                                        %>
                                    </table>
                                    <%--<input type="submit" value="提交" class="btn btn-default pull-right">--%>
                                </form>
                        <%}else{%>
                            <div class="alert alert-info" style="margin-top:20px">当前没有正在进行中的招新~</div>
                        <%}%>
                    </div>

                    <div class="container" style="width: 100%">
                        <table id="main-table">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function agree() {
            if($("input:checkbox:checked").length==0)
            {
                alert("未选择要批准的成员")
                return ;
            }
            else{
//            document.forms[0].type.value='delete';
            document.forms[0].submit();}
        }
        function newTable(rec_id){
            TINY.box.show({
                url:'newEnterTable.jsp?org_id=<%=request.getParameter("org_id")%>&rec_id='+rec_id,
                mask:false,
                height:600,
                width:800
            })
        }

        function finish(rec_id) {
            var event_id=$("#recruit-event-id").val();
            $.ajax({
                data:{
                    "id":event_id,
                    "rec_id":rec_id,
                    <%--<%=rec1.getRec_id()%>,--%>
                    "type":'stop',
                    "org_id":<%=request.getParameter("org_id")%>
            <%--<%=rec1.getOrg_id()%>,--%>
                },
                url:"recMana",
                success:function(data){
                    if(data.toString()=='success'){
                       alert("第二成功停止");
                        location.href="recurit-sys.jsp?org_id=<%=request.getParameter("org_id")%>";
                    }else if(data.toString()=='stopped'){
                        alert("已经停止");
                    }
                    else{
                        alert("出错");
                    }
                }
            })
        }


        function startNew()  {
            TINY.box.show({
                url:'CreateRec.jsp?org_id=<%=request.getParameter("org_id")%>',
                mask:false,
                height:600,
                width:800
            })
            //document.forms[0].op.value="add";
            <%--location.href="CreateRec.jsp?op=add&org_id=<%=request.getParameter("org_id")%>>";--%>
        }

        function  deleteRec(rec_id){
            var event_id=$("#recruit-event-id").val();
            $.ajax({
                data:{
                    "id":event_id,
                    "rec_id":rec_id,
                    <%--<%=rec1.getRec_id()%>,--%>
                    "type":'delete',
                    "org_id":<%=request.getParameter("org_id")%>
                    <%--<%=rec1.getOrg_id()%>,--%>
                },
                url:"recMana",
                success:function(data){
                    if(data.toString()=='success'){
                        alert("成功删除");
                        location.href="recurit-sys.jsp?org_id=<%=request.getParameter("org_id")%>";
                    }else if(data.toString()=='fail'){
                        alert("请先停止上一次招新");
                    }
                    else{
                        alert("出错");
                    }
//
                }
            })
        }
        function startNewOne(){
            if($("#event-on").style.display.match("block")){
                finish();
            }

           $.ajax({
               url:"",
               success:function(data){
                   $("#recruit-event-id").val(data.event-id);
                   $("#event-on").style.display="block";
                   $("#evnet-off").style.display="none";

//                   注意，如果这里开启了一次新的招新，那么报名表页面的报名表应该也是新的，所以报名表页面应该能够捕获到id的变更
               }
           })
        }
    </script>
</body>
</html>
