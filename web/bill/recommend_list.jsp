<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<%@ include file="/bill/bill_menu.jsp"%>

<head>
    <title>账户明细查询</title>

    <script>
        //JavaScript代码区域
        layui.use(['element','laydate','table'], function(){
            var element = layui.element;
            var laydate = layui.laydate;
            var table = layui.table;
            laydate.render({
                elem: '#start_time'
                ,type: 'datetime'
            });
            laydate.render({
                elem: '#end_time'
                ,type: 'datetime'
            });
            table.render({
                elem: '#test'
                ,url:'${pageContext.request.contextPath}/bill?method=getRecommendList'
                //,width: 1900
                ,height: 580
                ,cols: [[
                    {type:'numbers', fixed: 'left'}
                    ,{type:'checkbox', fixed: 'left'}
//                    ,{field:'id', width:80, title: 'ID',  fixed: 'left',align:'center'}
                    ,{field:'user_id', width:100, title: '用户ID',fixed: 'left',align:'center'}
                    ,{field:'nick_name', width:150, title: '会员昵称',align:'center' }
                    ,{field:'edit_time', width:200, title: '时间',align:'center',sort: true,templet:function (d) {
                        var index="";
                        if(d.edit_time==""){
                            index="----";
                        }else {
                            var index = "20" + d.edit_time.substr(0, 2) + "-" + d.edit_time.substr(2, 2) + "-" + d.edit_time.substr(4, 2) + " " + d.edit_time.substr(6, 2) + ":" + d.edit_time.substr(8, 2) + ":" + d.edit_time.substr(10, 2);
                        }
                        return index;
                    }}
                    ,{field:'member_type', width:100, title: '奖励类型',templet:'#member_typeTpl',align:'center'}

                    ,{field:'profit', width:100, title: '金额',align:'center',templet: function (d) {
                        if (d.profit == "0") {
                            // 一样 显示一个即可
                            return "￥" + d.profit + "元";
                        }
                        else {
                            return "￥" + d.profit/100 + "元";
                        }
                    }}
                        ,{field:'notes', width:350, title: '备注',align:'center'}
//                    ,{field:'wealth', width:180, title: '操作',toolbar:"#barDemo",align:'center'}
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
                var user_id = $('#user_id');
                var phone = $('#phone');
                var start_time = $('#start_time');
                var end_time = $('#end_time');
                var member_type = $('#member_type');
                table.reload('test', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        user_id: user_id.val(),
                        phone: phone.val(),
                        start_time: start_time.val(),
                        end_time: end_time.val(),
                        member_type: member_type.val()
                    }
                });
                return false;
            });


        });


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


    <%--手机号--%>
    <script type="text/html" id="telPhoneTpl">
        {{# if(d.phone ==''){}}
        <span style="color: rgba(10,10,10,0.46);"> ----</span>
        {{# }else { }}
        {{d.phone}}
        {{# } }}
    </script>

    <%--状态--%>
    <script type="text/html" id="member_typeTpl">
        {{# if(d.member_type =='1'){}}
        <span style="color:green; ">奖励获取</span>
        {{# }else if(d.member_type =='2'){ }}
        <span style="color:green; ">返利获取</span>
        {{# } }}
    </script>


</head>

<!--主体部分 -->
<div class="layui-body">

    <!-- 上部分查询表单-->
    <div class="main-top" style="padding:5px 5px 0px 5px">

        <div class="layui-elem-quote">
            小票列表
        </div>

        <form class="layui-form layui-form-pane" >

            <div style="background-color: #f2f2f2;padding:5px 0">

                <div class="layui-form-item" style="margin-bottom:5px">

                    <label class="layui-form-label">用户ID</label>
                    <div class="layui-input-inline">
                        <input type="text" name="user_id" id="user_id" autocomplete="off"
                               class="layui-input">
                    </div>

                    <label class="layui-form-label">注册手机号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="phone" id="phone" autocomplete="off"
                               class="layui-input">
                    </div>

                </div>

                <div class="layui-form-item" style="margin-bottom: 0">

                    <div class="layui-inline">
                        <label class="layui-form-label">奖励类型</label>
                        <div class="layui-input-inline" >
                            <select id="member_type" name="member_type" lay-filter="statusI">
                                <option value=""></option>
                                <option value="1">奖励获取</option>
                                <option value="2">返利获取</option>
                            </select>
                        </div>
                    </div>

                    <label class="layui-form-label" >上传日期</label>
                    <div class="layui-input-inline" >
                        <input name="start_time" id="start_time" placeholder="开始日期" autocomplete="off" class="layui-input" type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                    </div>

                    <div class="layui-form-mid">-</div>

                    <div class="layui-input-inline" style="width: 150px" >
                        <input name="end_time" id="end_time" placeholder="结束日期" autocomplete="off" class="layui-input" type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                    </div>

                    <button id="searchBtn" class="layui-btn layui-btn-sm" style="margin-top: 5px;margin-left: 10px"><i class="layui-icon">&#xe615;</i>搜索</button>
                    <button data-type="reset" class="layui-btn layui-btn-sm" style="margin-top: 5px" data-type="reset"><i class="layui-icon">&#x2746;</i>重置</button>


                </div>

            </div>


        </form>
        <div style="margin-top: 5px">

        </div>
        <!-- 表格显示-->
        <table class="layui-hide" id="test" lay-filter="useruv"></table>
    </div>
    <%@ include file="/common/footer.jsp"%>
