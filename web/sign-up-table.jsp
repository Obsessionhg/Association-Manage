<%@ page import="wzy.CommunitySquare.Recruitment" %>
<%@ page import="wzy.CommunitySquare.CommSquare" %>
<%@ page import="entity.Community" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<%
    int rec_id=Integer.parseInt(request.getParameter("rec_id"));
    int org_id=Integer.parseInt(request.getParameter("org_id"));
    Recruitment recruitment= CommSquare.getRecruitmentFromId(org_id,rec_id);
    Community community=CommSquare.getCommunity(org_id);
    String org_name=community.getOrg_name();//    这里获取社团名，加入title中
    String sheet_item=recruitment.getRec_need();
    String[] items=null;
    if(sheet_item!=null) {
        items = sheet_item.split(",");
    }
%>
    <title><%=org_name%>报名表</title>

    <link href="css/bootstrap.css"  rel="stylesheet">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</head>
<body style="background-image: url('image/campus_blur_3.jpg')">
    <div class="container" style="height:100%;background-color:rgba(92,184,92,0.5);color:white">
        <div class="row col-sm-offset-3 col-sm-6" style="text-align: center">
            <h2>欢迎加入&nbsp;<%=org_name%></h2>
        </div>

        <div class="row col-sm-offset-4 col-sm-4" style="margin-top:20px;">
            <span id="org_id" style="display: none"><%=org_id%></span>
            <span id="rec_id" style="display: none"><%=rec_id%></span>
            <%
                if(items[0].equals("1")){
            %>
            <div class="form-group">
                <label for="user-name">姓名</label>
                <input class="form-control" type="text" name="user-name" id="user-name">
            </div>
            <%}%>

            <%
                if(items[1].equals("1")){
            %>
            <div class="form-group">
                <label for="user-name">性别</label>
                <input class="form-control" type="text" name="user-sex" id="user-sex">

            </div>
            <%}%>

            <%
                if(items[2].equals("1")){
            %>
            <div class="form-group">
                <label for="user-name">年级</label>
                <input class="form-control" type="text" name="user-grade" id="user-grade">
            </div>
            <%}%>

            <%
                if(items[3].equals("1")){
            %>
            <div class="form-group">
                <label for="user-name">QQ号</label>
                <input class="form-control" type="text" name="user-QQ" id="user-QQ">

            </div>
            <%}%>

            <%
                if(items[4].equals("1")){
            %>
            <div class="form-group">
                <label for="user-name">手机号</label>
                <input class="form-control" type="text" name="user-tele" id="user-tele">
            </div>
            <%}%>

            <%
                if(items[5].equals("1")){
            %>
            <div class="form-group">
                <label for="user-name">邮箱</label>
                <input class="form-control" type="text" name="user-email" id="user-email">
            </div>
            <%}%>

            <div class="row col-sm-12">
                <div id="sign-up-success" class="alert alert-success" style="display: none">报名成功,窗口将于5秒后关闭~</div>
                <div id="sign-up-duplicate" class="alert alert-warning" style="display: none">您已经报名过了~不必再重复提交啦</div>
                <div id="sign-up-fail" class="alert alert-danger" style="display: none">报名失败！请重试~</div>
            </div>

            <div class="row col-sm-offset-4 col-sm-4" style="text-align: center;">
                <div class="form-group">
                    <button class="btn btn-default" onclick="send()">报名</button>
                </div>
            </div>
        </div>
    </div>
            <script>
            function send(){
                $('#sign-up-success').hide();
                $('#sign-up-duplicate').hide();
                $('#sign-up-fail').hide();
                $.ajax({
                    url:'entertable',
                    data:{
                        'rec-id':$('#rec_id').html(),
                        'org-id':$('#org_id').html(),
                        'user-name':$('#user-name').val(),
                        'user-sex':$('#user-sex').val(),
                        'user-grade':$('#user-grade').val(),
                        'user-QQ':$('#user-QQ').val(),
                        'user-tele':$('#user-tele').val(),
                        'user-mail':$('#user-email').val()
                    },
                    success:function(data){
                        //success duplicated
                        if(data.toString()=='success'){
                            $('#sign-up-success').show();
                            setTimeout('window.close()',5000);
                        }else if(data.toString()=='duplicated'){
                            $('#sign-up-duplicate').show();
                        }else{
                            $('#sign-up-fail').show();
                        }
                    },error:function(){
                        $('#sign-up-fail').show();
                    }
                })
            }
        </script>
</body>
</html>
