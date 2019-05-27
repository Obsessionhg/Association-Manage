<%@ page import="dao.ComUserDao" %>
<%@ page import="daoImpl.ComUserDaoImpl" %>
<%@ page import="entity.Org_user" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%@ page import="dao.UserDao" %>
<%@ page import="daoImpl.UserDaoImpl" %>
<%@ page import="daoImpl.PriDaoImpl" %>
<%@ page import="dao.PriDao" %><%--
  Created by IntelliJ IDEA.
  User: Elber
  Date: 2017/7/12
  Time: 10:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>成员信息页</title>
    <link href="css/bootstrap.css"  rel="stylesheet">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">


    <%
        UserDao userdao = new UserDaoImpl();
        ComUserDao comUserdao = new ComUserDaoImpl();
        String org_id=request.getParameter("org_id");
        String uid=(String)session.getAttribute("uid");
        List<Org_user> list3=comUserdao.queryUserByOrg(Integer.parseInt(org_id));
    %>
</head>
<body style="border-radius:5px">
<div class="panel panel-heading" style="padding-left:40px;border-bottom-color:rgba(92,184,92,0.8);border-bottom-width:3px"><h4><b><i class="fa fa-group"></i>&nbsp人员信息</b></h4></div>
<div style="height: 500px;overflow: hidden;background-color: white;border-radius: 5px;">
        <div class="col-sm-8 col-sm-offset-2" >

            <%--表头控制行相关 如新增--%>
            <div class="row" style="margin:10px 0;">
                <!-- 按钮触发模态框 -->
                <%
                    PriDao pridao = new PriDaoImpl();

                    if(1==pridao.queryPri(uid,Integer.parseInt(org_id),"priManaUser")){
                %>
                <div id="toolbar" class="btn-group pull-right" style="margin-bottom: 20px">
                    <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal" data-target="#add-member">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                    </button>
                    <%--<button id="btn_edit" type="button" class="btn btn-default">--%>
                    <%--<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改--%>
                    <%--</button>--%>
                    <button id="btn_delete" type="button" class="btn btn-default">
                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                    </button>
                </div>
                <%}%>

                <%--<button class="btn btn-primary" data-toggle="modal" data-target="#add-member">增加新成员</button>--%>
                <!-- 模态框（Modal） -->
                <div class="modal fade" id="add-member" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="add_alert_hide()">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">增加新成员</h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="new-mem-id">id</label>
                                    <input id="new-mem-id" type="text" class="form-control" placeholder="请输入用户id">

                                    <label for="new-mem-name">姓名</label>
                                    <input id="new-mem-name" type="text" class="form-control" placeholder="请输入姓名">
                                </div>
                                <div class="alert alert-success" id="success-alert" style="display: none">添加成员成功!本页面将于3秒后刷新</div>
                                <div class="alert alert-danger" id="fail-alert" style="display:none">添加成员失败，请重试</div>
                                <div class="alert alert-warning" id="warning-alert" style="display:none">成员已添加，请不要重复添加</div>
                                <div class="alert alert-warning" id="nexist-alert" style="display:none">用户不存在</div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="add_alert_hide()">关闭</button>
                                <button type="button" class="btn btn-primary" onclick="addNewMember()">添加</button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>
            </div>

            <div class="row">
                <table class="table table-striped table-hover" id="member-info">
                    <tr>
                        <th>用户ID</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>生日</th>
                        <th>职位</th>
                    <%
                        ComUserDao comuserdao = new ComUserDaoImpl();
                        boolean isLeader=comuserdao.queryUserByOrgUid(Integer.parseInt(request.getParameter("org_id")),(String)session.getAttribute("uid")).get(0).getPosition().equals("社长");
                        if(comuserdao.queryUserByOrgUid(Integer.parseInt(request.getParameter("org_id")),(String)session.getAttribute("uid")).get(0).getPosition().equals("社长"))
                        {
                    %>
                        <th>修改</th>
                    <%}%>
                    <%
                        pridao = new PriDaoImpl();

                        if(1==pridao.queryPri((String)session.getAttribute("uid"),Integer.parseInt(request.getParameter("org_id")),"priManaUser")){
                    %>
                        <th>移出社团</th>
                    <%}%>
                    </tr>

                    <%
                        int PAGESIZE = 6;
                        int pageCount;
                        int curPage;
                        pageCount = (list3.size()+PAGESIZE-1)/PAGESIZE;
                        String tem = request.getParameter("curPage");
                        if(tem==null||tem.equals("0"))
                            curPage = 1;
                        else
                            curPage = Integer.parseInt(request.getParameter("curPage"));
                        if(curPage > pageCount)
                            curPage = pageCount;

                        if(list3.size()>0){
//                        for(int i=0;i<list3.size();i++){
//                            Org_user org_user = list3.get(i);
                            int t=(curPage-1)*PAGESIZE;
                            for(int i=0;i<PAGESIZE&&(t+i)<list3.size();i++){
                                Org_user org_user=list3.get(t+i);

                            User user2 = userdao.queryUserByUid(org_user.getUid());
                    %>
                    <tr>
                        <td class="table-useful-data uid"><%=org_user.getUid()%></td>
                        <td class="table-useful-data"><%=user2.getUname()%></td>
                        <td class="table-useful-data"><%=user2.getSex()%></td>
                        <td class="table-useful-data"><%=user2.getBirth()%></td>
                        <td class="table-useful-data"><%=org_user.getPosition()%></td>
                        <%

                             comuserdao = new ComUserDaoImpl();
                            System.out.println(!comuserdao.queryUserByOrgUid(Integer.parseInt(request.getParameter("org_id")),(String)session.getAttribute("uid")).get(0).getPosition().equals("社长"));
                            if(comuserdao.queryUserByOrgUid(Integer.parseInt(request.getParameter("org_id")),(String)session.getAttribute("uid")).get(0).getPosition().equals("社长"))
                            {
                        %>
                        <td class="mi-update"><a data-toggle="modal" data-target="#update-member"><i class="fa fa-pencil"></i></a></td>
                        <%}%>
                        <%
                             pridao = new PriDaoImpl();

                            if(1==pridao.queryPri((String)session.getAttribute("uid"),Integer.parseInt(request.getParameter("org_id")),"priManaUser")){
                        %>
                        <td class="mi-delete"><a data-toggle="modal" data-target="#delete-member" onclick="passDeleteInfo(<%/*这里放jsp获取到的user-id*/%>)"><i class="fa fa-close"></i></a></td>

                    </tr>
                    <%}}}%>
                </table>
                <div class="row" style="text-align: center">
                    <a href = "member-info.jsp?curPage=1&org_id=<%=request.getParameter("org_id")%>" >首页</a>
                    &nbsp;
                    <a href = "member-info.jsp?curPage=<%=curPage-1%>&org_id=<%=request.getParameter("org_id")%>">上一页</a>
                    &nbsp;
                    <a href = "member-info.jsp?curPage=<%=curPage+1%>&org_id=<%=request.getParameter("org_id")%>">下一页</a>
                    &nbsp;
                    <a href = "member-info.jsp?curPage=<%=pageCount%>&org_id=<%=request.getParameter("org_id")%>">尾页</a>
                </div>

                <%--删除成员的模态框--%>
                <div class="modal fade" id="delete-member" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">注销成员</h4>
                            </div>
                            <div class="modal-body">
                                <span id="delete-member-id-array" style="display:none"></span>
                                <table id="delete-member-info" class="table table-striped">

                                </table>
                            <div class="alert alert-success" id="delete-success-alert" style="display: none">注销成员成功!本页面将于3秒后刷新</div>
                            <div class="alert alert-danger" id="delete-fail-alert" style="display:none">注销成员失败，请重试</div>
                            </div>
                            <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button type="button" class="btn btn-danger" onclick="deleteMember($('#delete-member-id-array').html())">确认注销</button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>

                <%--修改成员的模态框--%>
                <div class="modal fade" id="update-member" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">修改成员信息</h4>
                            </div>

                            <%--TO DO 如果有非注册信息 如职务之类的展示 则这里应该可以修改--%>
                            <div class="modal-body">
                                <%--<div class="form-group">--%>
                                    <%--<label for="alter-mem-id">id</label>--%>
                                    <%--<input id="alter-mem-id" type="text" class="form-control" placeholder="请输入用户id">--%>

                                    <%--<label for="alter-mem-name">职务</label>--%>
                                    <%--<input id="alter-mem-name" type="text" class="form-control" placeholder="请输入姓名">--%>
                                <%--</div>--%>
                                    <table id="alter-member-positon" class="table table-striped" width="100%">

                                    </table>
                                    <span id="alter-id" style="display: none"></span>
                                <div class="alert alert-success" id="alter-success-alert" style="display: none">修改成员成功!本页面将于3秒后刷新</div>
                                <div class="alert alert-danger" id="alter-fail-alert" style="display:none">修改成员失败，请重试</div><div class="alert alert-danger" id="alter-fail-alert" style="display:none">修改成员失败，请重试</div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                <button type="button" class="btn btn-primary" onclick="updateMember()">修改</button>
                            </div>

                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>

            </div>
        </div>
    </div>


</body>

<%--<body>--%>
<%--<div class="panel-body" style="padding-bottom:0px;">--%>
    <%--<div class="panel panel-default">--%>
        <%--<div class="panel-heading">查询条件</div>--%>
        <%--<div class="panel-body">--%>
            <%--<form id="formSearch" class="form-horizontal">--%>
                <%--<div class="form-group" style="margin-top:15px">--%>
                    <%--<label class="control-label col-sm-1" for="txt_search_departmentname">部门名称</label>--%>
                    <%--<div class="col-sm-3">--%>
                        <%--<input type="text" class="form-control" id="txt_search_departmentname">--%>
                    <%--</div>--%>
                    <%--<label class="control-label col-sm-1" for="txt_search_statu">状态</label>--%>
                    <%--<div class="col-sm-3">--%>
                        <%--<input type="text" class="form-control" id="txt_search_statu">--%>
                    <%--</div>--%>
                    <%--<div class="col-sm-4" style="text-align:left;">--%>
                        <%--<button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</form>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div id="toolbar" class="btn-group">--%>
        <%--<button id="btn_add" type="button" class="btn btn-default">--%>
            <%--<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增--%>
        <%--</button>--%>
        <%--<button id="btn_edit" type="button" class="btn btn-default">--%>
            <%--<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改--%>
        <%--</button>--%>
        <%--<button id="btn_delete" type="button" class="btn btn-default">--%>
            <%--<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除--%>
        <%--</button>--%>
    <%--</div>--%>
    <%--<table id="tb_departments"></table>--%>
<%--</div>--%>
<%--</body>--%>

<script>

    $('#member-info .mi-update').click(function(){
        var alter_table=$('#alter-member-positon');
        alter_table.empty();
        alter_table.append('<tr><th>用户ID</th><th>姓名</th><th>性别</th><th>生日</th><th>原始职位</th><th>修改后</th><th>管理成员权限</th><th>发布通知新闻权限</th><th>发布活动权限</th><th>交接社长</th></tr>');
        alter_table.append('<tr>');
        $(this).siblings('.table-useful-data').each(function(){
            alter_table.append('<td>'+$(this).html()+'</td>');
        });
        alter_table.append('<td><input id="aim-position" type="text" placeholder="请输入修改后的职位"></td>');
        alter_table.append('<td><input id="aim-priManaUser" type="checkbox" name="pri" onchange="changeval()" value="0"></td>');
        alter_table.append('<td><input id="aim-priNoNews" type="checkbox" name="pri" onchange="changeval()" value="0"></td>');
        alter_table.append('<td><input id="aim-priActi" type="checkbox" name="pri" onchange="changeval()" value="0" ></td>');
        alter_table.append('<td><input id="aim-leader" type="checkbox" name="pri" onchange="changeval()"  value="0"></td>');
        alter_table.append('</tr>');
        $("#alter-id").empty();
        $("#alter-id").append($(this).siblings('.uid').html());

    })

    $('#member-info .mi-delete').click(function(){
        alert('delete is called');
        $('#delete-member-info').empty();
        $('#delete-member-info').append('<tr>');
        $(this).siblings('.table-useful-data').each(function(){
            $('#delete-member-info').append('<td>'+$(this).html()+'</td>');
            }
        );
        $('#delete-member-info').append('</tr>');
        $('#delete-member-id-array').empty();
        $('#delete-member-id-array').append($(this).siblings('.uid').html());
    });



//    function passDeleteInfo(index){
////        index为-1表示是批量删除，需要读取复选框，
//        alert($('#member-info').row[index].innerHTML);
//        if(index>=0){
//            $('#delete-member-id-array').innerText='['+index+']';
//            $('#delete-mebmer-info').innerHTML='<tr>'+$('#member-info').row[index].innerHTML+'</tr>';
//        }else{
//            $(':checkbox')
//        }
//    }

    function changeval() {
        var check = document.getElementsByName("pri");
        for (var i = 0; i < check.length; i++) {
            if (check[i].checked == true) {
                check[i].value = "1";
            } else {
                check[i].value = "0";
            }
        }
    }

    function deleteMember(id_array){
        alert(id_array);
        $.ajax({
            data:{
                "id":id_array,
                "type":'delete',
                "org_id":<%=request.getParameter("org_id")%>
            },
//            这里填写url
            url:"ManaComUserServlet",
            success:function (data) {
                $('#delete-fail-alert').hide()
                $('#delete-success-alert').show();
                alert('show');
                setTimeout("location.reload()",3000);

            },
            error:function () {
                $('#delete-success-alert').hide();
                $('#delete-fail-alert').show();
            }
        })
    }

    function updateMember() {
//        alert($('#alter-id').html());
//        alert($('#aim-position').val());
//        alert($('#aim-priManaUser').val());
//        alert($('#aim-priNoNews').val());
//        alert($('#aim-priActi').val());
        if($('#aim-position').val()=='社长') {
            alert('职位不能为社长！');
            return;
        }
        $.ajax({
            data:{
                "id":$('#alter-id').html(),
                "type":'update',
                "org_id":<%=request.getParameter("org_id")%>,
                "position":$('#aim-position').val(),
                "priManaUser":$('#aim-priManaUser').val(),
                "priNoNews":$('#aim-priNoNews').val(),
                "priActi":$('#aim-priActi').val(),
                "leader":$('#aim-leader').val()
            },
            url:"ManaComUserServlet",
            success:function (data) {
                if (data.toString() == 'success') {
                    alert("成功");
                    $('#alter-success-alert').show();
                    setTimeout("location.reload()", 3000);
                }
            },
            error:function () {
                $('#alter-fail-alert').show();
            }
        })
    }

    function add_alert_hide(){
        $('#fail-alert').hide();
        $('#warning-alert').hide();
        $('#success-alert').hide();
    }

    function addNewMember() {
        alert($('#new-mem-id').val());
        add_alert_hide();
        $.ajax({
            data:{
                "type":'add',
                "id":$('#new-mem-id').val(),
                "org_id":<%=request.getParameter("org_id")%>
            },
            url:"ManaComUserServlet",
//            这里放新增社团用户用的servlet
            success:function(data){
                if(data.toString()=='success'){
                    $('#success-alert').show();
                    setTimeout("location.reload()",3000);
                }else if(data.toString()=='duplicated'){
                    $('#warning-alert').show();
                }else if(data.toString()=='nexist'){
                   $('#nexist-alert') .show();
                }
                else{
                    $('#fail-alert').show();
                }
            },
            error:function () {
                $('#fail-alert').show();
            }
        })
    }
//
    <%----%>
//    $(function () {
//
//        //1.初始化Table
//        var oTable = new TableInit();
//        oTable.Init();
//
//        //2.初始化Button的点击事件
//        var oButtonInit = new ButtonInit();
//        oButtonInit.Init();
//
//    });
//
//
//    var TableInit = function () {
//        var oTableInit = new Object();
//        //初始化Table
//        oTableInit.Init = function () {
//            $('#tb_departments').bootstrapTable({
//                url: '/Home/GetDepartment',         //请求后台的URL（*）
//                method: 'get',                      //请求方式（*）
//                toolbar: '#toolbar',                //工具按钮用哪个容器
//                striped: true,                      //是否显示行间隔色
//                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
//                pagination: true,                   //是否显示分页（*）
//                sortable: false,                     //是否启用排序
//                sortOrder: "asc",                   //排序方式
//                queryParams: oTableInit.queryParams,//传递参数（*）
//                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
//                pageNumber:1,                       //初始化加载第一页，默认第一页
//                pageSize: 10,                       //每页的记录行数（*）
//                pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
//                search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
//                strictSearch: true,
//                showColumns: true,                  //是否显示所有的列
//                showRefresh: true,                  //是否显示刷新按钮
//                minimumCountColumns: 2,             //最少允许的列数
//                clickToSelect: true,                //是否启用点击选中行
//                height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
//                uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
//                showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
//                cardView: false,                    //是否显示详细视图
//                detailView: false,                   //是否显示父子表
//                columns: [{
//                    checkbox: true
//                }, {
//                    field: 'Name',
//                    title: '部门名称'
//                }, {
//                    field: 'ParentName',
//                    title: '上级部门'
//                }, {
//                    field: 'Level',
//                    title: '部门级别'
//                }, {
//                    field: 'Desc',
//                    title: '描述'
//                }, ]
//            });
//        };
//
//        //得到查询的参数
//        oTableInit.queryParams = function (params) {
//            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
//                limit: params.limit,   //页面大小
//                offset: params.offset,  //页码
//                departmentname: $("#txt_search_departmentname").val(),
//                statu: $("#txt_search_statu").val()
//            };
//            return temp;
//        };
//        return oTableInit;
//    };
//
//
//    var ButtonInit = function () {
//        var oInit = new Object();
//        var postdata = {};
//
//        oInit.Init = function () {
//            //初始化页面上面的按钮事件
//        };
//
//        return oInit;
//    };
</script>
</html>
