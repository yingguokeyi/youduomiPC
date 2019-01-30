<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<%@ include file="/picture/picture_menu.jsp"%>
<head>
    <title>审核列表</title>

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
                ,url:'${pageContext.request.contextPath}/task?method=getUserTaskInfo'
                //,width: 1900
                ,height: 580
                ,cols: [[
                    {type:'numbers', fixed: 'left'}
//                    ,{type:'checkbox', fixed: 'left'}
                    ,{field:'wx_nick_name', width:150, title: '用户名',fixed: 'left',align:'center'}
                    ,{field:'category_name', width:250, title: '任务名称',fixed: 'left',align:'center'}
                    ,{field:'link_adress', width:150, title: '链接',align:'center'}
                    ,{field:'remark', width:250, title: '任务说明',align:'center',templet: function (d) {
                        if(d.remark !=""){
                            var taskJson = d.remark;
                            var jsonObject = JSON.parse(taskJson);

                            var str = '';
                            var s;
                            for(var p in jsonObject){
                                s = '步骤 '+p+': '+jsonObject[p].description+';  ';
                                str = str+s;
                            }
                            return str;
                        }else {
                            return "----";
                        }

                    }}
                    , {field: 'bonus', width: 150, title: '奖金(元)', align: 'center',templet: function (d) {
                        if (d.bonus == "0") {
                            return "￥" + d.bonus;
                        }
                        else {
                            return "￥" + d.bonus/100;
                        }
                    }}
                    ,{field:'task_begin_time', width:180, title: '开始时间',align:'center',sort: true,templet:function (d) {
                        var index="";
                        if(d.task_begin_time==""){
                            index="----";
                        }else {
                            var index = "20" + d.task_begin_time.substr(0, 2) + "-" + d.task_begin_time.substr(2, 2) + "-" + d.task_begin_time.substr(4, 2) + " " + d.task_begin_time.substr(6, 2) + ":" + d.task_begin_time.substr(8, 2) + ":" + d.task_begin_time.substr(10, 2);
                        }
                        return index;
                    }}
                    ,{field:'task_end_time', width:180, title: '结束时间',align:'center',sort: true,templet:function (d) {
                        var index="";
                        if(d.task_end_time==""){
                            index="----";
                        }else {
                            var index = "20" + d.task_end_time.substr(0, 2) + "-" + d.task_end_time.substr(2, 2) + "-" + d.task_end_time.substr(4, 2) + " " + d.task_end_time.substr(6, 2) + ":" + d.task_end_time.substr(8, 2) + ":" + d.task_end_time.substr(10, 2);
                        }
                        return index;
                    }}
                    ,{field:'status', width:80, title: '状态',align:'center',templet: '#statusTpl'}
                    ,{field:'tips_words', width:150, title: '备注',align:'center' }
                    ,{field:'auditor', width: 100, title: '审核人',align:'center'}
                    ,{field:'create_time', width:150, title: '创建时间',align:'center',sort: true,templet:function (d) {
                        var index="";
                        if(d.create_time==""){
                            index="----";
                        }else {
                            var index = "20" + d.create_time.substr(0, 2) + "-" + d.create_time.substr(2, 2) + "-" + d.create_time.substr(4, 2) + " " + d.create_time.substr(6, 2) + ":" + d.create_time.substr(8, 2) + ":" + d.create_time.substr(10, 2);
                        }
                        return index;
                    }}
                    ,{field:'wealth', width:180, title: '操作',templet:"#barDemo",align:'center'}
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
                var wx_nick_name = $('#wx_nick_name');
//                var phone = $('#phone');
                var status = $('#status');
                var start_time = $('#start_time');
                var end_time = $('#end_time');
                table.reload('test', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        wx_nick_name: wx_nick_name.val(),
//                        phone: phone.val(),
                        status: status.val(),
                        start_time: start_time.val(),
                        end_time: end_time.val()
                    }
                });
                return false;
            });


            //监听工具条
            table.on('tool(useruv)', function (obj) {
                var data = obj.data;
                if (obj.event === 'agree') {
                    agree(data)
                }else if (obj.event === 'refuse'){
                    refuse(data)
                }else if (obj.event === 'checks'){
//                    checks(data)
                    var task_id = data.task_id;
                    var id = data.id;
                    window.location.href = "${ctx}/picture/user_task_img.jsp?id="+id;
                }
            });

            //单个审核通过
            function agree(obj) {
                var status = 0;
                var id = obj.id;
                var task_end_time = obj.task_end_time;
                var refusal_reasons = '';
                var myDate = new Date();
                var Y = myDate.getFullYear(); //获取当前年份(2位)
                var M = myDate.getMonth()+1; //获取当前月份(0-11,0代表1月)
                var D = myDate.getDate(); //获取当前日(1-31)
                if( M.length =1){
                    M = '0'+M
                }
                var str = (Y+''+M+D).substring(2);

                if(str< task_end_time || task_end_time == '' ){
                    $.ajax({
                        //几个参数需要注意一下
                        type: "post",//方法类型
                        dataType: "json",//预期服务器返回的数据类型
                        url: "${ctx}/task?method=updateUserTaskStatus&status=" + status +"&task_end_time="+task_end_time +"&refusal_reasons="+refusal_reasons+"&id="+id,//url
                        async: true,
                        data: {
                            status: status,
                            id:id
                        },
                        success: function (res) {
                            var obj = JSON.parse(JSON.stringify(res));
                            if (obj.success == 1) {
                                layer.msg('操作成功', {time: 1000}, function () {
                                    window.location.reload();
                                });
                            }
                        },
                        error: function () {
                            layer.msg("异常");
                        },
                    });
                    return false;
                }else{
                    layer.msg("结束时间错误");
                    return false;
                }


            }


            //单个审核拒绝
            function refuse(obj) {
                var id = obj.id;
                var status = 2;
                var task_end_time = obj.task_end_time;

                var refusal_reasons = '';
                layer.prompt({
                    formType: 2,
                    value: '',
                    maxlength: 72,
                    title: '拒绝原因',
                    area: ['400px', '150px'] //自定义文本域宽高
                }, function(value, index){
                    if (value == "") {
                        layer.msg("拒绝原因不能为空");
                        return false;
                    }
                    refusal_reasons = value;
                    layer.close(index);

                    $.ajax({
                        //几个参数需要注意一下
                        type: "post",//方法类型
                        dataType: "json",//预期服务器返回的数据类型
                        url: "${ctx}/task?method=updateUserTaskStatus&status=" + status +"&task_end_time="+task_end_time +"&refusal_reasons="+refusal_reasons+"&id="+id,//url
                        async: true,
                        data: {id: id},
                        success: function (res) {
                            var obj = JSON.parse(JSON.stringify(res));
                            if (obj.success == 1) {
                                layer.msg('操作成功', {time: 1000}, function () {
                                    window.location.reload();
                                });
                            }
                        },
                        error: function () {
                            layer.msg("异常");
                        },
                    });
                    return false;

                });

            }

            //查看审核图片
            function checks(obj) {

            }
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

    <%--改变状态--%>
    <script type="text/html" id="statusTpl">
        {{# if(d.status =='1'){}}
        <span style="color:#FF0000; ">未审核</span>
        {{# }else if(d.status =='2'){ }}
        <span style="color:green; ">已拒绝</span>
        {{# }else if(d.status =='0'){ }}
        <span style="color:green; ">已通过</span>
        {{# }else if(d.status =='3'){ }}
        <span style="color:green; ">已过期</span>
        {{# } }}
    </script>

    <script type="text/html" id="barDemo">
        {{#  if(d.status == '0'){ }}
        <a  lay-event="checks" style="color: blue">查看</a>
        <a  style="color: grey">通过</a>
        <a  style="color: grey">拒绝</a>
        {{# }else if(d.status == '1'){ }}
        <a  lay-event="checks" style="color: blue">查看</a>
        <a  lay-event="agree" style="color: blue">通过</a>
        <a  lay-event="refuse" style="color: blue">拒绝</a>
        {{# }else if(d.status == '2'){ }}
        <a  lay-event="checks" style="color: blue">查看</a>
        <a  style="color: grey">通过</a>
        <a  style="color: grey">拒绝</a>
        {{# }else if(d.status == '3'){ }}
        <a  lay-event="checks" style="color: blue">查看</a>
        <a  style="color: grey">通过</a>
        <a  style="color: grey">拒绝</a>
        {{#  } }}
    </script>

</head>

<!--主体部分 -->
<div class="layui-body">

    <!-- 上部分查询表单-->
    <div class="main-top" style="padding:5px 5px 0px 5px">

        <div class="layui-elem-quote">
            审核列表
        </div>

        <form class="layui-form layui-form-pane" >

            <div style="background-color: #f2f2f2;padding:5px 0">

                <div class="layui-form-item" style="margin-bottom:5px">

                    <label class="layui-form-label">用户名：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="wx_nick_name" id="wx_nick_name" autocomplete="off"
                               class="layui-input">
                    </div>

                    <div class="layui-inline">
                        <label class="layui-form-label">审核状态</label>
                        <div class="layui-input-inline" >
                            <select id="status" name="status" lay-filter="statusI">
                                <option value=""></option>
                                <option value="3">待审核</option>
                                <option value="5">通过</option>
                                <option value="4">拒绝</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="layui-form-item" style="margin-bottom: 0">



                    <label class="layui-form-label" >提交日期</label>
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
            <%--<button class="layui-btn layui-btn-sm" onclick="refuses()"><i class="layui-icon">&#x1007;</i>拒绝</button>--%>
            <%--<button class="layui-btn layui-btn-sm" onclick="adopts()"><i class="layui-icon">&#xe610;</i>通过</button>--%>
            <%--<button class="layui-btn layui-btn-sm" onclick="revokes()"><i class="layui-icon">&#xe642;</i>撤销</button>--%>
        </div>
        <!-- 表格显示-->
        <table class="layui-hide" id="test" lay-filter="useruv"></table>
    </div>
    <%@ include file="/common/footer.jsp"%>
