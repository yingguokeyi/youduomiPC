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



    function selectFunc() {

       var returnJson = {
           // "member_type": member_type,
           "nick_name": $("#nick_name").val(),
           "real_name": $("#real_name").val(),
           "phone": $("#phone").val(),
           "account_number":$("#account_number").val(),
           "Invitation_code":$("#Invitation_code").val(),
           "registration_time":$("#registration_time").val(),
           "source":$("#source").val(),
           "member_level":$("#member_level").val()

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
                <input type="text" name="account_number" id="account_number" lay-verify="required" autocomplete="off" class="layui-input" value="" style="width:190px;">
            </div>
        </div>
        <div class="layui-inline" style="margin-top:10px;">
            <label class="layui-form-label">&nbsp;&nbsp;手机号</label>
            <div class="layui-input-block">
                <input type="text" name="phone" id="phone"  lay-verify="phone|number" autocomplete="off" class="layui-input" disabled="disabled" style="width:190px;">
            </div>
        </div>
        <div class="layui-form-item" style="margin-top:10px;">
            <div class="layui-inline">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="real_name" id="real_name" lay-verify="required" autocomplete="off" class="layui-input" value="" style="width:190px;">
                </div>
            </div>

            </div>

            <div class="" style=""><span style="margin-left:30px;">账号信息</span></div>
            <div class="layui-form-item layui-form-text">
                <div class="layui-inline">
                    <label class="layui-form-label">账号</label>
                    <div class="layui-input-block">
                        <input type="text" name="nick_name"  id="nick_name" lay-verify="required" autocomplete="off"
                               class="layui-input" disabled="disabled" style="width: 190px;">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">邀请码</label>
                    <div class="layui-input-block">
                        <input type="text" name="Invitation_code" id="Invitation_code"  lay-verify="required" autocomplete="off"
                               class="layui-input" disabled="disabled" style="width: 190px;">
                    </div>
                </div>
            </div>
            <div class="" style=""><span style="margin-left:30px;">注册信息</span></div>
            <div class="layui-form-item">
                <label class="layui-form-label"> 注册时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="registration_time" id="registration_time" autocomplete="off" class="layui-input" type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">注册来源</label>
                    <div class="layui-input-inline">
                        <select name="source" id="source" >
                            <option value=""></option>
                            <option value="0">App-ios</option>
                            <option value="1">小程序</option>
                        </select>
                    </div>
                </div>
            </div>
    </form>

</div>
</body>
</html>
