<%--
  Created by IntelliJ IDEA.
  User: wzzz
  Date: 2017/7/12
  Time: 9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <script>

        function mysubmit() {//提交函数,进行参数的检验
            var test_uid=$("input[name='uid']").val();
            var aim_test=$("input[name='password']").val();
            if(test_uid.match(/^[a-zA-Z0-9]*[a-zA-Z][a-zA-Z0-9]*$/) && test_uid.length<=12 && test_uid.length>=3 && aim_test.match(/^[a-zA-Z0-9]{3,16}$/)){
                document.forms[0].submit();
            }
        }
        function myback() {//返回函数，跳转到活动页面
            location.href="index.jsp";
            //request.getRequestDispatcher("activity.jsp").forward(request,response);
            //response.sendRedirect("activity.jsp");
        }
    </script>
    <style>
        .sign-up-card{
            /*width:400px;*/
            margin: 60px auto;
            padding: 30px 50px 30px;
            background-color: rgba(255,255,255,0.9);
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0,0,0,.1);
            vertical-align: middle;
            display: inline-block;
        }
        .input-group{
            margin: 15px;
            width:100%;
        }
        .btn-sign-in{
            background-color: #5cb85c;
            color:white;
        }

        body{
            /*background-color: #f5f5f5;*/
            background-image: url(image/campus_1.jpg);
            background-size: cover;
            overflow: hidden;
        }
    </style>

    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/bootstrap.css"  rel="stylesheet">
    <script src="js/bootstrap-datetimepicker.min.js"></script>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
</head>
<body>

<div class="container">
    <div class="row col-md-4 col-md-offset-4 sign-up-card" style="text-align: center;width:500px">
        <div class="row" style="margin:0;padding:0;text-align: center">
            <h3 style="text-align: center">注册</h3>
            <small style="color: grey">——————————发现更多精彩——————————</small>
            <div class="column col-md-8 col-md-offset-2" style="margin-top:10px">
                <form action="register" class="form-group">
                    <div class="input-group">
                        <input type="text" required="required" name="uid" class="form-control" placeholder="用户名" onkeyup="testUid()">
                    </div>

                    <div class="input-group">
                        <input type="text" required="required" name="name" id="name" class="form-control" placeholder="姓名">
                    </div>
                    <div class="input-group">
                        <input type="password" name="password" required="required" id="pwd" class="form-control" placeholder="密码" onkeyup="testPwd()">
                    </div>
                    <div class="input-group">
                        <input type="text" id="birth" name="birth" required="required" class="form_datetime form-control" placeholder="生日" data-date-format="yyyy-mm-dd">
                    </div>
                    <div class="input-group">
                        <input type="email" name="email" required="required" id="email" class="form-control" placeholder="邮箱地址">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" id="validate" onclick="submit_identiCode()">发送验证码</button>
                        </span>
                    </div>
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="验证码" name="validateCode" maxlength="6" onkeyup="testValidate()">
                    </div>
                    <div class="input-group" style="margin-left: 5px;">
                        <label>性&nbsp&nbsp&nbsp别：</label>
                        <label class="checkbox-inline">
                            <input type="radio" name="sex" value="男">男
                        </label>
                        <label class="checkbox-inline">
                            <input type="radio" name="sex" value="女">女
                        </label>

                        <%--<input type="text" name="sex" id="sex" class="form-control" placeholder="性别">--%>
                    </div>
                    <input type="button" onclick="mysubmit()"  class="btn btn-sign-in" value="注册">
                    <input type="button" onclick="myback()"  class="btn btn-default" value="返回">
                </form>
            </div>
        </div>
        <div class="row">
            <div  id="alert-list"  class="alert alert-warning" style="display: none;margin-left: 10px;margin-right: 10px;text-align: left">
                <ul>
                    <li id="for-uid-illegal" style="display: none">用户名只能由数字和字母组成，至少包含一个字符且长度应为3-12位</li>
                    <li id="for-uid-dup" style="display: none">用户名已被占用</li>
                    <li id="for-pwd" style="display: none">密码只能由数字和字母组成，且长度应为3-16位</li>
                </ul>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript">
    $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd',
    minView:'month',
    autoclose:true});

    function testUid(){
        var aim_test=$("input[name='uid']").val();
        if(!aim_test.match(/^[a-zA-Z0-9]*[a-zA-Z][a-zA-Z0-9]*$/) || aim_test.length>12 || aim_test.length<3){
            $("#alert-list").show();
            $("#for-uid-illegal").show();
        }else{
            $("#for-uid-illegal").hide();
            test_display();
        }
        $.ajax({
            url:'/Checkuid',
            data:{'uid':$("input[name='uid']").val()},
            success:function(data){
                if(data.toString()=='duplicated'){
                    $("#alert-list").show();
                    $("#for-uid-dup").show();
                }else{
                    $("#for-uid-dup").hide();
                    test_display();
            }
        }})
    }

    function testPwd(){
        var aim_test=$("input[name='password']").val();
        if(!aim_test.match(/^[a-zA-Z0-9]{3,16}$/)){
            $("#alert-list").show();
            $("#for-pwd").show();
        }else{
            $("#for-pwd").hide();
            test_display();
        }
    }

    function test_display(){
        var listnode =document.getElementById('alert-list').getElementsByTagName('li');
        for( var i=0; i<listnode.length; i++){
            if(listnode[i].style.display!='none'){
                console.log(listnode[i].style.display!='none');
                console.log(listnode[i].textContent);
                console.log("有li不为空");
                return;
            }
        }
        document.getElementById("alert-list").style.display="none";
    }

    function submit_identiCode() {
        $("#validate").attr('disabled',true);
        var email=$("input[name='email']").val().trim();
        if(email==null||email=="") alert("请填写邮箱地址！！！");
        $.ajax({
            url:'subIdentiCode',
            data:{'email':email},
            success:function(data) {
                console.log(data.toString());
                if (data.toString().trim() == 'success') {
                    var timeout=60;
                    var t=setInterval(function () {
                        $("#validate").html((--timeout)+"秒后重新发送验证码");
                        if(timeout==-1){
                            clearInterval(t);
                            $("#validate").attr('disabled',false);
                            $("#validate").html("发送验证码");
                        }
                    },1000)
                } else {
                    $("#validate").attr('disabled',false);
                    alert("发送失败，请重新发送！");
                }
            },
            error:function () {
                $("#validate").attr('disabled',false);
            }
        });
    }
    
    function testValidate(){
        var code=$("input[name='validateCode']").val();
        console.log(code);
    }


</script>
</body>
</html>
