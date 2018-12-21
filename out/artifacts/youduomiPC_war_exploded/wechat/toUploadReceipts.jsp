<%--
  Created by IntelliJ IDEA.
  User: sdmin
  Date: 2018/11/10
  Time: 11:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="email=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="msapplication-tap-highlight" content="no">
    <link rel="stylesheet" href="../assets/css/common.css" />
    <link rel="stylesheet" href="../assets/css/header_common.css" />
    <link rel="stylesheet" href="../css/receipt/toUploadReceipts.css" />
    <link rel="stylesheet" href="../assets/layer_mobile/need/layer.css" />
    <link rel="stylesheet" href="../assets/layui/css/layui.css" />
    <script type="text/javascript" src="../assets/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="../assets/layer_mobile/layer.js"></script>
    <script type="text/javascript" src="../assets/js/font-size.js"></script>
    <script type="text/javascript" src="../assets/js/global_variable.js"></script>
    <title>小票上传</title>
</head>
<body style="background:#fff;">
<div class="main">
    <!-- 头部图片 -->
    <div class="head_img">
        <img class="chief_img" src="../image/mine/map.png" />
    </div>
    <!-- 输入小票号的框 -->
    <div class="small_mouth">
        <input type="text" id="le" placeholder="请输入“小票号”" value="" / >
    </div>
    <!-- 上传小票图片 -->
    <div class="pictures">
        <label class="upload_pictures" id="localImag">
            <input class="fileInput" id="doc" type="file"  accept="image/*" name="file" style="display:none;" onchange="javascript:setImagePreview();"/>
            <p class="add" id="add">点击这里选择小票图片</p>
            <img id="preview" src="" width="1.8rem" height="1.8rem" style="display: none;"/>
        </label>
    </div>
    <!-- 上传，重置 -->
    <div class="push_button">
        <button class="up" type="button">上传</button>
        <button class="below" type="button">重置</button>
    </div>
    <!-- 历史记录 -->
    <div class="history">
        <a href="history.html">
            <p class="w_history">历史记录</p>
            <p class="L_history"></p>
        </a>
    </div>
    <!-- 补贴规则 -->
    <div class="rule">
        <div class="t_rule">补贴规则：</div>
        <ul>
            <li>1.小票出票24小时内上传有效</li>
            <li>2.上传的小票图片要清晰可见【图片展示内容清晰】</li>
            <li>3.小票上传后的48小时内享随机补贴和积分累计</li>
            <li>4.每人每天最多可上传3张小票</li>
            <li>5.上传成功后，将在1-3小时内进行审核</li>
        </ul>

    </div>
</div>
<!-- 上传图片成功弹框 -->
<div class="warm" style="display: none;">
    <div class="warm_title">
        <h4>提示</h4>
        <p>登录成功</p>
    </div>
    <div class="warm_choose">
        <a class="warm_login">确定</a>
    </div>
</div>

</body>
<script type="text/javascript" src="../assets/layui/layui.js"></script>
<script type="text/javascript" src="../js/receipt/toUploadReceipts.js"></script>
</html>
