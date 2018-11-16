<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<%@ include file="/member/huiyuan_menu.jsp"%>
<head>
    <title>会员管理</title>

    <script>
        //JavaScript代码区域
        layui.use(['element','laydate','table'], function(){
            var element = layui.element;
            var laydate = layui.laydate;
            var table = layui.table;
            laydate.render({
                elem: '#registration_time'
                ,type: 'datetime'
            });
            laydate.render({
                elem: '#endDate'
                ,type: 'datetime'
            });
            table.render({
                elem: '#test'
                ,url:'${pageContext.request.contextPath}/newMember?method=getMemberList'
                //,width: 1900
                ,height: 580
                ,cols: [[
                    {type:'checkbox', fixed: 'left'}
                    ,{field:'id', width:100, title: 'ID',  fixed: 'left'}
                    // ,{field:'account_number', width:121, title: '账号',templet: '#accountTpl',align:'center'}
                    ,{field:'account_number', width:120, title: '会员昵称',templet:'#usernameTpl',align:'center' }
                    ,{field:'phone', width:120, title: '手机号',templet:'#telPhoneTpl',align:'center'}
                    ,{field:'Invitation_code', width: 100, title: '邀请码',templet:'#Invitation_code',align:'center'}
                    ,{field:'member_level', width:120, title: '会员类型', templet:'#member_levelTpl',align:'center'}
                    ,{field:'status', width:120, title: '账号状态', templet:'#statusTpl',align:'center'}
                    ,{field:'vip_start_time', width:150, title: 'VIP开启时间',align:'center',sort: true,templet:function (d) {
                        var index="";
                        if(d.vip_start_time==""){
                            index="----";
                        }else {
                            var index = "20" + d.vip_start_time.substr(0, 2) + "-" + d.vip_start_time.substr(2, 2) + "-" + d.vip_start_time.substr(4, 2) + " " + d.vip_start_time.substr(6, 2) + ":" + d.vip_start_time.substr(8, 2) + ":" + d.vip_start_time.substr(10, 2);
                        }
                        return index;
                    }}
                    ,{field:'vip_end_time', width:150, title: 'VIP结束时间',align:'center',sort: true,templet:function (d) {
                        var index="";
                        if(d.vip_end_time==""){
                            index="----";
                        }else {
                            var index = "20" + d.vip_end_time.substr(0, 2) + "-" + d.vip_end_time.substr(2, 2) + "-" + d.vip_end_time.substr(4, 2) + " " + d.vip_end_time.substr(6, 2) + ":" + d.vip_end_time.substr(8, 2) + ":" + d.vip_end_time.substr(10, 2);
                        }
                        return index;
                    }}
                    ,{field:'registration_time', width:200, title: '注册时间',align:'center',templet:function (d) {
                        var time = d.registration_time;
                        var index = timestampToTime(time);
                        return index;
                    }}
//                    ,{field:'source', width:150, title: '注册来源',templet:'#sourceTpl',align:'center'}
//                    ,{field:'wealth', width:150, title: '操作',toolbar:"#barDemo",align:'center'}
                ]]
                ,limit:20
                ,limits:[20,30,40,50,100]
                ,page: true
                ,response: {
                    statusName: 'success'
                    ,statusCode: 1
                    ,msgName: 'errorMessage'
                    ,countName: 'total'
                    ,dataName: 'rs'
                }
            });
            //点击按钮 搜索
            $('#searchBtn').on('click', function(){
                var account_number = $('#account_number');
                var phone = $('#phone');
                var status = $('#status');
                var registration_time = $('#registration_time');
                var endDate = $('#endDate');
//                var source = $('#source');
                var member_level = $('#member_level');
                table.reload('test', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        nick_name: account_number.val(),
                        phone: phone.val(),
                        status: status.val(),
                        registration_time: registration_time.val(),
                        endDate: endDate.val(),
//                        source: source.val(),
                        member_level: member_level.val()
                    }
                });
                return false;
            });




        });
        //调用启用
        function enable(){
            var table = layui.table;
            var checkStatus = table.checkStatus('test');
            var selectCount = checkStatus.data.length;
            if(selectCount==0){
                layer.msg("请选择一条数据！");
                return false;
            };
            //点击禁用按钮 弹框中的状态
            function disableaa(obj){
                var table = layui.table;
                layer.confirm('确定要禁用选中的项吗？',function(index){
                    layer.close(index);
                    var status =0;
                    $.ajax({
                        type: "get",
                        async : false, // 同步请求
                        cache :true,// 不使用ajax缓存
                        contentType : "application/json",
                        url : "${pageContext.request.contextPath}/newMember",
                        data : "method=updateMemberStatus&status=" + status +"&id="+obj,
                        dataType : "json",
                        success : function(data){
                            if (data.success) {
                                layer.msg("操作成功");
                                table.reload("selectMemberDown1");

                            } else {
                                layer.msg("异常");
                            }
                        }
                    })
                });
            };
            layer.confirm('确定要启用选中的项吗？',function(index){
                layer.close(index);
                var status = 1;
                var ids = new Array(selectCount);
                for(var i=0; i<selectCount; i++){
                    ids[i]=checkStatus.data[i].id;
                    if(checkStatus.data[i].status == 1){
                        layer.msg("已经是启用了！");
                        return false;
                    }
                }
                $.ajax({
                    type: "get",
                    async : false, // 同步请求
                    cache :true,// 不使用ajax缓存
                    contentType : "application/json",
                    url : "${pageContext.request.contextPath}/newMember",
                    data : "method=updateMemberStatus&status=" + status +"&id="+ids,
                    dataType : "json",
                    success : function(data){
                        if (data.success) {
                            layer.msg("操作成功");
                            table.reload("test")
                        } else {
                            layer.msg("异常");
                        }
                    }
                })
            })
        };
        //调用禁用
        function disable(){

            var table = layui.table;
            var checkStatus = table.checkStatus('test');
            var selectCount = checkStatus.data.length;
            if(selectCount==0){
                layer.msg("请选择一条数据！");
                return false;
            };
            //点击禁用按钮 弹框中的状态
            function disableaa(obj){

                var table = layui.table;
                layer.confirm('确定要禁用选中的项吗？',function(index){
                    layer.close(index);
                    var status =0;
                    $.ajax({
                        type: "get",
                        async : false, // 同步请求
                        cache :true,// 不使用ajax缓存
                        contentType : "application/json",
                        url : "${pageContext.request.contextPath}/newMember",
                        data : "method=updateMemberStatus&status=" + status +"&id="+obj,
                        dataType : "json",
                        success : function(data){
                            if (data.success) {
                                layer.msg("操作成功");
                                table.reload("selectMemberDown1");
                            } else {
                                layer.msg("异常");
                            }
                        }
                    })
                });
            };
            layer.confirm('确定要禁用选中的项吗？',function(index){
                layer.close(index);
                var status = 0;
                var ids = new Array(selectCount);
                for(var i=0; i<selectCount; i++){
                    ids[i]=checkStatus.data[i].id;
                    if(checkStatus.data[i].status == 0){
                        layer.msg("已经是禁用了！");
                        return false;
                    }
                }
                $.ajax({
                    type: "get",
                    async : false, // 同步请求
                    cache :true,// 不使用ajax缓存
                    contentType : "application/json",
                    url : "${pageContext.request.contextPath}/newMember",
                    data : "method=updateMemberStatus&status=" + status +"&id="+ids,
                    dataType : "json",
                    success : function(data){
                        if (data.success) {
                            layer.msg("操作成功");
                            table.reload("test")
                        } else {
                            layer.msg("异常");
                        }
                    }
                })
            })
        };
        //删除
        function m_del(){
            var table = layui.table;
            var checkStatus = table.checkStatus('test');
            var selectCount = checkStatus.data.length;
            if(selectCount==0){
                layer.msg("请选择一条数据！");
                return false;
            };

            layer.confirm('确定要删除选中的项吗？',function(index){
                layer.close(index);
                var del_status = 1;
                var ids = new Array(selectCount);
                for(var i=0; i<selectCount; i++){
                    ids[i]=checkStatus.data[i].id;
                }
                $.ajax({
                    type: "get",
                    async : false, // 同步请求
                    cache :true,// 不使用ajax缓存
                    contentType : "application/json",
                    url : "${pageContext.request.contextPath}/newMember",
                    data : "method=delNewMemberStatus&del_status=" + del_status +"&id="+ids,
                    dataType : "json",
                    success : function(data){
                        if (data.success) {
                            layer.msg("操作成功");
                            table.reload("test")
                        } else {
                            layer.msg("异常");
                        }
                    }
                })
            })
        };

        //编辑会员信息
        function m_edit(){
            var table = layui.table;
            var checkStatus = table.checkStatus('test');
            var selectCount = checkStatus.data.length;
            if(selectCount!=1){
                layer.msg("只能选择一条数据！");
                return false;
            };
            var ids =checkStatus.data[0].id;
            layer.open({
                type: 2,
                title: '会员管理--会员编辑',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '600px'],
                btn: ['保存','取消'],
                content: '${pageContext.request.contextPath}/member/member_edit.jsp',
                yes:function(index){
                    var res = window["layui-layer-iframe" + index].selectFunc();//子窗口的方法

                    $.ajax({
                        url: "${pageContext.request.contextPath}/newMember?method=updateNewMember",
                        data: {'jsonData':JSON.stringify(res),'id':ids},
                        contentType:"application/json",  //缺失会出现URL编码，无法转成json对象
                        cache: true,
                        async : false,
                        dataType: "json",
                        success:function(data) {
                            if(data.success){
                                layer.msg('会员修改成功',{time:2000}, function(){
                                    window.parent.location.reload();
                                    parent.layer.closeAll('iframe');
                                });
                            }else{
                                layer.msg("异常");
                            }
                        },
                        error : function() {
                            layer.alert("错误");
                        }
                    });
                },
                success: function(layero, index){
                    $.ajax({
                        type: "get",
                        async : false, // 同步请求
                        cache :true,// 不使用ajax缓存
                        contentType : "application/json",
                        url : "${ctx}/newMember?method=selectNewUpdata",
                        data:{'id':ids} ,
                        dataType : "json",

                        success : function(data){
                            var body = layer.getChildFrame('body', index); //巧妙的地方在这里哦
                            if (data.success == 1) {
                                var length = data.rs.length;
                                var array = data.rs;
                                //alert(JSON.stringify(array));
                                if(length ==0 ){
                                    alert("该会员没有详细信息！");
                                    return false
                                };
                                body.contents().find("#id").val(array[0].id);
                                body.contents().find("#nick_name").val(array[0].nick_name);
                                body.contents().find("#real_name").val(array[0].real_name);
                                body.contents().find("#phone").val(array[0].phone);
                                body.contents().find("#account_number").val(array[0].account_number);
                                body.contents().find("#Invitation_code").val(array[0].Invitation_code);
//                                body.contents().find("#member_level").val(array[0].member_level);

                                var rTime = array[0].registration_time;
                                if(rTime.length == 12){
                                    var et = array[0].registration_time;
                                    var registrationTime = "20" + et.substr(0, 2) + "-" + et.substr(2, 2) + "-" + et.substr(4, 2) + " " + et.substr(6, 2) + ":" + et.substr(8, 2) + ":" + et.substr(10, 2);
                                    body.contents().find("#registration_time").val(registrationTime);
                                }
                                body.contents().find("#source").val(array[0].source);
                            } else {
                                layer.msg("异常");
                            }
                        },error : function() {
                            layer.alert("错误");
                        }

                    })
                }
            });
            layui.form.render();
        };
        //添加会员信息
        function m_add(){
            layer.open({
                type: 2,
                title: '会员管理--添加会员',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '600px'],
                content: ['${pageContext.request.contextPath}/member/member_add.jsp', 'yes'], //iframe的url，no代表不显示滚动条

            });
        };

        //会员升级

        function upgrade(){
            var table = layui.table;
            var checkStatus = table.checkStatus('test');
            var selectCount = checkStatus.data.length;
            if(selectCount!=1){
                layer.msg("只能选择一条数据！");
                return false;
            };
            if(checkStatus.data[0].member_level == 2){
                layer.msg("普通会员才可以升级！");
                return false;
            };
            var ids =checkStatus.data[0].id;
            layer.open({
                type: 2,
                title: '会员管理--会员升级',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '600px'],
                btn: ['保存','取消'],
                content: '${pageContext.request.contextPath}/member/member_up.jsp',
                yes:function(index){
                    var res = window["layui-layer-iframe" + index].selectLevel();//子窗口的方法
                    var s_time = res.vip_start_time;
                    var e_time = res.vip_end_time;
                    if(s_time.length == 10 ){
                        s_time = s_time.substring(0,4)+s_time.substring(5,7)+s_time.substring(8,10) + "000000";
                    }else{
                        layer.msg("请填写开始时间！");
                        return false;
                    }
                    if(e_time.length == 10 ){
                        e_time = e_time.substring(0,4)+e_time.substring(5,7)+e_time.substring(8,10) + "000000";
                    }else{
                        layer.msg("请填写结束时间！");
                        return false;
                    }

                    if( Number(s_time) >= Number(e_time) ){
                        layer.msg("开始时间不能大于结束时间！");
                        return false;
                    }
                    $.ajax({
                        url: "${pageContext.request.contextPath}/newMember?method=upMemberLevel",
                        data: {'s_time':s_time,'e_time':e_time,'id':ids},
                        contentType:"application/json",  //缺失会出现URL编码，无法转成json对象
                        cache: true,
                        async : false,
                        dataType: "json",
                        success:function(data) {
                            if(data.success){
                                layer.msg('会员修改成功',{time:2000}, function(){
                                    window.parent.location.reload();
                                    parent.layer.closeAll('iframe');
                                });
                            }else{
                                layer.msg("异常");
                            }
                        },
                        error : function() {
                            layer.alert("错误");
                        }
                    });
                },
                success: function(layero, index){
                    $.ajax({
                        type: "get",
                        async : false, // 同步请求
                        cache :true,// 不使用ajax缓存
                        contentType : "application/json",
                        url : "${ctx}/newMember?method=selectNewUpdata",
                        data:{'id':ids} ,
                        dataType : "json",

                        success : function(data){
                            var body = layer.getChildFrame('body', index); //巧妙的地方在这里哦
                            if (data.success == 1) {
                                var length = data.rs.length;
                                var array = data.rs;
                                //alert(JSON.stringify(array));
                                if(length ==0 ){
                                    alert("该会员没有详细信息！");
                                    return false
                                };
                                body.contents().find("#id").val(array[0].id);
                                body.contents().find("#nick_name").val(array[0].nick_name);
                                body.contents().find("#real_name").val(array[0].real_name);
                                body.contents().find("#vip_start_time").val(array[0].vip_start_time);
                                body.contents().find("#vip_end_time").val(array[0].vip_end_time);
                                body.contents().find("#phone").val(array[0].phone);
                                body.contents().find("#account_number").val(array[0].account_number);
                                body.contents().find("#Invitation_code").val(array[0].Invitation_code);
                                body.contents().find("#member_level").val(array[0].member_level);

                                var rTime = array[0].registration_time;
                                if(rTime.length == 12){
                                    var et = array[0].registration_time;
                                    var registrationTime = "20" + et.substr(0, 2) + "-" + et.substr(2, 2) + "-" + et.substr(4, 2) + " " + et.substr(6, 2) + ":" + et.substr(8, 2) + ":" + et.substr(10, 2);
                                    body.contents().find("#registration_time").val(registrationTime);
                                }
                                body.contents().find("#source").val(array[0].source);
                            } else {
                                layer.msg("异常");
                            }
                        },error : function() {
                            layer.alert("错误");
                        }

                    })
                }
            });
            layui.form.render();
        };


        //时间转换
        function timestampToTime(timestamp) {
            var date = new Date(timestamp * 1000); //时间戳为10位需*1000，时间戳为13位的话不需乘1000
            var Y = date.getFullYear() + '-';
            var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
            var D = change(date.getDate()) + ' ';
            var h = change(date.getHours()) + ':';
            var m = change(date.getMinutes()) + ':';
            var s = change(date.getSeconds());
            return Y + M + D + h + m + s;
        }
        function change(t) {
            if (t < 10) {
                return "0" + t;
            } else {
                return t;
            }
        }


        /**
         * 自动将form表单封装成json对象
         */
        $.fn.serializeObject = function() {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name]) {
                    if (!o[this.name].push) {
                        o[this.name] = [ o[this.name] ];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };
    </script>

    <%-- 转时间 --%>
    <script id="create_timeTpl" type="text/html">
        {{#  if(d.registration_time !== ''){ }}
        <span style="color: rgba(10,10,10,0.46);">20{{ d.registration_time.substr(0,2) }}-{{ d.registration_time.substr(2,2) }}-{{ d.registration_time.substr(4,2) }} {{ d.registration_time.substr(6,2) }}:{{ d.registration_time.substr(8,2) }}:{{ d.registration_time.substr(10,2) }}</span>
        {{#  } else { }}
        <span style="color: rgba(10,10,10,0.46);">---</span>
        {{#  } }}
    </script>

    <%--改变状态--%>
    <script type="text/html" id="statusTpl">
        {{# if(d.status =='0'){}}
        <span style="color:#FF0000; ">禁用</span>
        {{# }else if(d.status =='1'){ }}
        启用
        {{# } }}
    </script>
    <%-- 会员类型--%>
    <script type="text/html" id="member_levelTpl">
        {{# if(d.member_level =='1'){}}
        <span style="color:green; ">普通会员</span>
        {{# }else if(d.member_level =='2'){ }}
        <span style="color:#FF0000; ">VIP会员</span>
        {{# } }}
    </script>
    <%--邀请码--%>
    <script type="text/html" id="Invitation_code">
        {{# if(d.Invitation_code ==''){}}
        <span style="color: rgba(10,10,10,0.46);"> ----</span>
        {{# }else { }}
        {{d.Invitation_code}}
        {{# } }}
    </script>
    <%--账号--%>
    <script type="text/html" id="accountTpl">
        {{# if(d.account_number ==''){}}
        <span style="color: rgba(10,10,10,0.46);"> ----</span>
        {{# }else { }}
        {{d.account_number}}
        {{# } }}
    </script>

    <%--手机号--%>
    <script type="text/html" id="telPhoneTpl">
        {{# if(d.phone ==''){}}
        <span style="color: rgba(10,10,10,0.46);"> ----</span>
        {{# }else { }}
        {{d.phone}}
        {{# } }}
    </script>

</head>
<script type="text/html" id="barDemo1">
    <a class="layui-btn layui-btn-xs layui-btn-normal layui-btn-radius" lay-event="look_orders">查看订单信息</a>
</script>

<!--主体部分 -->
<div class="layui-body">

    <!-- 上部分查询表单-->
    <div class="main-top" style="padding:5px 5px 0px 5px">

        <div class="layui-elem-quote">
            会员列表
        </div>

        <form class="layui-form layui-form-pane" >

            <div style="background-color: #f2f2f2;padding:5px 0">

                <div class="layui-form-item" style="margin-bottom:5px">

                    <label class="layui-form-label">账号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="nick_name" id="account_number" autocomplete="off"
                               class="layui-input">
                    </div>

                    <div class="layui-inline">
                        <label class="layui-form-label">状态</label>
                        <div class="layui-input-inline" >
                            <select id="status" name="status" lay-filter="statusI">
                                <option value=""></option>
                                <option value="1">启用</option>
                                <option value="0">禁用</option>
                            </select>
                        </div>
                    </div>

                </div>

                <div class="layui-form-item" style="margin-bottom: 0">


                    <label class="layui-form-label">注册手机号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="phone" id="phone" autocomplete="off"
                               class="layui-input">
                    </div>

                    <label class="layui-form-label"  >注册日期</label>
                    <div class="layui-input-inline" >
                        <input name="registration_time" id="registration_time" placeholder="开始日期" autocomplete="off" class="layui-input" type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                    </div>

                    <div class="layui-form-mid">-</div>

                    <div class="layui-input-inline" style="width: 150px" >
                        <input name="endDate" id="endDate" placeholder="结束日期" autocomplete="off" class="layui-input" type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                    </div>

                    <button id="searchBtn" class="layui-btn layui-btn-sm" style="margin-top: 5px;margin-left: 10px"><i class="layui-icon">&#xe615;</i>搜索</button>
                    <button type="reset" class="layui-btn layui-btn-sm" style="margin-top: 5px"><i class="layui-icon">&#x2746;</i>重置</button>


                </div>

            </div>


        </form>
        <div style="margin-top: 5px">
            <button class="layui-btn layui-btn-sm" onclick="disable()"><i class="layui-icon">&#x1007;</i>禁用</button>
            <button class="layui-btn layui-btn-sm" onclick="enable()"><i class="layui-icon">&#xe610;</i>启用</button>
            <button class="layui-btn layui-btn-sm" onclick="m_edit()"><i class="layui-icon">&#xe642;</i>编辑</button>
            <button class="layui-btn layui-btn-sm" onclick="m_del()"><i class="layui-icon">&#xe640;</i>删除</button>
            <button class="layui-btn layui-btn-sm" onclick="m_add()"><i class="layui-icon">&#xe61f;</i>添加</button>
            <button class="layui-btn layui-btn-sm" onclick="upgrade()"><i class="layui-icon"></i>会员升级</button>
        </div>
        <!-- 表格显示-->
        <table class="layui-hide" id="test" lay-filter="useruv"></table>
    </div>
    <%@ include file="/common/footer.jsp"%>
