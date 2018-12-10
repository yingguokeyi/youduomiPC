<%--
  Created by IntelliJ IDEA.
  User: sdmin
  Date: 2018/11/8
  Time: 15:49
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
    <link rel="stylesheet" href="../css/register/PurchaseMembership.css" />
    <link rel="stylesheet" href="../assets/layer_mobile/need/layer.css" />
    <script type="text/javascript" src="../assets/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="../assets/layer_mobile/layer.js"></script>
    <script type="text/javascript" src="../assets/js/font-size.js"></script>
    <script type="text/javascript" src="../assets/js/global_variable.js"></script>
    <title>购买会员</title>
</head>
<body style="background-color: #ffffff;">
<div class="main">
    <!-- 图片 -->
    <div class="head_img">
        <img class="large" src="../image/mine/map.png" />
    </div>
    <!-- 价格 -->
    <div class="Price">
        <div class="left_Price">
            <div class="left_word">原价</div>
            <div class="left_number">￥99元</div>
        </div>
        <div class="right_Price">
            <div class="right_word">特惠价</div>
            <div class="right_number">￥48元</div>
        </div>
    </div>
    <!-- 分割线 -->
    <div class="sky"></div>
    <!-- 人工通道，自动通道 -->
    <div class="Passage">
        <a href="../register/credit_channel.html"><div class="Artificial_channel">人工通道</div></a>
        <div class="workday">上班时间： 10：00 - 22:00</div>
        <a href="javascript: ;"><div class="automatic_channel">自动通道</div></a>
        <a href="#">
            <div class="skip">跳过</div>
            <div class="xian"></div>
        </a>
    </div>
</div>
<!-- 退出弹框 -->
<div class="warm" style="display: none;">
    <div class="warm_title">
        <h4>提示</h4>
        <p>您已取消支付</p>
    </div>
    <div class="warm_choose">
        <a class="warm_login">确定</a>
    </div>
</div>
</body>
<script type="text/javascript" src="../js/member/member.js"></script>
</html>
