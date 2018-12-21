<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
<%@ include file="/common/common.jsp"%>
<html>
<head>
    <title>会员管理--编辑会员</title>
</head>
<script>
    layui.use(['form', 'laydate','upload'], function () {
        var form = layui.form,upload = layui.upload, laydate = layui.laydate;
        /*//监听提交
         form.on('submit(formDemo)', function (data) {
         layer.msg(JSON.stringify(data.field));
         return false;
         });*/
        //日期
        laydate.render({
            elem: '#vip_start_time'
        });
        laydate.render({
            elem: '#vip_end_time'
        });
//        //时间选择器
        laydate.render({
            elem: '#registration_time'
            ,type: 'datetime'
        });
        //设定文件大小限制
        upload.render({
            elem: '#uploadImage'
            ,url: '/upload/'
            ,size: 60 //限制文件大小，单位 KB
            ,done: function(res){
                console.log(res)
            }
        });
    });



    function selectLevel() {

        var returnJson = {
            "vip_start_time": $("#vip_start_time").val(),
            "vip_end_time": $("#vip_end_time").val()
        };
        return returnJson;
    }
</script>
<body>
<div class="" style="background-color:#f2f2f2;"><span style="margin-left:30px;">联系人信息</span></div>
<div class="" style="">
    <form class="layui-form">
        <input type="hidden" name="id" id="id"/>
        <div class="layui-inline" style="margin-top:10px;">
            <label class="layui-form-label">会员昵称</label>
            <div class="layui-input-block">
                <input type="text" name="account_number" id="account_number" lay-verify="required" autocomplete="off"
                       class="layui-input" disabled="disabled" value="" style="width:190px;">
            </div>
        </div>
        <div class="layui-inline" style="margin-top:10px;">
            <label class="layui-form-label">&nbsp;&nbsp;手机号</label>
            <div class="layui-input-block">
                <input type="text" name="phone" id="phone"  lay-verify="phone|number" autocomplete="off"
                       class="layui-input" disabled="disabled" style="width:190px;">
            </div>
        </div>
        <div class="layui-form-item" style="margin-top:10px;">
            <div class="layui-inline">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="real_name" id="real_name" lay-verify="required" autocomplete="off"
                           class="layui-input" disabled="disabled" value="" style="width:190px;">
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label">账号</label>
                <div class="layui-input-block">
                    <input type="text" name="nick_name"  id="nick_name" lay-verify="required" autocomplete="off"
                           class="layui-input" disabled="disabled" style="width: 190px;">
                </div>
            </div>

        </div>
        <div class="layui-form-item layui-form-text">

            <div class="layui-inline">
                <label class="layui-form-label">邀请码</label>
                <div class="layui-input-block">
                    <input type="text" name="Invitation_code" id="Invitation_code"  lay-verify="required" autocomplete="off"
                           class="layui-input" disabled="disabled" style="width: 190px;">
                </div>
            </div>

            <label class="layui-form-label"> 注册时间</label>
            <div class="layui-input-inline">
                <input type="text" name="registration_time" id="registration_time" autocomplete="off"
                       class="layui-input" disabled="disabled" type="text" placeholder="yyyy-MM-dd HH:mm:ss">
            </div>
        </div>
        <div class="" style=""><span style="margin-left:30px;"><font size="5" face="arial" color="red">升级为VIP会员</font></span></div>
        <div class="layui-form-item">

        </div>
        <div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">VIP开启时间</label>
                    <div class="layui-input-block">
                        <input type="text" name="vip_start_time" id="vip_start_time" lay-verify="date" placeholder="年/月/日" autocomplete="off" class="layui-input" style="width:190px;">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">VIP结束时间</label>
                    <div class="layui-input-block">
                        <input type="text" name="vip_end_time" id="vip_end_time" lay-verify="date" placeholder="年/月/日" autocomplete="off" class="layui-input" style="width:190px;">
                    </div>
                </div>
            </div>
        </div>
    </form>

</div>
</body>
</html>
