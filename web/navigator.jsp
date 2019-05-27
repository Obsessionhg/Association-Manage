<%@ page import="dao.ComUserDao" %>
<%@ page import="daoImpl.ComUserDaoImpl" %>
<%@ page import="entity.Org_user" %>
<%@ page import="dao.CommuDao" %>
<%@ page import="daoImpl.CommuDaoImpl" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="top-bar">
    <div class="navbar" role="navigation">
        <div class="container">

            <div class="navbar-header">
                <a class="navbar-brand" href="#">社团管理系统</a>
            </div>

            <div>
                <ul class="nav navbar-nav pull-right">
                    <%
                        if(user==null){
                    %>

                    <li><a href="club-square.jsp">社团广场</a></li>
                    <li class="pull-right">
                        <%--此处用户名应调用接口获得  --%>
                        <a href="index.jsp">
                            登录
                        </a>
                    </li>
                    <%
                    } else {
                    %>
                    <input hidden id="user-id" value="<%=uid%>">
                    <li class="dropdown">
                        <a class="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">我加入的社团<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                            <%
                                ComUserDao comuserdao = new ComUserDaoImpl();
                                List<Org_user> list =comuserdao.queryOrgByUid(uid);
                                CommuDao commdao = new CommuDaoImpl();
                                for(int i =0;i<list.size();i++)
                                {
                                    Org_user org_user = list.get(i);
                            %>
                            <li role="presentation">
                                <a role="menuitem" tabindex="-1" href="outer-frame.jsp?org_id=<%=org_user.getOrg_id()%>"><%=commdao.queryCommuByOrg(org_user.getOrg_id()).getOrg_name()%></a>
                            </li>
                            <%}%>
                        </ul>
                    </li>

                    <li><a href="club-square.jsp">社团广场</a></li>
                    <%--这里要加头像--%>
                    <li><a href="personal-info.jsp" ><%=user.getUname()%></a></li>
                    <li><a href="innerMessage.jsp?queryType=receive"><span class="glyphicon glyphicon-envelope"></span></a></li>
                    <li><a href="exit"><span class="glyphicon glyphicon-log-out"></span></a></li>
                    <%}%>
                </ul>
            </div>
        </div>
    </div>
</div>
