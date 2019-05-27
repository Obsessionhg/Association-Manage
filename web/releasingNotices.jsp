<%@ page import="wzy.CommunitySquare.CommSquare" %>
<%@ page import="entity.Img" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Video" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <link href="css\bootstrap.css"  rel="stylesheet">
    <script src="js\jquery-3.2.1.min.js"></script>
    <script src="js\bootstrap.js"></script>
    <link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <title>releasingNotices</title>
    <style>
        .body{
            border-radius: 5px;
            background: rgba(255,255,255,0.8);
        }
    </style>
</head>
<body>
<div class="panel panel-heading" style="padding-left:40px;border-bottom-color:rgba(92,184,92,0.8);border-bottom-width:3px"><h4><b><i class="fa fa-send"></i>&nbsp对外发布</b></h4></div>

<div style="overflow: hidden;background-color: white;border-radius: 5px;">
    <div class="col-sm-12">
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="#panel-635820" data-toggle="tab">广场新闻</a>
            </li>
            <li>
                <a href="#panel-635821" data-toggle="tab">广场公告</a>
            </li>
            <li>
                <a href="#panel-582637" data-toggle="tab">详情图片</a>
            </li>
            <li>
                <a href="#panel-video" data-toggle="tab">详情视频</a>
            </li>
            <li>
                <a href="#home-img" data-toggle="tab">管理已上传的图片</a>
            </li>
            <li>
                <a href="#home-video" data-toggle="tab">申请首页视频</a>
            </li>
        </ul>

        <div class="tab-content col-sm-12">
            <%--新闻提交 panel--%>
            <div class="tab-pane active fade in col-sm-8 col-sm-offset-2" id="panel-635820">
                <form action="/servlet/ApplyHomePageNewsServlet">
                    <div class="form-group">
                        <input class="form-control" type="hidden" name="org_id" value=<%=request.getParameter("org_id")%>>
                        <label for="title">标题</label>
                        <input id="title" class="form-control" type="text" name="title">
                        <label for="content">内容</label>
                        <textarea class="form-control" name="content" style="resize:none" id="content" cols="30" rows="10"></textarea>
                        <%--<input type="text" name="content"><br>--%>
                        <br>
                        <div id="news-apply-state" class="alert alert-success" style="display: none">提交成功，待审核，页面将于3秒后自动刷新</div>
                        <input type="button" onclick="submit_news()" class="btn btn-default form-control" value="提交审核">
                    </div>
                </form>
                </div>

                <script>
                    function submit_news(){
                        console.log("submit_news","$('#title').val()");
                        console.log("submit_news","$('#content').val()");
                        $.ajax({
                            url:'/servlet/ApplyHomePageNewsServlet',
                            data:{
                                org_id:<%=request.getParameter("org_id")%>,
                                title:$('#title').val(),
                                content:$('#content').val()
                            },
                            success:function(data){
                                if(data.toString()=='success'){
                                    $('#news-apply-state').show();
                                }
                                setTimeout('location.reload()',3000);
                            }
                        })
                    }
                </script>

            <%--公告提交 panel--%>
            <div class="tab-pane fade col-sm-8 col-sm-offset-2" id="panel-635821">
                <form action="applyNoti">
                    <div class="form-group">
                        <input class="form-control" type="hidden" name="org_id" value=<%=request.getParameter("org_id")%>>
                        <label for="title">标题</label>
                        <input id="title" class="form-control" type="text" name="title">
                        <label for="content">内容</label>
                        <textarea class="form-control" name="content" style="resize:none" id="content" cols="30" rows="10"></textarea>
                        <%--<input type="text" name="content"><br>--%>
                        <br>
                        <input type="hidden" name ="type" value="add">
                        <input type="submit" class="btn btn-default form-control">
                    </div>
                </form>
            </div>

            <%--图片上传 panel--%>
            <div class="tab-pane fade col-sm-8 col-sm-offset-2" id="panel-582637">
                <form id="uploadimg"
                      <%--action="/servlet/CommImgLoadServlet?org_id=<%=request.getParameter("org_id")%>"--%>
                      method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <%--<input class="form-control" type="hidden" name="org_id" value=<%=request.getParameter("org_id")%>>--%>
                        <label for="img-file">上传图片</label>
                        <input id="img-file" accept="image/*" type="file" name="uploadimg" class="btn btn-default form-control">
                            <input type="checkbox" name="is_portrait" id="is_portrait" value="1"><label for="is_portrait">设置为头像</label>
                            <input type="button" onclick="submit_img()" class="btn btn-default form-control">

                    </div>
                </form>
            </div>

            <%--视频上传--%>
                <div class="tab-pane fade col-sm-8 col-sm-offset-2" id="panel-video">
                    <form action="/servlet/VideoLoadServlet?org_id=<%=request.getParameter("org_id")%>" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <%--<input id="output" class="form-control" type="hidden" name="org_id" value=<%=request.getParameter("org_id")%>>--%>
                            <%--<%session.setAttribute("org_id",request.getParameter("org_id"));%>--%>
                            <label for="video-file">上传视频</label>
                            <input id="video-file" accept="video/mp4" type="file" name="uploadvideo" class="btn btn-default form-control">
                            <input type="submit" class="btn btn-default form-control">
                        </div>
                    </form>
                </div>

                <%--图片轮播上传--%>
                <div class="tab-pane fade col-sm-12" id="home-img">
                    <div class="row" style="margin:10px 0;">
                        <button class="btn btn-primary" onclick="apply_img()">申请加入轮播区</button>
                        <button class="btn btn-primary" onclick="delete_img()">删除</button>
                        <div class="alert alert-warning" id="no-pic-chossed" style="display:none;margin-top: 20px">您还没有选择要上传的图片</div>
                        <div class="alert alert-success" id="img-apply-success" style="display:none;margin-top: 20px">上传成功</div>
                        <div class="alert alert-warning" id="img-apply-fail" style="display:none;margin-top: 20px">上传失败请重试</div>
                    <%--<button class="btn btn-primary"></button>--%>
                    </div>
                    <form method="post" enctype="multipart/form-data">
                        <%--<div class="row col-md-8 col-md-offset-2" style="margin-top: 60px;border-radius:5px;padding:10px;background-color: rgba(255,255,255,0.8)" >--%>
                            <%--一个社团卡片--%>
                            <%
                                List<Img> imgList=CommSquare.getCommImgList(Integer.parseInt(request.getParameter("org_id")),0);
                                System.out.println("=======================页面上应显示的图片数目");
                                System.out.println(imgList.size());
                                if(imgList==null || imgList.size()==0){
                            %>
                            <div class="alert alert-primary">您还没有已经上传的图片</div>
                                <%
                            }else{
                                    Img img;
                                for(int i=0;i<imgList.size();i++){
                                    img=imgList.get(i);
                                    System.out.println(img.getImg_name()+" =============图片名称");
                            %>
                            <div class="col-sm-4 col-md-4">
                                <div class="thumbnail">
                                    <img src="uploadImg/<%=img.getImg_name()%>" style="overflow: hidden;width: 240px;height: 160px">
                                    <div class="caption">
                                        <span style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;display:inline-block;width: 200px"><%=img.getImg_name()%></span>
                                        <input type="checkbox" id="select_img" value="<%=img.getImg_id()%>" class="pull-right">
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                                }%>
                        <%--</div>--%>
                    </form>
                </div>

                <%--视频上首页--%>
                <div class="tab-pane fade col-sm-12" id="home-video">
                    <form method="post" enctype="multipart/form-data">
                    <div class="row" style="margin:10px 0;">
                        <button class="btn btn-primary" onclick="apply_video()">申请加入轮播区</button>
                        <button class="btn btn-primary" onclick="delete_video()">删除</button>
                        <div class="alert alert-warning" id="no-v-chossed" style="display:none;margin-top: 20px">您还没有选择要上传的视频</div>
                        <div class="alert alert-success" id="v-apply-success" style="display:none;margin-top: 20px">上传成功</div>
                        <div class="alert alert-warning" id="v-apply-fail" style="display:none;margin-top: 20px">上传失败请重试</div>
                        <%--<button class="btn btn-primary"></button>--%>
                    </div>

                        <%--<div class="row col-md-8 col-md-offset-2" style="margin-top: 60px;border-radius:5px;padding:10px;background-color: rgba(255,255,255,0.8)" >--%>
                        <%--一个社团卡片--%>
                        <%
                            List<Video> videoList= CommSquare.getVideoFromOrg(Integer.parseInt(request.getParameter("org_id")));
                            if(videoList==null || videoList.size()==0){
                        %>
                        <div class="alert alert-primary">您还没有已经上传的视频</div>
                        <%
                        }else{
                            Video video;
                            for(int i=0;i<videoList.size();i++){
                                video=videoList.get(i);
                                System.out.println(video.getVideo_name()+" =============图片名称");
                        %>
                        <div class="col-sm-4 col-md-4">
                            <div class="thumbnail">
                                <video src="uploadVideo/<%=video.getVideo_name()%>" style="overflow: hidden;width: 240px;height: 160px"></video>
                                <div class="caption">
                                    <span style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;display:inline-block;width: 200px"><%=video.getVideo_name()%></span>
                                    <input type="checkbox" id="select_video" value="<%=video.getVideo_id()%>" class="pull-right">
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            }%>
                        <%--</div>--%>
                    </form>
                </div>
        </div>
        </div>
    </div>
<script>
    function apply_img(){
        $('.alert').hide();
        var checkbox_array=$('#select_img:checked');
        if(checkbox_array.length==0){
            $('#no-pic-chossed').show();
//            setTimeout("$('#no-pic-chossed').hide()",2000);
            return;
        }
        var checkbox_value_array=new Array();
        for(var i=0;i<checkbox_array.length;i++){
            checkbox_value_array[i]=checkbox_array[i].value;
        }

        $.ajax({
            url:'/servlet/ApplyHomePageImgServlet',
            data:{
                img_id_array:JSON.stringify(checkbox_value_array)
            },
            success:function (data) {
                if(data.toString()=='success'){
                    $('#img-apply-success').show();
//                    setTimeout("$('#img-apply-success').hide()",2000);
                }else{
                    $('#img-apply-fail').show();
//                    setTimeout("$('#img-apply-fail').hide()",2000);
                }
            },
            error:function (data) {
                alert("啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊");
            }
        })
    }

    function apply_video(){
        $('.alert').hide();
        var checkbox_array=$('#select_video:checked');
        if(checkbox_array.length==0){
            $('#no-v-chossed').show();
//            setTimeout("$('#no-v-chossed').hide()",2000);
            return;
        }
        var checkbox_value_array=new Array();
        for(var i=0;i<checkbox_array.length;i++){
            checkbox_value_array[i]=checkbox_array[i].value;
        }

        $.ajax({
            url:'/servlet/ApplyHomePageVideoServlet',
            data:{
                video_id_array:JSON.stringify(checkbox_value_array)
            },
            success:function (data) {
                if(data.toString()=='success'){
                    $('#v-apply-success').show();
//                    setTimeout("$('#v-apply-success').hide()",2000);
                }else{
                    $('#v-apply-fail').show();
//                    setTimeout("$('#v-apply-fail').hide()",2000);
                }
            },
            error:function (data) {
                alert("啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊");
            }
        })
    }

    function delete_video(){
        $('.alert').hide();
        var checkbox_array=$('#select_img:checked');
        if(checkbox_array.length==0){
            $('#no-v-chossed').show();
//            setTimeout("$('#no-pic-chossed').hide()",2000);
            return;
        }
        var checkbox_value_array=new Array();
        for(var i=0;i<checkbox_array.length;i++){
            checkbox_value_array[i]=checkbox_array[i].value;
        }

        $.ajax({
            url:'/servlet/DelVideoServlet',
            data:{
                video_id_array:JSON.stringify(checkbox_value_array)
            },
            success:function (data) {
                if(data.toString()=='success'){
                    $('#v-apply-success').show();
//                    setTimeout("$('#v-apply-success').hide()",2000);
                }else{
                    $('#v-apply-fail').show();
//                    setTimeout("$('#v-apply-fail').hide()",2000);
                }
            },
            error:function () {
                alert("删除失败");
            }
        })
    }

    function delete_img(){
        $('.alert').hide();
        var checkbox_array=$('#select_img:checked');
        if(checkbox_array.length==0){
            $('#no-pic-chossed').show();
            setTimeout("$('#no-v-chossed').hide()",2000);
            return;
        }
        var checkbox_value_array=new Array();
        for(var i=0;i<checkbox_array.length;i++){
            checkbox_value_array[i]=checkbox_array[i].value;
        }
        $.ajax({
            url:'/servlet/DelCommImgServlet',
//            contentType: 'application/json',
//            dataType:'text',
            data:{
                img_id_array:JSON.stringify(checkbox_value_array)
            },
            success:function (data) {
                if(data.toString()=='success'){
//                    $('#img-apply-success').show();
//                    setTimeout("$('#v-apply-success').hide()",2000);
                }else{
//                    $('#img-apply-fail').show();
//                    setTimeout("$('#v-apply-fail').hide()",2000);
                }
            },
            error:function () {
                alert("删除失败");
            }
        })
    }

    function submit_img() {
        if($('#is_portrait').is(':checked')){
            $('#uploadimg').attr('action','/servlet/CommImgLoadServlet?org_id=<%=request.getParameter("org_id")%>&is_portrait=1');
            console.log('submit-checked');
        }else{
            $('#uploadimg').attr('action','/servlet/CommImgLoadServlet?org_id=<%=request.getParameter("org_id")%>&is_portrait=0');
            console.log('submit-unchecked');
        }
        $('#uploadimg').submit();
    }
    <%--alert(<%=request.getParameter("org_id")%>);--%>
</script>
</body>
</html>
