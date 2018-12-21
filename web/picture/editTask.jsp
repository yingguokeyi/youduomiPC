<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp"%>
<%@ include file="/picture/picture_menu.jsp"%>
<%@ page import="common.PropertiesConf" %>
<link rel="stylesheet" type="text/css" href="${ctx}/common/css/goodsCateSelect.css"/>

<script type="text/javascript" src="${ctx}/js/Utils.js?t=1515376178738"></script>

<%
    String imgUrlPrefix = PropertiesConf.IMG_URL_PREFIX;
    System.out.println(imgUrlPrefix);
    String topCateName = request.getParameter("topCateName");
    String topCateCode = request.getParameter("topCateCode");
    String subCateName = request.getParameter("subCateName");
    String subCateCode = request.getParameter("subCateCode");
    String minCateName = request.getParameter("minCateName");
    String minCateCode = request.getParameter("minCateCode");
    String goodsTypeCode = request.getParameter("goodsTypeCode");
    String spu_id = request.getParameter("spu_id");
    String goodsTypeName = request.getParameter("goodsTypeName");

    String categoryName = request.getParameter("categoryName");
    String linkAddress = request.getParameter("linkAddress");
    String remark = request.getParameter("remark");
    String bonus = request.getParameter("bonus");
    String status = request.getParameter("status");
    String createTime = request.getParameter("createTime");
    String beginTime = request.getParameter("beginTime");
    String id = request.getParameter("id");
%>

<script>
    var createTime = "<%=createTime%>";
    var id="<%=id%>";
    var ct = "20"+createTime.substr(0,2)+"-"+createTime.substr(2,2)+"-"+createTime.substr(4,2)+" "+createTime.substr(6,2)+":"+createTime.substr(8,2)+":"+createTime.substr(10,2);
    var beginTime = "<%=beginTime%>";
    var bg="";
    if(beginTime !=undefined && beginTime!="") {
        bg = "20" + beginTime.substr(0, 2) + "-" + beginTime.substr(2, 2) + "-" + beginTime.substr(4, 2) + " " + beginTime.substr(6, 2) + ":" + beginTime.substr(8, 2) + ":" + beginTime.substr(10, 2);
    }
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
    var spu_id = <%=spu_id%>;
    var goodsTypeName = "<%=goodsTypeName%>";
    var minCateCode = <%=minCateCode%>;
    var goodsTypeCode = <%=goodsTypeCode%>;
    var isSuccess_Upload = 1;//是否有图片上传失败
    var count = 1;
    //图片参数
    var showImgIds = "";
    var showImgCount = 0;
    var detailImgIds = "";
    var detailImgCount = 0;
    var goodsSourceMap = new Map();
    var brandMap = new Map();
    layui.use(['upload', 'element', 'form'], function () {
        var $ = layui.jquery
            , upload = layui.upload
            , element = layui.element;
        var form = layui.form;

        function onLoadData() {
            if (spu_id) {
                $('#topCateNameLabel').html("");
                $('#subCateNameLabel').html("");
                $('#minCateNameLabel').html("");
                $('#goodsTypeNameLabel').html("");
            }
            if (id) {
                $("#newOrEditSpan").html("修改");
                $.ajax({
                    type: "get",
                    async: false, // 同步请求
                    cache: true,// 不使用ajax缓存
                    contentType: "application/json",
                    url: "${ctx}/task",
                    data: "method=getTaskInfo&id=" + id,
                    dataType: "json",
                    success: function (data) {
                        if (data.success) {
                            var show_img_ids = "";
                            var detail_img_ids = "";
                            <%--if (data.img[0] != "") {--%>
                                <%--show_img_ids = data.rs[0].show_img_ids.split(',');--%>
                                <%--$("#showImgIds").val(data.rs[0].show_img_ids);--%>
                            <%--}--%>
                            <%--if (data.rs[0].detail_img_ids != "") {--%>
                                <%--detail_img_ids = data.rs[0].detail_img_ids.split(',');--%>
                                <%--$("#detailImgIds").val(data.rs[0].detail_img_ids);--%>
                            <%--}--%>
                            <%--if (data.rs[0].http_path != "") {--%>
                                <%--var http_path = data.rs[0].http_path.split(',');--%>
                                <%--for (var obj in http_path, show_img_ids) {--%>
                                    <%--$('#showUploadDiv').append('<div id="divShowImg' + obj + '" style="height: 220px;width: 200px;margin-left: 30px"><img src="' + http_path[obj] + '" alt="' + data.rs[0].image_name +--%>
                                        <%--'" class="layui-upload-img" style="height: 200px;width: 200px;margin-left: 30px" id="showImg' + obj +--%>
                                        <%--'" name="showImg' + obj + '"><p style="width:20px;height: 20px" onclick="showImgClick(' + obj + "," + show_img_ids[obj] + ')" id="showImgP' + obj + 'id' + show_img_ids[obj] + '"><img src="${ctx}/image/delete.png" style="height: 10px;width: 10px;margin-left: 30px"/></p></div>');--%>
                                <%--}--%>
                            <%--} else {--%>
                                <%--var image_path = data.rs[0].image_path.split(',');--%>
                                <%--for (var obj in image_path, show_img_ids) {--%>

                                    <%--$('#showUploadDiv').append('<div id="divShowImg' + obj + '" style="height: 220px;width: 200px;margin-left: 30px"><img src="' + image_path[obj] + '" alt="' + image_path[obj] +--%>
                                        <%--'" class="layui-upload-img" style="height: 200px;width: 200px;margin-left: 30px" id="showImg' + obj +--%>
                                        <%--'" name="showImg' + obj + '"><p style="width:20px;height: 20px" onclick="showImgClick(' + obj + "," + show_img_ids[obj] + ')" id="showImgP' + obj + 'id' + show_img_ids[obj] + '"><img src="${ctx}/image/delete.png" style="height: 10px;width: 10px;margin-left: 30px"/></p></div>');--%>
                                <%--}--%>
                            <%--}--%>
                            <%--var detail_image_path = data.rs[0].detail_image_path.split(',');--%>
                            <%--for (var obj in detail_image_path, detail_img_ids) {--%>

                                <%--$('#detailUploadDiv').append('<div id="divShowImg' + obj + '" style="height: 200px;width: 300px;margin-left: 30px"><img src="' + detail_image_path[obj] + '" alt="' + detail_image_path[obj] +--%>
                                    <%--'" class="layui-upload-img" style="height: 200px;width: 200px;margin-left: 30px" id="showImg' + obj +--%>
                                    <%--'" name="showImg' + obj + '"><p style="width:20px;height: 20px" onclick="showImgClick(' + obj + "," + detail_img_ids[obj] + ')" id="showImgP' + obj + 'id' + detail_img_ids[obj] + '"><img src="${ctx}/image/delete.png" style="height: 10px;width: 10px;margin-left: 30px"/></p></div>');--%>
                            <%--}--%>
                            //加载图片
                            // onLoadImgs(data.rs[0].show_img_ids,"showImg");
                            // onLoadImgs(data.rs[0].detail_img_ids,"detailImg");
                            // form.render('select');
                            //table.reload("listTable")
                            var imgs = data.img;
                            var imgList='';
                            for(var i=0;i<imgs.length;i++){
                                imgList += '<li style="float: left;margin-left: 10px;width: 180px;height: 180px;"><img style="width:100%;height:100%;" src='+imgUrlPrefix+imgs[i]+' /></li>';
                            }
                            $('#source ul').html(imgList);

                            var imgs2 = data.img2;
                            var imgList2='';
                            for(var i=0;i<imgs2.length;i++){
                                imgList2 += '<li style="float: left;margin-left: 10px;width: 180px;height: 180px;"><img style="width:100%;height:100%;" src='+imgUrlPrefix+imgs2[i]+' /></li>';
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
        var uploadShowInst = upload.render({
            elem: '#showUpload',
            url: '${ctx}/upload?method=uploadGoodsImg&uploadType=loadShowImg&minCateCode=<%=minCateCode%>&goodsTypeCode=<%=goodsTypeCode%>'
            ,
            before: function (obj) {
                obj.preview(function (index, file, result) {
                    console.log("    obj.preview   ");
                    //$('#showUploadDiv').empty();
                    showImgCount++;
                    for (var i = 0; i < arry.length; i++) {
                        if (arry[i].indexOf(file.name) > -1) {
                            layer.msg('不能重复添加同一张图片！');
                            return;
                        }
                    }
                    arry.push(file.name);
                    if (showImgCount > 15) {
                        layer.msg('添加的图片不能大于15张！');
                        return;
                    }
                    var ss = "#showImg" + showImgCount;
                    $('#showUploadDiv').append('<div id="divShowImg' + showImgCount + '"><img src="' + result + '" alt="' + file.name +
                        '" class="layui-upload-img" id="showImg' + showImgCount +
                        '" name="showImg' + showImgCount + '">');
                });
            }
            ,
            done: function (res) {
                //上传完毕
                if (res.success) {
                    //上传成功
                    //layer.msg('上传成功');
                    var imgId = res.result.ids[0];
                    var idsTemp = $('#showImgIds').val();
                    // if(idsTemp.length > 0){
                    showImgIds = showImgIds + imgId + ",";
                    // }else{
                    //     showImgIds = imgId+",";
                    // }

                    if (showImgIds != "") {
                        $('#showImgIds').val(showImgIds.substring(0, showImgIds.length - 1));
                    }
                    $('#divShowImg' + showImgCount).append('<p style="width:20px" onclick="showImgClick(' + showImgCount + "," + imgId + ')" id="showImgP' + showImgCount + 'id' + imgId + '"><img src="${ctx}/image/delete.png" /></p>');
                    //var p = "showImgP"+showImgCount;
                } else {
                    //如果上传失败
                    layer.msg("异常");
                }
            }
            ,
            error: function () {
                //演示失败状态，并实现重传
                // var p = "showImgP"+showImgCount;
                // var showImgPText = $("'#"+p+"'");
                // showImgPText.html('<span style="color: #FF5722;">上传失败</span><a class="layui-btn layui-btn-mini showImg-reload">重试</a>');
                // showImgPText.find('.showImg-reload').on('click', function(){
                //     uploadShowInst.upload();
                // });

                layer.msg('浏览器兼容问题 请清除缓存 重新上传!   ');
                isSuccess_Upload = 0;
            }
        });
        //普通图片上传 detail
        var uploadDetailInst = upload.render({
            elem: '#detailUpload'
            ,
            url: '${ctx}/upload?method=uploadGoodsImg&uploadType=loadDetailImg&minCateCode=<%=minCateCode%>&goodsTypeCode=<%=goodsTypeCode%>'
            ,
            before: function (obj) {
                obj.preview(function (index, file, result) {
                    //$('#showUploadDiv').empty();
                    detailImgCount++;
                    for (var i = 0; i < arry1.length; i++) {
                        if (arry1[i].indexOf(file.name) > -1) {
                            layer.msg('不能重复添加同一张图片！');
                            return;
                        }
                    }
                    arry1.push(file.name);
                    if (detailImgCount > 15) {
                        layer.msg('添加的图片不能大于15张！');
                        return;
                    }
                    var ss = "#detailImg" + detailImgCount;
                    $('#detailUploadDiv').append('<div id="divDetailImg' + detailImgCount + '"><img src="' + result + '" alt="' + file.name +
                        '" class="layui-upload-img" id="detailImg' + detailImgCount +
                        '" name="detailImg' + detailImgCount + '">');


                    // '"><a class="layui-btn layui-btn-sm showImg-delete" onclick="deleteShowImg("'+ss+'")>删除</a></p></div>');


                    // $('#showUploadDiv').find('.showImg-delete').on('click', function(){
                    //     alert("功能待开发!"+"showImg"+showImgCount);
                    //     var ss = "#showImg"+showImgCount;
                    //     var sp = "#showImgP"+showImgCount;
                    //     alert($('+ss+'));
                    //     alert($('+sp+').html());
                    // });

                });
            }
            ,
            done: function (res) {
                //上传完毕
                if (res.success) {
                    //上传成功
                    //layer.msg('上传成功');
                    var imgId = res.result.ids[0];
                    var idsTemp = $('#detailImgIds').val();
                    // if(idsTemp.length > 0){
                    detailImgIds = detailImgIds + imgId + ",";
                    // }else{
                    //     detailImgIds = imgId+",";
                    // }
                    if (detailImgIds != "") {
                        $('#detailImgIds').val(detailImgIds.substring(0, detailImgIds.length - 1));
                    }
                    $('#divDetailImg' + detailImgCount).append('<p style="width:20px" onclick="detailImgClick(' + detailImgCount + "," + imgId + ')" id="detailImgP' + detailImgCount + 'id' + imgId + '"><img src="${ctx}/image/delete.png" /></p>');

                    //var p = "detailImgP"+detailImgCount;

                } else {
                    //如果上传失败
                    layer.msg("异常");
                }
            }
            ,
            error: function () {
                //演示失败状态，并实现重传
                // var p = "detailImgP"+detailImgCount;
                // var detailImgPText = $("'#"+p+"'");
                // detailImgPText.html('<span style="color: #FF5722;">上传失败</span><a class="layui-btn layui-btn-mini detailImg-reload">重试</a>');
                // detailImgPText.find('.detailImg-reload').on('click', function(){
                //     uploadDetailInst.upload();
                // });

                layer.msg('上传失败!');
                isSuccess_Upload = 0;
            }
        });


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
                url: "${ctx}/picture?method=saveTask",
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
        var spu_name = $("#task_name").val();
        var bonus_name = $("#bonus_name").val();
        var presell_begintime = $("#presell_begintime").val();
        var presell_endtime = $("#presell_endtime").val();
        var sort = $("#sort").val();

        if (!isSuccess_Upload) {
            layer.msg('有图片上传失败，请联系开发人员！');
            btn.disabled = '';
            return false;
        }


        if (spu_name.length < 2) {
            layer.msg('任务名称至少两个字符！');
            $("#spu_name").focus();
            btn.disabled = '';
            return false;
        } else if (spu_name.length > 32) {
            layer.msg('任务名称不得大于32个字符！');
            $("#spu_name").focus();
            btn.disabled = '';
            return false;
        }
        if (!isNumber(bonus_name)) {
            layer.msg('请输入正确的奖金！');
            $("#sort").focus();
            btn.disabled = '';
            return false;
        }
        if (presell_begintime == "") {
            layer.msg('请输入预售的开始时间！');
            if (obj == "addNew") {
                $('#saveAndAddNewBtn').removeAttr("disabled");
            } else {
                $('#saveBtn').removeAttr("disabled");
            }
            $("#presell_begintime").focus();
            return false;
        }
        if (!$('#hasPreSaleTimeEnd').is(':checked') && presell_endtime == "") {
            layer.msg('请输入预售的结束时间！');
            if (obj == "addNew") {
                $('#saveAndAddNewBtn').removeAttr("disabled");
            } else {
                $('#saveBtn').removeAttr("disabled");
            }
            $("#presell_endtime").focus();
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

    function isNumber(val) {
        var regPos = /^\d+(\.\d+)?$/; //非负浮点数
        var regNeg = /^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$/; //负浮点数
        if(regPos.test(val) || regNeg.test(val)) {
            return true;
        } else {
            return false;
        }
    }
</script>


<!-- 内容主体区域 -->
<div class="layui-body" style="padding: 15px">

    <div class="layui-elem-quote">
            <span>
                <a>查看任务</a>&nbsp;&nbsp;
            </span>
        <button class="layui-btn  layui-btn-sm" style="margin-left: 50%" onclick="history.go(-1)">返回到任务列表</button>
    </div>
    <form enctype="multipart/form-data">
        <input type="hidden" value="1" id="standard">
        <div class="layui-form-item">
            <label class="layui-form-label"><label style="color: red">*</label>任务名称: </label>
            <div class="layui-input-block">
                <input style="width: 500px;" id="task_name" name="task_name" lay-verify="attribute"
                       autocomplete="off" placeholder=""
                       class="layui-input" type="text" value="<%=categoryName%>" readonly="readonly">
            </div>
        </div>
        <label class="layui-form-label"><label style="color: red">*</label>添加图片：</label>
            <div class="layui-upload" style="margin-left: 110px;">
                <button type="button" class="layui-btn" id="detailUpload">
                    上传详细图片
                </button>
                <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;" id="source">
                    预览图：
                    <%--<input type="hidden" id="detailImgIds" name="detailImgIds" value="" lay-verify="required"--%>
                           <%--autocomplete="off">--%>
                    <%--<div class="layui-list" id="detailUploadDiv"></div>--%>
                    <ul style="overflow: hidden">

                    </ul>
                </blockquote>
            </div>

        <div class="layui-form-item">
            <label class="layui-form-label"><label style="color: red">*</label>奖金：</label>
            <div class="layui-input-block" style="width: 70%;">
                <input style="width: 500px;display: inline-block;" id="bonus_name" name="bonus_name" lay-verify="spu_name"
                       autocomplete="off"
                       class="layui-input" type="text" value="<%=bonus%>" readonly="readonly">&nbsp;&nbsp;&nbsp;
                <label id="spuName_error" style="width: 100px; color: #FF0000;"></label>
            </div>

        </div>

        <div class="layui-form-item" id="goods_url_div">
            <label class="layui-form-label">链接: </label>
            <div class="layui-input-block">
                <input style="width: 500px;display: inline-block;" id="task_url" name="task_url"
                       lay-verify="goods_url" autocomplete="off" placeholder=""
                       class="layui-input" type="text" onblur="add_goods_url_hidden(0)" value="<%=linkAddress%>" readonly="readonly">
                <input type="hidden" id="goods_url_hidden" name="goods_url_hidden" lay-verify="required" type="text">
                <%--<label style="width: 100px; color: red" class="layui-icon" id="add_goods_url">&#xe654;</label>--%>
            </div>
        </div>

        <label class="layui-form-label"><label style="color: red">*</label>添加核对图片：</label>
        <div class="layui-upload" style="margin-left: 110px;">
            <button type="button" class="layui-btn" id="detailUpload2">
                上传核对图片
            </button>
            <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;" id="source2">
                预览图：
                <%--<input type="hidden" id="detailImgIds" name="detailImgIds" value="" lay-verify="required"--%>
                <%--autocomplete="off">--%>
                <%--<div class="layui-list" id="detailUploadDiv"></div>--%>
                <ul style="overflow: hidden">

                </ul>
            </blockquote>
        </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 150px"><label style="color: red">*</label>开始时间:</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" id="presell_begintime" name="presell_begintime"
                               placeholder="yyyy-MM-dd HH:mm:ss" type="text" value="" readonly="readonly" >
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline" id="presell_endtimeDiv">
                    <label class="layui-form-label" style="width: 150px"><label style="color: red">*</label>结束时间:</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" id="presell_endtime" name="presell_endtime"
                               placeholder="yyyy-MM-dd HH:mm:ss" type="text" readonly="readonly">
                    </div>
                </div>
            </div>

            <div class="layui-form-item" pane="">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 150px">&nbsp;&nbsp;</label>
                    <input id="hasPreSaleTimeEnd" name="hasPreSaleTimeEnd" lay-skin="primary" title="预售结束时间不限"
                           type="checkbox" lay-filter="checkboxFilter">
                </div>
            </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label"><label style="color: red">*</label>任务说明：</label>
            <div class="layui-input-block">
                <textarea id="detail" name="detail" style="width: 100%;height: 200px" placeholder="输入视频描述"
                          class="layui-textarea" readonly="readonly"><%=remark%></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">

                <%--<button id="saveSPU" class="layui-btn layui-btn-normal">保存</button>--%>
                <%--<button id="saveAndToSKU" class="layui-btn layui-btn-normal">保存/添加规格</button>--%>
            </div>
        </div>
    </form>

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
    </script>
    <script>
        layui.use(['form', 'element', 'laydate'], function () {
            var form = layui.form;
            var laydate = layui.laydate
                //,upload = layui.upload
                , element = layui.element;


//返佣规则数值计算公式
            function getDistriMoney(market_price, original_price, num) {
                if (Number(market_price) > Number(original_price)) {
                    return ((Number(market_price) - Number(original_price)) * Number(num) * 0.01).toFixed(2) + "元";
                }
            }

            //执行一个laydate实例
            laydate.render({
                elem: '#presell_begintime', type: 'datetime'
            });
            laydate.render({
                elem: '#presell_endtime', type: 'datetime'
            });
            var first_attribute = $("#first_attribute").val();
            var second_attribute = $("#second_attribute").val();
            var spu_name = $("#spu_name").val();
            var member_Distri_Map = new Map();
            var outsider_Distri_Map = new Map();


            //点击按钮 保存商品
            form.on('submit(saveBtn)', function (data) {
                console.log("     saveBtn    ");
                $('#sku_status').val("0");
                $('#saveBtn').attr('disabled', "true");

                var btn = document.getElementById('saveBtn');//首先需要获取的是哪一个按钮的id
                btn.disabled = 'disabled';//只要点击就将按钮的可点击的状态更改为不可以点击的状态
                setTimeout(submitData('save'), 60000);//6秒内不可以重复点击，一秒等于1000毫秒

                return false;
            });

            form.on('submit(saveAndAddNewBtn)', function (data) {

                layer.confirm('确定要添加新的规格商品吗 ?', {
                    btn: ['添加', '取消']
                }, function (index) {
                    layer.close(index);
                    $('#saveAndAddNewBtn').removeAttr("disabled");

                    submitData('addNew');
                    // layer.msg('添加新的规格!',{time:2000}, function(){});
                }, function (index) {
                    layer.close(index);
                    // window.location.href = "${ctx}/goods/goodsSKUList.jsp?goodsSPUId="+spu_id+"&goodsSPUName="+spu_name;
                });

                return false;
            });


            //保存而且发布
            // $('#saveAndPublishBtn').on('click', function(){
            //     $('#sku_status').val("1");
            //     $('#buyconfine_Num').val("0");
            //     submitData('publish');
            //     return false;
            // });


            /**
             *
             按钮需求说明：
             【保存/关闭】按钮：
             1.保存当前页面数据，SKU为停售状态，且它的上级SPU状态保持现有状态；

             【保存/添加新规格型】按钮：
             1.保存当前页面的数据，SKU为停售状态，且它的上级SPU状态保持现有状态；
             2.在现有的页面，重新给出新的空数据页，录入数值；

             【发布】按钮：
             1.保存当前页面数据，SKU为起售状态，且它的上级SPU为上架状态，直接发布到线上；
             */

            //提交
            function submitData(method) {
                //校验
                if (validate(method)) {
                    $.ajax({
                        type: "get",
                        url: "${ctx}/goods?method=addSKU",
                        //data: "method=addSKU&jsonString="+JSON.stringify($('form').serializeObject()),
                        data: {jsonString: JSON.stringify($('form').serializeObject())},
                        contentType: "application/json",  //缺失会出现URL编码，无法转成json对象
                        cache: false,
                        async: false,
                        dataType: "json",
                        success: function (data) {
                            if (data.success == 1) {
                                var id;
                                layer.msg('保存成功!', {time: 1000}, function () {
                                    var spu_name = $('#spu_name').val();
                                    if (method === 'save') {
                                        window.location.href = "${ctx}/goods/goodsSKUList.jsp?goodsSPUId=" + spu_id + "&goodsSPUName=" + spu_name;
                                    } else if (method === 'addNew') {
                                        while (data.success == 2) {
                                            // 说明此销售规格组合 已经存在
                                            layer.confirm('SKU 规格已重复 请修改销售属性值 ', {
                                                btn: ['返回查看', '取消']
                                            }, function (index) {
                                                layer.close(index);
                                                window.location.href = "${ctx}/goods/goodsSKUList.jsp?goodsSPUId=" + spu_id + "&goodsSPUName=" + spu_name;
                                            }, function (index) {
                                                layer.close(index);
                                            });
                                            return false;
                                        }
                                        // 可以继续执行
                                        layer.confirm('是否继续添加新的规格!!？', {
                                            btn: ['添加', '取消']
                                        }, function (index) {
                                            layer.close(index);
                                            $('#saveAndAddNewBtn').removeAttr("disabled");
                                            // layer.msg('添加新的规格!',{time:2000}, function(){});
                                            window.location.href = "${ctx}/goods/goodsAdd_C.jsp?spu_id=" + spu_id + "&&spu_name=" + spu_name;
                                        }, function (index) {
                                            layer.close(index);
                                            window.location.href = "${ctx}/goods/goodsSKUList.jsp?goodsSPUId=" + spu_id + "&goodsSPUName=" + spu_name;
                                        });

                                    } else if (method === 'publish') {

                                        alert(id);
                                        id = data.result.ids[0];

                                        //发布商品f
                                        $.ajax({
                                            type: "get",
                                            async: false, // 同步请求
                                            cache: false,
                                            url: "${ctx}/goods?method=publishGoods&spuId=" + spu_id + "&skuId=" + id,
                                            //data: ids,
                                            dataType: "json",
                                            success: function (data) {
                                                if (data.success) {
                                                    //layer.closeAll('loading');
                                                    layer.msg('发布成功!', {time: 2000}, function () {
                                                        //do something
                                                        window.location.href = "${ctx}/goods/goodsSKUList.jsp?goodsSPUId=" + spu_id + "&goodsSPUName=" + spu_name;
                                                    });
                                                } else {
                                                    layer.msg("异常");
                                                }
                                            },
                                            error: function () {
                                                layer.alert("错误");
                                            }
                                        })
                                    }
                                });
                            } else if (data.success == 2) {
                                layer.confirm('SKU 规格已重复 请修改销售属性值 ', {
                                    btn: ['返回查看', '取消']
                                }, function (index) {
                                    layer.close(index);
                                    window.location.href = "${ctx}/goods/goodsSKUList.jsp?goodsSPUId=" + spu_id + "&goodsSPUName=" + spu_name;
                                }, function (index) {
                                    layer.close(index);
                                    //   window.location.href = "${ctx}/goods/goodsSKUList.jsp?goodsSPUId="+spu_id+"&goodsSPUName="+spu_name;
                                });
                                // layer.msg(" 对不起 您已经添加过该销售规格组合的SKU商品！ ");
                            } else {
                                layer.msg("异常");
                            }
                        },
                        error: function () {
                            layer.alert("错误");
                        }
                    });
                }
            }

            /*function validate(obj) {
                var sku_name = $("#sku_name").val();

                var market_price = $("#market_price").val();
                var original_price = $("#original_price").val();
                var stock = $("#stock").val();

                var distribution_begintime = $("#distribution_begintime").val();
                var distribution_endtime = $("#distribution_endtime").val();

                var presell_begintime = $("#presell_begintime").val();
                var presell_endtime = $("#presell_endtime").val();

                if (sku_name.length < 2) {
                    layer.msg('规格名称至少得2个字符！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }

                    $("#sku_name").focus();
                    return false;
                }

                var isNum = /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/;
                if (market_price != "") {
                    if (!(isNum.test(market_price))) {
                        layer.msg('请输入正确的销售价格！');
                        if (obj == "addNew") {
                            $('#saveAndAddNewBtn').removeAttr("disabled");
                        } else {
                            $('#saveBtn').removeAttr("disabled");
                        }
                        $("#market_price").focus();
                        return false;
                    }
                } else {
                    layer.msg('请填写销售价格！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#market_price").focus();
                    return false;
                }
                if (original_price != "") {
                    if (!(isNum.test(original_price))) {
                        $("#original_price").focus();
                        layer.msg('请输入正确的原价/成本价！');
                        if (obj == "addNew") {
                            $('#saveAndAddNewBtn').removeAttr("disabled");
                        } else {
                            $('#saveBtn').removeAttr("disabled");
                        }
                        return false;
                    }
                } else {
                    layer.msg('请填写原价/成本价！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#original_price").focus();
                    return false;
                }
                if (stock != "") {
                    if (!(/^\d+$/.test(stock))) {
                        layer.msg('库存数量请输入正整数！');
                        if (obj == "addNew") {
                            $('#saveAndAddNewBtn').removeAttr("disabled");
                        } else {
                            $('#saveBtn').removeAttr("disabled");
                        }
                        $("#stock").focus();
                        return false;
                    }
                } else {
                    layer.msg('请填写库存数量！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#stock").focus();
                    return false;
                }
                // 奖励金存在 则需要验证 是否填写
                var f = $("#bflag").val();
                console.log("   是否是掌小龙来源  " + f);
                if (f == 1) {
                    console.log(" 是掌小龙商品 ");
                    var bVal = $("#bounty").val();
                    // 奖励金必须为数字 整数保留两位小数
                    if (!(isNum.test((bVal/1).toFixed(2)))) {
                        //
                        layer.msg(" 请填写正确的奖励金数值 ");
                        $('#saveBtn').removeAttr("disabled");
                        return false;
                    }
                } else {
                    console.log("  非长大赚商品  ");
                }

                var T_A = $("#T_A").val(), T_B = $("#T_B").val(), T_C = $("#T_C").val();
                var T_D = $("#T_D").val(), T_E = $("#T_E").val(), T_F = $("#T_F").val();

                //^(\d{1,2}|100)$    0-100
                if (!(/^(\d{1,2}|100)$/.test(T_A))) {
                    layer.msg('请正确输入自定义会员返佣规则的顶级的返佣比！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#T_A").focus();
                    return false;
                }
                if (!(/^(\d{1,2}|100)$/.test(T_B))) {
                    layer.msg('请正确输入自定义会员返佣规则的父级的返佣比！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#T_B").focus();
                    return false;
                }
                if (!(/^(\d{1,2}|100)$/.test(T_C))) {
                    layer.msg('请正确输入自定义会员返佣规则的子级的返佣比！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#T_C").focus();
                    return false;
                }
                if (!(/^(\d{1,2}|100)$/.test(T_D))) {
                    layer.msg('请正确输入自定义非会员返佣规则的顶级的返佣比！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#T_D").focus();
                    return false;
                }
                if (!(/^(\d{1,2}|100)$/.test(T_E))) {
                    layer.msg('请正确输入自定义非会员返佣规则的父级的返佣比！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#T_E").focus();
                    return false;
                }
                if (!(/^(\d{1,2}|100)$/.test(T_F))) {
                    layer.msg('请输入正确自定义非会员返佣规则的子级的返佣比！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#T_F").focus();
                    return false;
                }


                if ((Number(T_A) + Number(T_B) + Number(T_C) > 100)) {
                    layer.msg('自定义会员返佣规则返佣比总数大于100，请输入输入！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#T_A").focus();
                    return false;
                }

                if ((Number(T_D) + Number(T_E) + Number(T_F) > 100)) {
                    layer.msg('自定义非会员返佣规则返佣比总数大于100，请输入输入！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#T_D").focus();
                    return false;
                }
                // if(distribution_begintime==""){
                //     layer.msg('请输入自定义返佣规则的开始时间！');
                //     $("#distribution_begintime").focus();
                //     return false;
                // }
                // if(!$('#hasDistributionTimeEnd').is(':checked') && distribution_endtime=="" ) {
                //     layer.msg('请输入自定义返佣规则的结束时间！');
                //     $('#saveBtn').removeAttr("disabled");
                //     $("#distribution_endtime").focus();
                //     return false;
                // }

                if (presell_begintime == "") {
                    layer.msg('请输入预售的开始时间！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#presell_begintime").focus();
                    return false;
                }
                if (!$('#hasPreSaleTimeEndhasPreSaleTimeEnd').is(':checked') && presell_endtime == "") {
                    layer.msg('请输入预售的结束时间！');
                    if (obj == "addNew") {
                        $('#saveAndAddNewBtn').removeAttr("disabled");
                    } else {
                        $('#saveBtn').removeAttr("disabled");
                    }
                    $("#presell_endtime").focus();
                    return false;
                }

                var first_attribute = $("#first_attribute").val();
                var second_attribute = $("#second_attribute").val();

                if ($('#checkFirst').is(':checked')) {
                    if ($("#txtFirst").val().length == 0) {
                        layer.msg('请填写[' + first_attribute + ']的属性值');
                        if (obj == "addNew") {
                            $('#saveAndAddNewBtn').removeAttr("disabled");
                        } else {
                            $('#saveBtn').removeAttr("disabled");
                        }
                        $("#txtFirst").focus();
                        return false;
                    }
                } else {
                    if ($("#selectFirst").val() == "") {
                        layer.msg('请选择[' + first_attribute + ']的值');
                        if (obj == "addNew") {
                            $('#saveAndAddNewBtn').removeAttr("disabled");
                        } else {
                            $('#saveBtn').removeAttr("disabled");
                        }
                        $("#selectFirst").focus();
                        return false;
                    }
                }

                // if($('#checkSecond').is(':checked')) {
                //     if($("#txtSecond").val().length == 0){
                //         layer.msg('请填写['+second_attribute+']的属性值');
                //         if(obj=="addNew"){
                //             $('#saveAndAddNewBtn').removeAttr("disabled");
                //         }else{
                //             $('#saveBtn').removeAttr("disabled");
                //         }
                //         $("#txtSecond").focus();
                //         return false;
                //     }
                // }else{
                //     if($("#selectSecond").val()==""){
                //         layer.msg('请选择['+second_attribute+']的值');
                //         if(obj=="addNew"){
                //             $('#saveAndAddNewBtn').removeAttr("disabled");
                //         }else{
                //             $('#saveBtn').removeAttr("disabled");
                //         }
                //         $("#selectSecond").focus();
                //         return false;
                //     }
                // }
                return true;
            };
*/

            //监听"checkbox"操作
            form.on('checkbox(checkboxFilter)', function (obj) {
                var othis = $(this);
                id = this.value;

                var first = $("#first_attribute").val();
                var second = $("#second_attribute").val();

                if (this.name == 'checkFirst' && obj.elem.checked) {
                    $("#txtFirstDiv").show();
                    $("#selectFirstDiv").hide();
                    $("#checkFirst").val('NEED');
                    layer.tips("请填写[" + first + "]的属性值", $("#txtFirstDiv"));
                } else if (this.name == 'checkFirst' && !obj.elem.checked) {
                    $("#txtFirstDiv").hide();
                    $("#selectFirstDiv").show();
                    $("#checkFirst").val('NO');
                    layer.tips("请选择[" + first + "]的属性值", $("#selectFirstDiv"));
                } else if (this.name == 'checkSecond' && obj.elem.checked) {
                    $("#txtSecondDiv").show();
                    $("#selectSecondDiv").hide();
                    $("#checkSecond").val('NEED');
                    layer.tips("请填写[" + second + "]的属性值", $("#txtSecondDiv"));
                } else if (this.name == 'checkSecond' && !obj.elem.checked) {
                    $("#txtSecondDiv").hide();
                    $("#selectSecondDiv").show();
                    $("#checkSecond").val('NO');
                    layer.tips("请选择[" + second + "]的属性值", $("#selectSecondDiv"));
                }

                //处理时间
                else if (this.name == 'hasPreSaleTimeEnd' && obj.elem.checked) {
                    $("#presell_endtime").val('');
                    $("#presell_endtimeDiv").hide();
                    //obj.val('no');
                } else if (this.name == 'hasPreSaleTimeEnd' && !obj.elem.checked) {
                    $("#presell_endtimeDiv").show();
                    //obj.val('yes');
                } else if (this.name == 'hasDistributionTimeEnd' && obj.elem.checked) {
                    $("#distribution_endtime").val('');
                    $("#distribution_endtimeDiv").hide();
                    //obj.val('no');
                } else if (this.name == 'hasDistributionTimeEnd' && !obj.elem.checked) {
                    $("#distribution_endtimeDiv").show();
                    //obj.val('yes');
                } else if (this.name == 'hasActiveTimeEnd' && obj.elem.checked) {
                    $("#activeTimeEnd").val('');
                    $("#activeTimeEndDiv").hide();
                    //obj.val('no');
                } else if (this.name == 'hasActiveTimeEnd' && !obj.elem.checked) {
                    $("#activeTimeEndDiv").show();
                    //obj.val('yes');
                }

                form.render('checkbox');
                form.render('select');
            });

            form.on('checkbox(buyconfineFilter)', function (obj) {
                if (this.name == 'buyconfine' && obj.elem.checked == false) {
                    $("#buyconfine_Num_Div").hide();
                } else if (this.name == 'buyconfine' && obj.elem.checked == true) {
                    $("#buyconfine_Num_Div").show();
                }
            });

            form.on('select(selFilter)', function (data) {
                var id = data.value;
                console.log("   id   " + id)
                layer.msg('确定要起用该规格型号吗?', {
                    skin: 'layui-layer-molv' //样式类名  自定义样式
                    , closeBtn: 1    // 是否显示关闭按钮
                    , time: 1000000
                    , anim: 1 //动画类型
                    , btn: ['确定', '删除'] //按钮
                    , icon: 6    // icon
                    , yes: function () {
                        layer.closeAll();
                    }
                    , btn2: function () {
                        layer.closeAll();
                        // 确定删除
                        $.ajax({
                            type: "get",
                            url: "${ctx}/goods?method=delGoodsSpuAttribute&id=" + id,
                            // data:{'id':id,'style':'beginSell'} ,
                            cache: false,
                            async: false,
                            dataType: "json",
                            success: function (data) {
                                if (data.success) {
                                    layer.closeAll();
                                    // table.reload("goodsSKUInfoTab")
                                    layer.msg(' 商品SKU规格删除成功 ');
                                    window.location.href = "${ctx}/goods/goodsAdd_C.jsp?spu_id=" + spu_id + "&sku_id=" + sku_id + "&&spu_name=" + spu_name;
                                    return false;
                                }
                            },
                            error: function () {
                                layer.msg('  商品SKU规格删除失败  ');
                                return false;
                            }
                        })
                    }
                });

            });
        });

        window.onload=function () {
            $("#presell_begintime").val(ct);
            $("#presell_endtime").val(bg);
        }

    </script>

<%@ include file="/common/footer.jsp" %>