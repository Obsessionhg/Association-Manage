<%@ page import="dao.NotiDao" %>
<%@ page import="daoImpl.NotiDaoImpl" %>
<%@ page import="entity.Notice" %>
<%@ page import="java.util.List" %>
<%@ page import="daoImpl.PriDaoImpl" %>
<%@ page import="dao.PriDao" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script> <link href="css/tinybox-style.css" rel="stylesheet">
    <script src="js/tinybox.js"></script>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <title>通知</title>
    <style>
        /*.row{*/
            /*margin: 0 auto;*/
            /*padding: 0 20px;*/
        /*}*/
    </style>
</head>
<script>
    //删除函数
    function myAction(pid) {
        document.forms[0].noti_id.value=pid;
        //document.forms[0].op.value="delete";
        document.forms[0].submit();
    }


</script>
<body height="500">
<div class="panel panel-heading" style="padding-left:40px;border-bottom-color:rgba(92,184,92,0.8);border-bottom-width:3px">
    <h4><b><i class="fa fa-comments"></i>&nbsp;公告通知</b></h4>
</div>
<%
    PriDao pridao = new PriDaoImpl();
    String org_id=request.getParameter("org_id");
    String uid = (String)session.getAttribute("uid");
    int t=pridao.queryPri(uid,Integer.parseInt(org_id),"priNoNews");
%>

<div class="row">
    <div class="col-sm-8 col-sm-offset-2">
        <%if(1==t){%>
        <button class="pull-right btn btn-default"
                <%--onclick="myAdd()"--%>
                style="margin:8px 0;" data-toggle="modal" data-target="#add-notice">发布通知</button>
        <%}%>
    <table class="table table-striped table-hover" style="table-layout: fixed">
        <tr>
            <th>标题</th>
            <th>详情简介</th>
            <th>发布时间</th>

            <%if(1==t){%>
            <th>操作</th>
            <%}%>
        </tr>

<%
            NotiDao actidao = new NotiDaoImpl();
            org_id = request.getParameter("org_id");
            int norg_id = Integer.parseInt(org_id);
            List<Notice> list = actidao.queryNotiByOrg(norg_id);

            int PAGESIZE = 6;
            int pageCount;
            int curPage;
            pageCount = (list.size()+PAGESIZE-1)/PAGESIZE;
            String tem = request.getParameter("curPage");
            if(tem==null||tem.equals("0"))
                curPage = 1;
            else
                curPage = Integer.parseInt(request.getParameter("curPage"));
            if(curPage > pageCount)
                curPage = pageCount;

            if(list.size()>0)
            {
                int tep=(curPage-1)*PAGESIZE;
                    for(int i=0;i<PAGESIZE&&(tep+i)<list.size();i++){
                        Notice noti =list.get(tep+i);
        %>
        <tr>
        <form action="notiServlet" >
            <input type="hidden" name="noti_id">
            <input type="hidden" name="org_id" value=<%=noti.getOrg_id()%>>
            <input type="hidden" name="op" value="delete">

            <td style="white-space: nowrap;text-overflow:ellipsis;overflow: hidden;">
                <%=noti.getNoti_title()%>
            </td>
            <td style="white-space: nowrap;text-overflow:ellipsis;overflow: hidden">
            <a data-toggle="modal" data-target="#noti-detail" onclick='
                $("#detail-title").html("<%=noti.getNoti_title()%>");
                $("#detail-content").html(decodeURI("<%=URLEncoder.encode(noti.getNoti_content(),"utf-8")%>"));
                $("#detail-date").html("<%=noti.getNoti_date()%>");'>
            <%=noti.getNoti_content()%></a>
            </td>
            <td><%=noti.getNoti_date().substring(0,10)%></td>

            <%if(1==t){%>
            <td><a onclick="myAction(<%=noti.getNoti_id()%>)"><i class="fa fa-close"></i></a>
            </td><%}%>

            <%--<input type="button" class="btn btn-default pull-right" value="详情" onclick="newTable(<%=noti.getNoti_id()%>)">--%>
        </form>
        </tr>
        <%
                }
            }
        %>
    </table>
    </div>
</div>
<div class="row" style="text-align: center">
    <a href = "message.jsp?curPage=1&org_id=<%=request.getParameter("org_id")%>" >首页</a>
    &nbsp
    <a href = "message.jsp?curPage=<%=curPage-1%>&org_id=<%=request.getParameter("org_id")%>">上一页</a>
    &nbsp
    <a href = "message.jsp?curPage=<%=curPage+1%>&org_id=<%=request.getParameter("org_id")%>">下一页</a>
    &nbsp
    <a href = "message.jsp?curPage=<%=pageCount%>&org_id=<%=request.getParameter("org_id")%>">尾页</a>
</div>

<div class="modal fade" id="add-notice" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <form action="notiServlet">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="">&times;</button>
                <h4 class="modal-title" id="myModalLabel">发布新通知</h4>
            </div>

            <div class="modal-body">

                <div class="form-group">
                    <label for="noti_title">标题</label>
                    <input type="hidden"  name="org_id" value=<%=request.getParameter("org_id")%>>
                    <input type="hidden"  name="op" value="add">

                    <input class="form-control" type="text" id="noti_title" name="noti_title" class="form-control" style="width: 200px">

                    <label for="noti_content">内容</label>
                    <textarea class="form-control" cols="50" rows="10" id="noti_content" name="noti_content" style="resize: none;"></textarea>
                </div>

                <div class="alert alert-success" id="success-alert" style="display: none">添加成员成功!本页面将于3秒后刷新</div>
                <div class="alert alert-danger" id="fail-alert" style="display:none">添加成员失败，请重试</div>
                <div class="alert alert-warning" id="warning-alert" style="display:none">成员已添加，请不要重复添加</div>
                <div class="alert alert-warning" id="nexist-alert" style="display:none">用户不存在</div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <input type="submit" class="btn btn-primary">
            </div>

            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
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
</div>

</body>
</html>
<script>
    <%--function myAdd() {--%>
        <%--location.href="addNotice.jsp?org_id=<%=org_id%>&op=add";--%>

    <%--}--%>


    function newTable(noti_id){
//        TINY.box.show({
//            url:'messageDetails.jsp?id='+noti_id,
//            height:400,
//            width:800,
//        })
        <%--<%--%>
        <%--NotiDao actidao_temp = new NotiDaoImpl();--%>
            <%--Notice temp=actidao.queryNotiByNoti()--%>
        <%--%>--%>
        <%--$('#detail-title').html(<%=%>)--%>
    }

//    function add_new_noti() {//提交函数,进行参数的检验
//        var name_msg=document.getElementById("sid");
//        var name=document.forms[0].noti_title;
//        name_msg.innerHTML="";
//
//        //判断name和password值不为空 否则警告
//        if(name.value.length==0) {
//            name_msg.innerHTML = "<font color='red'>*姓名为必填项</font>";
//            return;//中断函数
//        }
//
//        document.forms[0].submit();
//    }

//    function myback(org_id) {//返回函数，跳转到活动页面
//        location.href="message.jsp?org_id="+org_id;
//        //request.getRequestDispatcher("activity.jsp").forward(request,response);
//        //response.sendRedirect("activity.jsp");
//    }
</script>