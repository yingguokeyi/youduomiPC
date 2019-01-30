<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp"%>
<%@ include file="/common/common.jsp" %>
<%@ include file="/picture/picture_menu.jsp"%>

<%
//    String task_id = request.getParameter("task_id");
    String id = request.getParameter("id");
%>
<script>

    <%--var task_id = <%=task_id%>;--%>
    var id = <%=id%>;

    layui.use(['upload', 'element', 'form'], function () {
        var $ = layui.jquery
            , upload = layui.upload
            , element = layui.element;
        var form = layui.form;


        $.ajax({
            type: "get",
            async: false, // 同步请求
            cache: true,// 不使用ajax缓存
            contentType: "application/json",
            url: "${ctx}/task",
            data: "method=getUseUploadImg&id="+id,
            dataType: "json",
            success: function (data) {
                if (data.success == 1) {
                    var imgList = data.result.rs[0].result;
                    for (var i=0;i<imgList.length;i++){
                        for(var y=0;y<imgList[i].length;y++){
                            var image = imgList[i][y].image;
                             $('#showTaskImgDiv').append('<img src="'+ image +'" alt=" " class="layui-upload-img" id="showImg'+i+y+'" name="showImg'+i+y+'" style="width: 70%;height: 650px;margin-left: 15%;">')
                        }
                    }

                }else if(data.success == 2){
                    layer.msg("无图片");
                }else {
                    layer.msg("异常");
                }
            },
            error: function () {
                layer.alert("错误");
            }
        });

        $.ajax({
            type: "get",
            async: false, // 同步请求
            cache: true,// 不使用ajax缓存
            contentType: "application/json",
            url: "${ctx}/task",
            data: "method=getUseRexamineImg&id="+id,
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    var taskImgAll = data.rs[0].taskImg;
                    if(taskImgAll!=""){
                        console.log("img",taskImgAll);
                        var arr2 = new Array();
                        arr2 = taskImgAll.split(",");
                        for (var y=0;y<arr2.length ;y++ )
                        {
                            $('#showUserTaskImgDiv').append('<img src="'+ arr2[y] +'" alt=" " class="layui-upload-img" id="showImg'+y+'" name="showImg'+y+'"  style="width: 70%;height: 650px;margin-left: 15%;">')

                        }

                    }
                } else {
                    layer.msg("异常");
                }
            },
            error: function () {
                layer.alert("错误");
            }
        });


    });





</script>


<div class="layui-body" style="padding: 15px">

    <div class="layui-elem-quote">
            <span>
                <a>查看审核图片</a>&nbsp;&nbsp;
            </span>
        <button class="layui-btn  layui-btn-sm" style="margin-left: 50%" onclick="history.go(-1)">返回到审核列表</button>
    </div>

    <hr class="layui-bg-blue">
    <div class="layui-upload" style="width: 100%;overflow: hidden;">
        <div style="float: left;width: 49%;">
            <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">
                正确信息：
                <%--<div class="layui-upload-list" id="showTaskImgStepDiv">--%>

                <%--</div>--%>
                <div class="layui-upload-list" id="showTaskImgDiv">

                </div>
            </blockquote>
        </div>

        <div style="float: right;width: 49%;">
            <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;" >
                审核信息：
                <div class="layui-upload-list" id="showUserTaskImgDiv"></div>
            </blockquote>
        </div>

    </div>

</div>

<%@ include file="/common/footer.jsp" %>
