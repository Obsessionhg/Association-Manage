<%@ page import="dao.ActiDao" %>
<%@ page import="daoImpl.ActiDaoImpl" %>
<%@ page import="entity.Activity" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.PriDao" %>
<%@ page import="daoImpl.PriDaoImpl" %>
<%@ page import="java.net.URLEncoder" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <title>活动</title>

    <%--
    从数据库获得 集合
        UserInfoDao dao=new UserInfoDao();
        ArrayList list=dao.findAll();
    --%>
<script>
    //删除函数
    function myAction(pid) {
        document.forms[0].id.value=pid;
        //document.forms[0].op.value="delete";
        document.forms[0].submit();
    }

    function myAdd() {
        //document.forms[0].op.value="add";
        location.href="addActivity.jsp?op=add&org_id=<%=request.getParameter("org_id")%>";
    }

    function detail(title,content,date){
        $("#detail-title").html(title);
        $("#detail-content").html(content);
        $("#detail-date").html(date);
    }
</script>

    <%
        ActiDao actidao = new ActiDaoImpl();
        //List<Activity> list = actidao.queryAllActi();
        System.out.println(request.getParameter("org_id"));
        List<Activity> list = actidao.queryActiByOrg(Integer.parseInt(request.getParameter("org_id")));
       // Activity acti=list.get(0);
   %>

</head>
<body >
<div class="panel panel-heading" style="padding-left:40px;border-bottom-color:rgba(92,184,92,0.8);border-bottom-width:3px">
    <h4><b><i class="fa fa-coffee"></i>&nbsp活动管理</b></h4>
</div>
<div class="col-sm-10 col-sm-offset-1">
<%
    int PAGESIZE = 6;
    int pageCount;
    int curPage;
    pageCount = (list.size()+PAGESIZE-1)/PAGESIZE;
    if(pageCount==0) pageCount=1;
    String tem = request.getParameter("curPage");
    if(tem==null||tem.equals("0"))
        curPage = 1;
    else
        curPage = Integer.parseInt(tem);
    if(curPage > pageCount)
        curPage = pageCount;

    PriDao pridao = new PriDaoImpl();

    if(1==pridao.queryPri((String)session.getAttribute("uid"),Integer.parseInt(request.getParameter("org_id")),"priActi")){
%>
<div class="row">
<input type="button" value="发布活动" class=" btn btn-default pull-right" onclick="myAdd()" >
</div>
    <%}%>
    <div class="row">
    <table class="table table-striped table-hover" style="table-layout:fixed;">
    <tr>
        <th width="100">时间</th>
        <th width="100">标题</th>
        <th width="200">内容</th>
        <th width="100">
        <%
            if(1==pridao.queryPri((String)session.getAttribute("uid"),Integer.parseInt(request.getParameter("org_id")),"priActi")){
        %>
        操作
        <%}%>
        </th>
    </tr>
<%
    int t=(curPage-1)*PAGESIZE;
    for(int i=0;i<PAGESIZE&&(t+i)<list.size();i++){
        Activity acti=list.get(t+i);
%>

<form action="actiServlet" >
        <!-- 用于存放选择的id，然后会随表单提交给处理页面 -->
    <input type="hidden" name="id">
    <input type="hidden" name="op" value="delete">
    <tr>
           <td width="20%" style="word-wrap:break-word;"><%=acti.getAct_date().substring(0,10)%></td>
           <td width="20%" style="word-wrap:break-word;"><%=acti.getAct_title()%></td>
           <td width="40%" style="white-space: nowrap;text-overflow:ellipsis;overflow: hidden">
               <a  data-toggle="modal" data-target="#noti-detail" onclick='detail("<%=acti.getAct_title()%>",
                       decodeURI("<%=URLEncoder.encode(acti.getAct_content(),"utf-8")%>"),"<%=acti.getAct_date()%>")'>
                   <%=acti.getAct_content()%></a>
           </td>

           <td width="20%">
               <div>
                   <%
                        pridao = new PriDaoImpl();

                       if(1==pridao.queryPri((String)session.getAttribute("uid"),Integer.parseInt(request.getParameter("org_id")),"priActi")){
                   %>
                   <a href="addActivity.jsp?op=update&org_id=<%=request.getParameter("org_id")%>&id=<%=acti.getAct_id()%>&title=<%=acti.getAct_title()%>&content=<%=acti.getAct_content()%>"><i class="fa fa-pencil"></i></a>
                   <%--
                   此处onclick函数参数应为obj对象的getID方法
                   --%>
                   &nbsp;&nbsp;&nbsp;
                   <input type="hidden" name="org_id" value=<%=request.getParameter("org_id")%> >
                   <a onclick="myAction(<%=acti.getAct_id()%>)"><i class="fa fa-close"></i></a>
                   <%--<input type="button" class=" btn btn-default" value="删除" onclick="myAction(<%=acti.getAct_id()%>)"/>--%>
                   <%}%>
               </div>
           </td>
       </tr>

</form>
<%
    }
%>
</table>
    </div>
    <div class="row" style="text-align: center">
        <a href = "activity.jsp?curPage=1&org_id=<%=request.getParameter("org_id")%>" >首页</a>
        &nbsp
        <a href = "activity.jsp?curPage=<%=curPage-1%>&org_id=<%=request.getParameter("org_id")%>">上一页</a>
        &nbsp
        <a href = "activity.jsp?curPage=<%=curPage+1%>&org_id=<%=request.getParameter("org_id")%>">下一页</a>
        &nbsp
        <a href = "activity.jsp?curPage=<%=pageCount%>&org_id=<%=request.getParameter("org_id")%>">尾页</a>
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

</div>
</body>
</html>
