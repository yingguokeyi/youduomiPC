<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>
<%@ include file="/picture/picture_menu.jsp"%>
<%@ page import="common.PropertiesConf" %>
<link rel="stylesheet" type="text/css" href="${ctx}/common/css/goodsCateSelect.css"/>

<script type="text/javascript" src="${ctx}/js/Utils.js?t=1515376178738"></script>

<%
    String imgUrlPrefix = PropertiesConf.IMG_URL_PREFIX;
    System.out.println(imgUrlPrefix);
    String taskid = request.getParameter("id");
    String createTime = request.getParameter("createTime");
    String status = request.getParameter("status");
    String category_name = request.getParameter("category_name");
    String bonus = request.getParameter("bonus");
    String task_number = request.getParameter("task_number");
    String task_end_time = request.getParameter("task_end_time");
    String task_time = request.getParameter("task_time");
    String check_task_time = request.getParameter("check_task_time");
%>
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
    var imgUrlPrefix = "<%=imgUrlPrefix%>";
    var taskId = <%=taskid%>;

    var isSuccess_Upload = 1;//是否有图片上传失败
    var count = 1;
    //图片参数
    var showImgIds = "";
    var showImgCount = 0;
    var detailImgIds = "";
    var detailImgCount = 0;
    var detailImgCount2 = 0;
    var goodsSourceMap = new Map();
    var brandMap = new Map();
    layui.use(['upload', 'element', 'form'], function () {
        var $ = layui.jquery
            , upload = layui.upload
            , element = layui.element;
        var form = layui.form;
        function onLoadData() {
            if (taskId) {
                $('#topCateNameLabel').html("");
                $('#subCateNameLabel').html("");
                $('#minCateNameLabel').html("");
                $('#goodsTypeNameLabel').html("");
            }
            if (taskId) {
                //$("#newOrEditSpan").html("修改");
                $.ajax({
                    type: "get",
                    async: false, // 同步请求
                    cache: true,// 不使用ajax缓存
                    contentType: "application/json",
                    url: "${ctx}/task",
                    data: "method=getTaskInfo&id=" + taskId,
                    dataType: "json",
                    success: function (data) {
                        if (data.success) {
                            var show_img_ids = "";
                            var detail_img_ids = "";
                            var imgs = data.img;
                            var imgList='';
                            for(var i=0;i<imgs.length;i++){
                                imgList += '<li style="float: left;margin-left: 10px;width: 180px;height: 180px;position: relative;">';
                                imgList += '<img style="width:100%;height:100%;" src='+imgUrlPrefix+imgs[i]+' />';
                                imgList += '<p style="width:20px;position: absolute;top: 0;z-index: 1000;right: 0;" onclick="detailImgClick(' + detailImgCount + "," + imgs[i] + ')" id="detailImgP' + detailImgCount + 'id' + imgs[i] + '">';
                                imgList += '<img src="${ctx}/image/delete.png" />';
                                imgList += '</p></li>';
                            }
                            $('#source ul').html(imgList);


                            var imgs2 = data.img2;
                            var imgList2='';
                            for(var i=0;i<imgs2.length;i++){
                                imgList2 += '<li style="float: left;margin-left: 10px;width: 180px;height: 180px;position: relative;">';
                                imgList2 += '<img style="width:100%;height:100%;" src='+imgUrlPrefix+imgs2[i]+' />';
                                imgList2 += '<p style="width:20px;position: absolute;top: 0;z-index: 1000;right: 0;" onclick="detailImgClick2(' + detailImgCount2 + "," + imgs2[i] + ')" id="detailImgP2' + detailImgCount2 + 'id' + imgs2[i] + '">';
                                imgList2 += '<img src="${ctx}/image/delete.png" />';
                                imgList2 += '</p></li>';
                            }
                            $('#source2 ul').html(imgList2);

                        } else {
                            layer.msg("异常");
                        }
                    },
                    error: function () {
                        layer.alert("错误main");
                    }
                })
            }

        };
        onLoadData();
        function onLoadImgs(ids, type) {
            if (ids) {
                var arr = ids.split(',');
                //var that = this;
                for (var i = 0; i < arr.length; i++) {
                    $.ajax({
                        type: "get",
                        async: false, // 同步请求
                        cache: true,// 不使用ajax缓存
                        contentType: "application/json",
                        url: "${ctx}/upload",
                        data: "method=getIMGInfo&id=" + arr[i],
                        dataType: "json",
                        success: function (data) {
                            if (data.success) {
                                if (data.rs[0]) {
                                    if (type === "showImg") {
                                        showImgCount++;
                                        $('#showUploadDiv').append('<div id="divShowImg' + showImgCount + '"><img src="' + data.rs[0].image_path + '" alt="' + data.rs[0].image_name +
                                            '" class="layui-upload-img" id="showImg' + showImgCount +
                                            '" name="showImg' + showImgCount + '"><p style="width:20px" onclick="showImgClick(' + showImgCount + "," + arr[i] + ')" id="showImgP' + showImgCount + 'id' + arr[i] + '"><img src="${ctx}/image/delete.png" /></p></div>');
                                    } else if (type === "detailImg") {
                                        detailImgCount++;
                                        $('#detailUploadDiv').append('<div id="divDetailImg' + detailImgCount + '"><img src="' + data.rs[0].image_path + '" alt="' + data.rs[0].image_name +
                                            '" class="layui-upload-img" id="detailImg' + detailImgCount +
                                            '" name="detailImg' + detailImgCount + '"><p style="width:20px" onclick="detailImgClick(' + detailImgCount + "," + arr[i] + ')" id="detailImgP' + detailImgCount + 'id' + arr[i] + '"><img src="${ctx}/image/delete.png" /></p></div>');
                                    }
                                }
                            } else {
                                layer.msg("异常");
                            }
                        },
                        error: function () {
                            layer.alert("错误img");
                        }
                    })
                }
                if (type === "showImg") {
                    $('#showImgIds').val(ids);
                    showImgIds = ids + ",";
                } else if (type === "detailImg") {
                    $('#detailImgIds').val(ids);
                    detailImgIds = ids + ",";
                }
            }
        };
        var arry = new Array();
        var arry1 = new Array();
        //普通图片上传 show
        //普通图片上传 detail
        //点击按钮 保存商品
        $('#saveSPU').on('click', function () {
            if (spu_id) {
                var btn = document.getElementById('saveSPU');//首先需要获取的是哪一个按钮的id
                btn.disabled = 'disabled';//只要点击就将按钮的可点击的状态更改为不可以点击的状态
                setTimeout(submitData('saveSPU', btn), 60000);//6秒内不可以重复点击，一秒等于1000毫秒
                // submitData('saveSPU');
            } else {
                var btn = document.getElementById('addSPU');//首先需要获取的是哪一个按钮的id
                btn.disabled = 'disabled';//只要点击就将按钮的可点击的状态更改为不可以点击的状态
                setTimeout(submitData('addSPU', btn), 60000);//6秒内不可以重复点击，一秒等于1000毫秒
                // submitData('addSPU');
            }
            return false;
        });


        //保存然后去添加规格
        $('#saveAndToSKU').on('click', function () {
            if (spu_id) {
                var btn = document.getElementById('saveAndToSKU');//首先需要获取的是哪一个按钮的id
                btn.disabled = 'disabled';//只要点击就将按钮的可点击的状态更改为不可以点击的状态
                setTimeout(submitData('saveAndToSKU', btn), 60000);//6秒内不可以重复点击，一秒等于1000毫秒
            } else {
                var btn = document.getElementById('saveAndToSKU');//首先需要获取的是哪一个按钮的id
                btn.disabled = 'disabled';//只要点击就将按钮的可点击的状态更改为不可以点击的状态
                setTimeout(submitData('addAndToSKU', btn), 60000);//6秒内不可以重复点击，一秒等于1000毫秒
            }
            return false;
        });
        // var count=1;
        $("#add_goods_url").on('click', function () {
            count += 1;
            $("#goods_url_div").append('<div class="layui-form-item" id="add_goods_url_div' + count + '"><label class="layui-form-label">商品链接: </label><div class="layui-input-block"><input style="width: 500px;display: inline-block;" onblur="add_goods_url_hidden(' + count + ')" id="goods_url' + count + '" name="goods_url' + count + '" lay-verify="goods_url" autocomplete="off" placeholder=""\n' +
                'class="layui-input" type="text">' +
                '<label style="width: 100px; color: red" class="layui-icon"   id="del_goods_url" onclick="del_goods_url(' + count + ')">&#xe640;</label></div>')
            // alert($("[name='goods_url']").val())

            //alert($("#goods_url_hidden").val());
            // alert(111)
        });

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            , url: '${ctx}/upload?method=uploadGoodsImg&uploadType=loadRecommonImg'
            , size: 1024 //限制文件大小，单位 KB
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            , done: function (res) {
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg('上传失败');
                }
                //上传成功
                var imgId = res.result.ids[0];
                // if(idsTemp.length > 0){
                console.log(" showImgIds " + showImgIds + " imgId  " + imgId);
                showImgIds = imgId + ",";
                // }else{
                //     showImgIds = imgId+",";
                // }

                if (showImgIds != "") {
                    $('#showImgIds').val(showImgIds.substring(0, showImgIds.length - 1));
                }
            }
            , error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        })
    });

    function del_goods_url(count) {
        $("#add_goods_url_div" + count).remove();
    }

    function add_goods_url_hidden(count) {
        if (count > 1) {
            var value = $("#goods_url" + count).val();
            var hidden_data = $("#goods_url_hidden").val();
            hidden_data += ',' + value;
            $("#goods_url_hidden").val(hidden_data);
        } else {
            $("#goods_url_hidden").val($("#goods_url").val());
        }
        // alert($("#goods_url_hidden").val())

    };


    // function deleteShowImg(showImgId){
    //     // var sp = "#showImgP"+showImgCount;
    //     // alert($('+ss+'));
    //     alert(showImgId);
    //     alert($('+showImgId+').html());
    // }


    //提交
    function submitData(urltype, btn) {

        var first_attribute = $("#first_attribute").val();
        var second_attribute = $("#second_attribute").val();
        var spu_name = $("#spu_name").val();


        //校验
        if (validate(btn)) {

            $.ajax({
                type: "get",
                url: "${ctx}/goods?method=addSPU",
                //data: "method=addSPU&jsonString="+JSON.stringify($('form').serializeObject()),
                data: {jsonString: JSON.stringify($('form').serializeObject())},
                contentType: "application/json",  //缺失会出现URL编码，无法转成json对象
                cache: false,
                async: false,
                dataType: "json",
                success: function (data) {
                    var id;
                    if (data.success) {
                        layer.msg('成功保存商品!', {time: 2000}, function () {


                            if (urltype === 'addSPU') {
                                id = data.result.ids[0];
                                window.location.href = "${ctx}/goods/goodsList.jsp?spu_name=" + spu_name + "&first_attribute="
                                    + first_attribute + "&second_attribute=" + second_attribute + "&spu_id=" + id;
                            } else if (urltype === 'saveSPU') {
                                window.location.href = "${ctx}/goods/goodsList.jsp?spu_name=" + spu_name + "&first_attribute="
                                    + first_attribute + "&second_attribute=" + second_attribute + "&spu_id=" + spu_id;
                            } else if (urltype === 'addAndToSKU') {
                                id = data.result.ids[0];
                                window.location.href = "${ctx}/goods/goodsAdd_C.jsp?spu_name=" + spu_name + "&first_attribute="
                                    + first_attribute + "&second_attribute=" + second_attribute + "&spu_id=" + id;
                            } else if (urltype === 'saveAndToSKU') {
                                window.location.href = "${ctx}/goods/goodsAdd_C.jsp?spu_name=" + spu_name + "&first_attribute="
                                    + first_attribute + "&second_attribute=" + second_attribute + "&spu_id=" + spu_id;
                            }


                        });
                    } else {
                        layer.msg("异常");
                    }
                },
                error: function (error) {
                    if (error.responseText != "") {
                        layer.msg(error.responseText);
                        btn.disabled = '';
                        return false;
                    } else {
                        btn.disabled = '';
                        layer.closeAll();
                        layer.msg('添加失败');
                        return false;
                    }
                }
            });
        }
        //return false;
    }


    //字段验证
    function validate(btn) {
        var spu_name = $("#spu_name").val();
        var first_attribute = $("#first_attribute").val();
        var second_attribute = $("#second_attribute").val();
        var sort = $("#sort").val();

        if (!isSuccess_Upload) {
            layer.msg('有图片上传失败，请联系开发人员！');
            btn.disabled = '';
            return false;
        }


        if (spu_name.length < 2) {
            layer.msg('商品名称至少得2个字符！');
            $("#spu_name").focus();
            btn.disabled = '';
            return false;
        } else if (spu_name.length > 32) {
            layer.msg('商品名称不得大于32个字符！');
            $("#spu_name").focus();
            btn.disabled = '';
            return false;
        }


        if ($("#source_code").val() == "") {
            layer.msg('请选择商品来源');
            btn.disabled = '';
            return false;
        }

        // if($("#brand_id").val()==""){
        //     layer.msg('请选择商品品牌');
        //     return false;
        // }

        if (Utils.GetLength($("#detail").val()) > 2000) {
            layer.msg('商品属性输入过长！已大于2000个字符(一个汉字折算2个字符)');
            $("#detail").focus();
            btn.disabled = '';
            return false;
        }


        if (!(/^\d+$/.test(sort)) && sort != "") {
            layer.msg('序号请输入正整数！');
            $("#sort").focus();
            btn.disabled = '';
            return false;
        }
        return true;
    }

    function showImgClick(index, imgId) {
        //删除图片的时候有，删除图片还没有保存的情况下，中途打断导致spu图片地址帐脏数据
        var divShowImg = $('#divShowImg' + index);
        layer.confirm('确认删除?', function (indexConfirm) {
            layer.close(indexConfirm);
            var showImgIds = $('#showImgIds').val() + ",";
            var idTemp = imgId + ",";
            var idsStr = showImgIds.replace(idTemp, "");
            $('#showImgIds').val(idsStr.substr(0, idsStr.length - 1));
            divShowImg.remove();
        });
    }

    function detailImgClick(index, imgId) {
        //删除图片的时候有，删除图片还没有保存的情况下，中途打断导致spu图片地址帐脏数据
        var divDetailImg = $('#divDetailImg' + index);
        layer.confirm('确认删除?', function (indexConfirm) {
            layer.close(indexConfirm);
            layer.msg('删除成功');
            var detailImgIds = $('#detailImgIds').val() + ",";
            var idTemp = imgId + ",";
            var idsStr = detailImgIds.replace(idTemp, "");
            $('#detailImgIds').val(idsStr.substr(0, idsStr.length - 1));
            divDetailImg.remove();
        });
    }

    function checkSPUNameISNOExist(spu_name) {
        $.ajax({
            type: "get",
            async: false, // 同步请求
            cache: false,// 不使用ajax缓存
            contentType: "application/json",
            url: "${ctx}/goods",
            data: "method=checkSPUNameISNOExist&spu_name=" + spu_name,
            dataType: "json",
            success: function (data) {

                if (data.rs[0].spu_num != 0) {
                    $("#spuName_error").text("已存在");
                }
            },
            error: function () {
                layer.alert("错误spu");
            }
        });
        return false;
    }

</script>


<!-- 内容主体区域 -->
<div class="layui-body" style="padding: 15px">

    <div class="layui-elem-quote">
            <span>
                <a>1.任务管理</a>&nbsp;&nbsp;
                <a>2.任务审核</a>&nbsp;&nbsp;
                <a>3.任务详情</a>
            </span>

        <%--<span class="layui-breadcrumb" style="visibility: visible;">
            您选择的商品分类：<label id="topCateNameLabel"><%=topCateName%></label>
            <label id="subCateNameLabel"><%=subCateName%></label>
            <label id="minCateNameLabel"><%=minCateName%></label>
        </span>--%>
        <button class="layui-btn  layui-btn-sm" style="margin-left: 50%" onclick="history.go(-1)">返回</button>
    </div>

    <div style="padding: 15px;display:none;" id="menus">

        <div style="height: 400px;background-color: #f2f2f2;margin: 0 auto;">
            <div style="width: 1200px;height: 350px;position: relative;left: 100px;top: 25px;background-color: #f2f2f2">
                <div id="topCateDiv" class="ax_default">
                    <select id="topCateSel" class="cateSel" size="2" tabindex="0" onchange="topCateChange(this.value)">
                    </select>
                </div>
                <div id="subCateDiv" class="ax_default">
                    <select id="subCateSel" class="cateSel" size="2" tabindex="0" hidden="hidden"
                            onchange="subCateChange(this.value)">
                    </select>
                </div>

                <div id="minCateDiv" class="ax_default">
                    <select id="minCateSel" class="cateSel" name="classifyValue" hidden="hidden"
                            onchange="minCateChange(this.value)" autocomplete="off" size="2" tabindex="0">
                    </select>
                </div>

                <div id="goodsTypeDiv" class="ax_default">
                    <select id="goodsTypeSel" class="cateSel" name="goodsTypeValue" hidden="hidden"
                            onchange="goodsTypeChange(this.value)" autocomplete="off" size="2" tabindex="0">
                    </select>
                </div>

            </div>
        </div>

        <div align="center" style="margin-top: 5px;">
            <button class="layui-btn" id="goNextBtn">
                确认商品类型
            </button>
        </div>
        <!--onclick="window.location.href='goodsAdd_B.jsp'"-->

    </div>

    <form enctype="multipart/form-data">
        <%--<form>--%>

        <%--<h3>商品属性 : </h3>--%>
       <%-- <hr class="layui-bg-blue">--%>
        <div class="layui-form-item" style="height: 40px;">
            <label class="layui-form-label" style="display: inline-block;height: 100%;line-height: 23px;">任务编号 : </label><span id="taskNo" style="display: inline-block;height: 100%;line-height: 40px;"></span>
        </div>
        <input type="hidden" value="1" id="standard">
        <script type="application/javascript">
            var taskId = <%=taskid%>;
            $("#taskNo").html(taskId);
            function changeGoodsTypeNameId() {
                var standard = $("#standard").val();
                if (standard == 1) {
                    $("#standard").val(2);
                    $('#menus').show();
                } else {
                    $("#standard").val(1);
                    $('#menus').hide();
                }

                $.ajax({
                    type: "get",
                    url: "${ctx}/goodsCategory?method=getTopCateInfo",
                    dataType: "json",//表示后台返回的数据是json对象
                    async: true,
                    success: function (data) {
                        if (data.success == 1) {
                            var array = data.result.rs;
                            for (var obj in array) {
                                if (array[obj].dict_data_value.substr(3, 9) < 1) {

                                    $("#topCateSel").append("<option value='" + array[obj].dict_data_value + "'>" + array[obj].dict_data_name + "</option>")

                                }
                            }
                        }
                    },
                    error: function (error) {
                        console.log("error=" + error);
                    }
                });
            }

            function topCateChange(code) {
                $("select#subCateSel").empty();
                $("select#minCateSel").empty();
                $("select#goodsTypeSel").empty();
                topCateCode = code;
                topCateName = $("#topCateSel").find("option:selected").text();

                $.ajax({
                    type: "get",
                    url: "${ctx}/goodsCategory?method=getSubCateInfoByPCode&pCateCode=" + code,
                    dataType: "json",//表示后台返回的数据是json对象
                    async: true,
                    success: function (data) {
                        if (data.success == 1) {
                            var array = data.result.rs;
                            for (var obj in array) {
                                $("#subCateSel").append("<option value='" + array[obj].dict_data_value + "'>" + array[obj].dict_data_name + "</option>")
                            }
                            $("select#subCateSel").show();
                        }
                    },
                    error: function (error) {
                        console.log("error=" + error);
                    }
                });
            }

            function subCateChange(code) {
                $("select#minCateSel").empty();
                $("select#goodsTypeSel").empty();
                subCateCode = code;
                subCateName = $("#subCateSel").find("option:selected").text();

                $.ajax({
                    type: "get",
                    url: "${ctx}/goodsCategory?method=getMinCateInfoByPCode&pCateCode=" + code,
                    dataType: "json",//表示后台返回的数据是json对象
                    async: true,
                    success: function (data) {
                        if (data.success == 1) {
                            var array = data.result.rs;
                            for (var obj in array) {
                                $("#minCateSel").append("<option value='" + array[obj].dict_data_value + "'>" + array[obj].dict_data_name + "</option>")
                            }
                            $("select#minCateSel").show();
                        }
                    },
                    error: function (error) {
                        console.log("error=" + error);
                    }
                });
            }


            function minCateChange(code) {
                $("select#goodsTypeSel").empty();
                minCateCode = code;
                minCateName = $("#minCateSel").find("option:selected").text();


                $.ajax({
                    type: "get",
                    url: "${ctx}/goodsCategory?method=getGoodsTypeInfoByPCode&pCateCode=" + code,
                    dataType: "json",//表示后台返回的数据是json对象
                    async: true,
                    success: function (data) {
                        if (data.success == 1) {
                            var array = data.result.rs;
                            for (var obj in array) {
                                $("#goodsTypeSel").append("<option value='" + array[obj].dict_data_value + "'>" + array[obj].dict_data_name + "</option>")
                            }
                            $("select#goodsTypeSel").show();
                        }
                    },
                    error: function (error) {
                        console.log("error=" + error);
                    }
                });
            }

            // 商品类型 商品分类改变
            function goodsTypeChange(code) {
                goodsTypeCode = code;
                goodsTypeName = $("#goodsTypeSel").find("option:selected").text();  //获取Select选择的Text
                console.log("    minCateSel    " + $("#minCateSel").val())
                $("#minCateCode").val($("#minCateSel").val());
                // alert(goodsTypeCode+goodsTypeName);

            }

            //点击按钮 添加分类
            $('#goNextBtn').on('click', function () {

                var value = $("#goodsTypeSel option:selected").attr("value");
                if (value == undefined) {
                    layer.alert("请选择商品类型");
                    return false;
                }
                $('#goodsTypeNameLabel').html($("#goodsTypeSel").find("option:selected").text());
                $("#goodsTypeCode").val(goodsTypeCode);
            });
        </script>
        <div class="layui-form-item" style="height: 40px;">
            <label class="layui-form-label" style="display: inline-block;height: 100%;line-height: 23px;"><span style="color: red">*</span>创建时间: </label>
            <span id="createTime" style="display: inline-block;height: 100%;line-height: 40px;"></span>
        </div>
        <div class="layui-form-item" style="height: 40px;">
            <label class="layui-form-label" style="display: inline-block;height: 100%;line-height: 23px;"><span style="color: red">&nbsp;</span>任务状态: </label>
            <span id="status" style="display: inline-block;height: 100%;line-height: 40px;"></span>
        </div>

            <h3 style="margin-top: 18px;">基本信息 : </h3>
            <hr class="layui-bg-blue">
            <div class="layui-form-item" style="height: 40px;margin-bottom: 19px">
                <label class="layui-form-label" style="display: inline-block;height: 100%;line-height: 23px;"><span style="color: red">*</span>任务名称：</label>
                <div class="layui-input-block" style="display: inline-block;height: 100%;line-height: 40px;margin-left: 0;">
                    <span id="category_name"></span>&nbsp;&nbsp;&nbsp;
                    <label id="spuName_errors" style="width: 100px; color: #FF0000;"></label>
                </div>

            </div>
            <label class="layui-form-label"><span style="color: red">*</span>任务步骤：</label>
            <div class="layui-upload" style="margin-left: 110px;">
               <%-- <button type="button" class="layui-btn" id="showUpload">
                    上传轮播/主图
                </button>--%>
                <%--<ul style="width: 100%;overflow: hidden;margin-top: 10px;">
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>

                </ul>--%>
                <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;" id="source">
                    预览图：
                    <%--<input type="hidden" id="detailImgIds" name="detailImgIds" value="" lay-verify="required"--%>
                    <%--autocomplete="off">--%>
                    <%--<div class="layui-list" id="detailUploadDiv"></div>--%>
                    <ul style="overflow: hidden">

                    </ul>
                </blockquote>
            </div>
            <label class="layui-form-label" style="width: 90px;padding: 5px 10px;"><span style="color: red">*</span>审核示例图：</label>
            <div class="layui-upload" style="margin-left: 110px;">
                <%--<button type="button" class="layui-btn" id="detailUpload">
                    上传详细图片
                </button>--%>
                <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;" id="source2">
                    预览图：
                    <%--<input type="hidden" id="detailImgIds" name="detailImgIds" value="" lay-verify="required"--%>
                    <%--autocomplete="off">--%>
                    <%--<div class="layui-list" id="detailUploadDiv"></div>--%>
                    <ul style="overflow: hidden">

                    </ul>
                </blockquote>
                <%--<ul style="width: 100%;overflow: hidden;margin-top: 10px;">
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>
                    <li style="width: 15%;height: 150px;float: left;margin-right: 10px;margin-bottom: 10px;">
                        <img src="" style="width: 100%;height: 100%;border:1px solid #000;" />
                    </li>

                </ul>--%>
            </div>
            <div class="layui-form-item" style="height: 40px;">
                <label class="layui-form-label" style="display: inline-block;height: 100%;line-height: 23px;"><span style="color: red">*</span>提交文字：</label>
                <span style="display: inline-block;height: 100%;line-height: 40px;">11111</span>
            </div>

        <h3 style="margin-top: 18px;">任务设置 : </h3>
        <hr class="layui-bg-blue">
        <div class="layui-form-item" style="height: 40px;">
            <label class="layui-form-label" style="display: inline-block;height: 100%;line-height: 23px;"><span style="color: red">*</span>投放单价：</label>
            <div class="layui-input-block"  style="display: inline-block;height: 100%;line-height: 40px;margin-left: 0;">
                <span id="bonus"></span>&nbsp;&nbsp;&nbsp;
                <label id="spuName_error" style="width: 100px; color: #FF0000;"></label>
            </div>

        </div>
        <%--<div class="layui-form-item">
            <label class="layui-form-label">商品编码：</label>
            <div class="layui-input-block">
                <input style="width: 500px;" id="spu_code" name="spu_code" lay-verify="spu_code" autocomplete="off" placeholder="请填写商品编码"
                       class="layui-input" type="text">
            </div>
        </div>--%>
        <div class="layui-form-item" style="height: 40px;">
            <label class="layui-form-label" style="display: inline-block;height: 100%;line-height: 23px;"><span style="color: red">*</span>投放数量: </label>
            <div class="layui-input-inline layui-form"  style="display: inline-block;height: 100%;line-height: 40px;margin-left: 0;">
                <span id="task_number"></span>
            </div>
        </div>
        <div class="layui-form-item" style="height: 40px;">
            <label class="layui-form-label" style="display: inline-block;height: 100%;line-height: 23px;">结束时间: </label>
            <div class="layui-input-inline layui-form"  style="display: inline-block;height: 100%;line-height: 40px;margin-left: 0;">
                <span id="task_end_time"></span>
            </div>
        </div>
        <div class="layui-form-item" id="goods_url_div" style="height: 40px;">
            <label class="layui-form-label" style="display: inline-block;height: 100%;line-height: 23px;">任务限时: </label>
            <div class="layui-input-block"  style="display: inline-block;height: 100%;line-height: 40px;margin-left: 0;">
                <span id="task_time"></span>
                <%--<label style="width: 100px; color: red" class="layui-icon" id="add_goods_url">&#xe654;</label>--%>
            </div>
        </div>
            <div class="layui-form-item" id="" style="height: 40px;">
                <label class="layui-form-label" style="display: inline-block;height: 100%;line-height: 23px;"><span color="red">*</span>审核周期</label>
                <span id="check_task_time"  style="display: inline-block;height: 100%;line-height: 40px;margin-left: 0;"></span>
            </div>
<script type="application/javascript">
    (function ($) {
        $.fn.limitTextarea = function (opts) {
            var defaults = {
                maxNumber: 60, //允许输入的最大字数
                position: 'top', //提示文字的位置，top：文本框上方，bottom：文本框下方
                onOk: function () { }, //输入后，字数未超出时调用的函数
                onOver: function () {
                    $('#distribution').disabled;
                } //输入后，字数超出时调用的函数
            }
            var option = $.extend(defaults, opts);
            this.each(function () {
                var _this = $(this);
                var info = '<div id="info' + option.maxNumber + '">还可以输入<b>' + (option.maxNumber - getByteLen(_this.val())) + '</b>字符</div>';
                var fn = function () {
                    var $info = $('#info' + option.maxNumber + '');
                    var extraNumber = option.maxNumber - getByteLen(_this.val());

                    if (extraNumber >= 0) {
                        $info.html('还可以输入<b>' + extraNumber + '</b>个字符');
                        option.onOk();
                    } else {
                        $info.html('还可以输入<b>0</b>个字符');
                        option.onOver();
                    }
                };
                switch (option.position) {
                    case 'top':
                        _this.before(info);
                        break;
                    case 'bottom':
                    default:
                        _this.after(info);
                }
                //绑定输入事件监听器
                if (window.addEventListener) { //先执行W3C
                    _this.get(0).addEventListener("input", fn, false);
                } else {
                    _this.get(0).attachEvent("onpropertychange", fn);
                }
                if (window.VBArray && window.addEventListener) { //IE9
                    _this.get(0).addEventListener("onkeydown", function () {
                        var key = window.event.keyCode;
                        (key == 8 || key == 46) && fn(); //处理回退与删除
                    });
                    _this.get(0).addEventListener("oncut", fn); //处理粘贴
                }
            });
        }


    })(jQuery)

    this.getByteLen= function(val) {
        var len = 0;
        for (var i = 0; i < val.length; i++) {
            if (val[i].match(/[^\x00-\xff]/ig) != null) //全角
                len += 2;
            else
                len += 1;
        }
        return len;
    }

    function getByteVal(val, max) {
        var returnValue = '';
        var byteValLen = 0;
        for (var i = 0; i < val.length; i++) {
            if (val[i].match(/[^\x00-\xff]/ig) != null)
                byteValLen += 2;
            else
                byteValLen += 1;
            if (byteValLen > max)
                break;
            returnValue += val[i];
        }
        return returnValue;
    }

    $('#distribution').limitTextarea({
        maxNumber: 60, //最大字数
        position: 'bottom', //提示文字的位置，top：文本框上方，bottom：文本框下方
        onOk: function () {
            $('#distribution').css('background-color', 'white');
        }, //输入后，字数未超出时调用的函数
        onOver: function () {
            var value = $('#distribution').val();

            $('#distribution').val(getByteVal(value, 60));
            $('#distribution').disabled;
        }
    });
    var createTime = '<%=createTime%>';
    var status = '<%=status%>';
    var category_name = '<%=category_name%>';
    var bonus = '<%=bonus%>';
    var task_number = '<%=task_number%>';
    var task_end_time = '<%=task_end_time%>';
    var task_time = '<%=task_time%>';
    var check_task_time = '<%=check_task_time%>';
    $("#createTime").html(createTime);
    $("#status").html(status);
    $("#category_name").html(category_name);
    $("#bonus").html(bonus);
    $("#task_end_time").html(task_end_time);
    $("#task_time").html(task_time);
    $("#check_task_time").html(check_task_time);
    $("#task_number").html(task_number);
</script>

    </form>

<%@ include file="/common/footer.jsp" %>