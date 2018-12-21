<%--
  Created by IntelliJ IDEA.
  User: sdmin
  Date: 2018/11/8
  Time: 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ include file="/common/common.jsp" %>--%>
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
    <link rel="stylesheet" href="../css/register/register.css" />
    <link rel="stylesheet" href="../assets/layer_mobile/need/layer.css" />
    <script type="text/javascript" src="../assets/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="../assets/layer_mobile/layer.js"></script>
    <script type="text/javascript" src="../assets/js/font-size.js"></script>
    <script type="text/javascript" src="../assets/js/global_variable.js"></script>
    <title>会员注册</title>
</head>
<body style="background:#fff;">
<div class="main">
    <div class="main_bak_login">
        <p class="title_p">
        </p>
        <div class="main_infor">
            <ul class="main_infor_name">
                <li class="name_li">
                    <img src="../image/mine/name.png" class="name_li_phone" />
                    <span>真实姓名:</span>
                </li>
                <li class="name_li name_input">
                    <input type="text" placeholder="真实姓名" id="uname" onkeyup="this.value = this.value.substring(0,4)" />
                </li>
            </ul>
            <ul class="main_infor_name">
                <li class="name_li">
                    <img src="../image/mine/phone.png" class="name_li_phone" />
                    <span>手机号:</span>
                </li>
                <li class="name_li name_input">
                    <input type="text" placeholder="请输入手机号" id="unumber"/>
                </li>
            </ul>
            <ul class="main_infor_name">
                <li class="name_li">
                    <img src="../image/mine/yzm.png" class="name_li_yanzhengma"/>
                    <span>短信验证码:</span>
                </li>
                <li class="name_li name_input">
                    <input type="text" placeholder="请输入验证码" class="yzm" id="phone_codema"/>
                    <input type="button" value="获取验证码" id="button"  class="btn_yanzhengma"/>
                </li>

            </ul>
            <ul class="main_infor_name">
                <li class="name_li">
                    <img src="../image/mine/referrer.png" class="name_li_phone" />
                    <span>推荐人:</span>
                </li>
                <li class="name_li name_input">
                    <input type="text" placeholder="请输入推荐人" id="invite_code"/>
                </li>

            </ul>
        </div>
        <!--输入手机号验证码结束-->
        <div class="main_btn">
            <a href="javascript:;" class="main_btn_a">
                <button class="mian_btn_login">下一步</button>
            </a>
        </div>
        <div class="register_cond">
            <p>
                <img src="../image/mine/registernoc.png" id="test1" />
                注册即同意<span style="color:#fd4848;">《用户注册协议》</span>
            </p>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="../js/register/register.js"></script>
</html>
