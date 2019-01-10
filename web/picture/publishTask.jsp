<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<%@ include file="/common/common.jsp" %>
<%@ include file="/picture/picture_menu.jsp"%>
<script type="text/javascript" src="${ctx}/js/Utils.js?t=1515376178738"></script>

<script>
    function Map() {
        this.mapArr = {};
        this.arrlength = 0;

        //假如有重复key，则不存入
        this.put = function (key, value) {
            if (!this.containsKey(key)) {
                this.mapArr[key] = value;
                this.arrlength = this.arrlength + 1;
            }
        }
        this.get = function (key) {
            return this.mapArr[key];
        }

        //传入的参数必须为Map结构
        this.putAll = function (map) {
            if (Map.isMap(map)) {
                var innermap = this;
                map.each(function (key, value) {
                    innermap.put(key, value);
                })
            } else {
                alert("传入的非Map结构");
            }
        }
        this.remove = function (key) {
            delete this.mapArr[key];
            this.arrlength = this.arrlength - 1;
        }
        this.size = function () {
            return this.arrlength;
        }

        //判断是否包含key
        this.containsKey = function (key) {
            return (key in this.mapArr);
        }
        //判断是否包含value
        this.containsValue = function (value) {
            for (var p in this.mapArr) {
                if (this.mapArr[p] == value) {
                    return true;
                }
            }
            return false;
        }
        //得到所有key 返回数组
        this.keys = function () {
            var keysArr = [];
            for (var p in this.mapArr) {
                keysArr[keysArr.length] = p;
            }
            return keysArr;
        }
        //得到所有value 返回数组
        this.values = function () {
            var valuesArr = [];
            for (var p in this.mapArr) {
                valuesArr[valuesArr.length] = this.mapArr[p];
            }
            return valuesArr;
        }

        this.isEmpty = function () {
            if (this.size() == 0) {
                return false;
            }
            return true;
        }
        this.clear = function () {
            this.mapArr = {};
            this.arrlength = 0;
        }
        //循环
        this.each = function (callback) {
            for (var p in this.mapArr) {
                callback(p, this.mapArr[p]);
            }
        }
    };
    var categorySourceMap = new Map();

    var pictureIdCode = "";
    var pictureCode = "";
    // JavaScript 代码区域
    layui.use(['element','upload','laydate','table'], function(){
        var $ = layui.jquery;
        var laydate = layui.laydate;
        var table = layui.table;
        var form = layui.form;
        var upload = layui.upload;

        laydate.render({
            elem: '#edit_time'
            ,type: 'datetime'
        });
        laydate.render({
            elem: '#editend_time'
            ,type: 'datetime'
        });

        table.render({
            elem: '#test'
            ,url:'${pageContext.request.contextPath}/picture?method=getConsumerTaskList'
            ,height: 580
            ,cols: [[
                 {type:'checkbox',fixed: 'left'}
                ,{field:'id', width:100, title: '任务编号',align:'center',fixed: 'left',/*sort: true*/}
                ,{field:'nick_name', width:100, title: '申请人',align:'center'}
                ,{field:'category_name', width:150, title: '任务名称',align:'center'}
                /*,{field:'link_adress', width:150, title: '链接',align:'center'}*/
                , {field: 'bonus', width: 150, title: '投放单价(元)', align: 'center',templet: function (d) {
                        if (d.bonus == "0") {
                            return "￥" + d.bonus;
                        }
                        else {
                            return "￥" + d.bonus/100;
                        }
                    }}
                ,{field:'task_number', width:100, title: '投放数量（个）',align:'center'}
                ,{field:'task_end_time', width:160, title: '结束限制',align:'center',templet:'#endTimeTmpl'}
                ,{field:'task_time', width:160, title: '任务限制',align:'center'/*,templet:'#endTimeTmpl'*/}
                ,{field:'check_time', width:160, title: '审核周期',align:'center'/*,templet:'#endTimeTmpl'*/}
                ,{field:'create_time', width:160, title: '提交日期',align:'center',templet:'#createTimeTmpl'}
                //,{field:'update_time', width:180, title: '编辑时间',align:'center',templet:'#editTimeTmpl'}
                //,{field:'task_begin_time', width:180, title: '开始时间',align:'center',templet:'#createTimeTmpl'}
                ,{field:'status', width:80, title: '任务状态',align:'center',templet: '#statusTemplet'}
                ,{field:'check_reason', width:250, title: '备注',align:'center'}
                //,{field:'nick_name', width:200, title: '上传人',align:'center'}
                ,{fixed:'right',title:'操作', width:260,align:'center', toolbar: "#barDemo"}
            ]]
            ,id: 'listTable'
            ,limit:20
            ,limits:[50,100]
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
        $('#sreachBtn').on('click', function(){
            var nickName = $('#nickName').val();
            var status = $('#status').val();
            var taskId = $('#taskId').val();
            var edit_time = $('#edit_time').val();
            var editend_time = $('#editend_time').val();
            if(CompareDate(edit_time,editend_time)){
                layer.msg("开始时间不能大于结束时间");
                return false;
            }
            table.reload('listTable', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                ,where: {
                    nickName: nickName,
                    status: status,
                    taskId:taskId,
                    edit_time: edit_time,
                    editend_time: editend_time
                }
            });
            return false;
        });

        function CompareDate(d1,d2){
            return ((new Date(d1.replace(/-/g,"\/"))) > (new Date(d2.replace(/-/g,"\/"))));
        }
//监听工具条
        table.on('tool(picuresList)', function(obj){
                var data = obj.data;
                if (obj.event === 'agree') {
                    agree(data)
                }else if (obj.event === 'refuse'){
                    refuse(data)
                }else if (obj.event === 'checks'){
//                    checks(data)
                    //var task_id = data.task_id;
                    var id = data.id;
                    var createTime = data.create_time;
                    var status = data.status;
                    var category_name = data.category_name;
                    var bonus = data.bonus;
                    var task_number = data.task_number;
                    var task_end_time = data.task_end_time;
                    var task_time = data.task_time;
                    var check_task_time = data.check_time;
                    window.location.href = "${ctx}/picture/task_detail.jsp?id="+id+"&createTime="+createTime+"&status="+
                    status+"&category_name="+category_name+"&bonus="+bonus+"&task_number="+task_number+"&task_end_time="+
                    task_end_time+"&task_time="+task_time+"&check_task_time="+check_task_time;
                }
        });

        //单个审核拒绝
        function refuse(obj) {
            var task_id = obj.id;
            var remarks = '';
            layer.prompt({
                formType: 2,
                value: '',
                maxlength: 72,
                title: '拒绝原因',
                area: ['400px', '150px'] //自定义文本域宽高
            }, function(value, index){
//                    alert(value); //得到value
                remarks = value;
                if (value == "") {
                    layer.msg("拒绝原因不能为空");
                    return false;
                }
                remarks = value;
                layer.close(index);
                $.ajax({
                    //几个参数需要注意一下
                    type: "post",//方法类型
                    dataType: "json",//预期服务器返回的数据类型
                    url: "${ctx}/picture?method=updatePictureStatus&status=1&ids=" + task_id+"&code=0&reason="+remarks,//url
                    async: true,
                    data: {task_id: task_id},
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
//                alert(remarks);

        }

        //单个审核通过
        function agree(obj) {
            var task_id = obj.task_id;
            var remarks = '';
            var bonus = obj.bonus;
            var id = obj.id;

            $.ajax({
                //几个参数需要注意一下
                type: "post",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "${ctx}/picture?method=updatePictureStatus&status=0&ids=" + id+"&code=0&reason="+remarks,//url
                async: true,
                data: {task_id: task_id,
                    bonus:bonus,
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
        }
    });

</script>
<!-- 图片 -->
<script type="text/html" id="imgPath">
    {{# if(d.image ==''){}}
    <%--<img lay-event="edit" src={{d.img_path}} height="50" width="80">--%>
    ---
    {{# }else if(d.image != ''){ }}
    <img src={{d.image}} height="50" width="100">
    {{# } }}
</script>
<%--状态--%>
<script type="text/html" id="statusTemplet">
    {{#  if(d.status === '0'){ }}
    <span><font color="#32cd32">通过</font></span>
    {{#  } else if(d.status === '1'){ }}
    <span><font color="red">拒绝</font></span>
    {{#  } else if(d.status === '2'){ }}
    <span><font color="orange">待审核</font></span>
    {{#  } }}
</script>
<!-- 编辑时间-->
<script type="text/html" id="editTimeTmpl">
    {{# if(d.update_time ==''){}}
    <span style="color: rgba(10,10,10,0.46);text-align: center;width: 100%;height: 100%;display: inline-block;"> ----</span>
    {{# }else { }}
    20{{ d.update_time.substr(0,2) }}-{{ d.update_time.substr(2,2) }}-{{ d.update_time.substr(4,2) }} {{ d.update_time.substr(6,2) }}:{{ d.update_time.substr(8,2) }}:{{ d.update_time.substr(10,2) }}
    {{# } }}
</script>
<!--创建时间 -->
<script type="text/html" id="createTimeTmpl">
    {{# if(d.task_begin_time ==''){}}
    <span style="color: rgba(10,10,10,0.46);text-align: center;width: 100%;height: 100%;display: inline-block;"> ----</span>
    {{# }else { }}
    20{{ d.task_begin_time.substr(0,2) }}-{{ d.task_begin_time.substr(2,2) }}-{{ d.task_begin_time.substr(4,2) }} {{ d.task_begin_time.substr(6,2) }}:{{ d.task_begin_time.substr(8,2) }}:{{ d.task_begin_time.substr(10,2) }}
    {{# } }}
</script>

<script type="text/html" id="endTimeTmpl">
    {{# if(d.task_end_time ==''){}}
    <span style="color: rgba(10,10,10,0.46);text-align: center;width: 100%;height: 100%;display: inline-block;"> ----</span>
    {{# }else { }}
    20{{ d.task_end_time.substr(0,2) }}-{{ d.task_end_time.substr(2,2) }}-{{ d.task_end_time.substr(4,2) }} {{ d.task_end_time.substr(6,2) }}:{{ d.task_end_time.substr(8,2) }}:{{ d.task_end_time.substr(10,2) }}
    {{# } }}
</script>
<!-- 操作 -->
<script type="text/html" id="barDemo">
    {{#  if(d.status == '2'){ }}
    <a  lay-event="checks" style="color: blue">查看</a>
    <a  lay-event="agree" style="color: blue">通过</a>
    <a  lay-event="refuse" style="color: blue">拒绝</a>
    {{# }else if(d.status == '1'){ }}
    <a  lay-event="checks" style="color: blue">查看</a>
    <a  style="color: grey">通过</a>
    <a  style="color: grey">拒绝</a>
    {{# }else if(d.status == '0'){ }}
    <a  lay-event="checks" style="color: blue">查看</a>
    <a  style="color: grey">通过</a>
    <a  style="color: grey">拒绝</a>
    {{#  } }}
</script>

<!-- 内容主体区域 -->
<div class="layui-body">
    <!-- 上部分查询表单-->
    <div class="main-top" style="padding:5px 5px 0px 5px">
        <div class="layui-elem-quote">
            任务发布
        </div>
        <form class="layui-form layui-form-pane" >
            <div style="background-color: #f2f2f2;padding:5px 0">
                <div class="layui-form-item" style="margin-bottom:5px">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-inline">
                        <input type="text" name="nickName" id="nickName" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">任务编号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="taskId" id="taskId" autocomplete="off"
                               class="layui-input">
                    </div>

                    <label class="layui-form-label" style="width: 150px">状态</label>
                    <div class="layui-input-inline">

                        <div class="layui-input-inline" >
                            <select id="status" name="status" lay-filter="statusI">
                                <option value=""></option>
                                <option value="0">通过</option>
                                <option value="1">拒绝</option>
                                <option value="2">待审核</option>
                            </select>
                        </div>

                    </div>

                    <label class="layui-form-label" style="width: 120px">提交时间</label>
                    <div class="layui-input-inline" >
                        <input name="edit_time" id="edit_time" placeholder="开始日期" autocomplete="off" class="layui-input" type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                    </div>
                    <div class="layui-form-mid">-</div>
                    <div class="layui-input-inline" >
                        <input name="editend_time" id="editend_time" placeholder="结束日期" autocomplete="off" class="layui-input" type="text" placeholder="yyyy-MM-dd HH:mm:ss">
                    </div>
                    <button class="layui-btn layui-btn-sm" style="margin-top: 5px;margin-left: 10px" id="sreachBtn"><i class="layui-icon">&#xe615;</i>搜索</button>
                    <button class="layui-btn layui-btn-sm" style="margin-top: 5px" data-type="reset" ><i class="layui-icon">&#x2746;</i>重置</button>
                </div>
            </div>
        </form>
        <!-- 表格显示-->
        <table class="layui-hide" id="test" lay-filter="picuresList"></table>
    </div>
</div>
<%@ include file="/common/footer.jsp"%>
