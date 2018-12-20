<%--
  Created by IntelliJ IDEA.
  User: sdmin
  Date: 2018/11/10
  Time: 11:44
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
    <link rel="stylesheet" href="../css/receipt/receipt.css" />
    <link rel="stylesheet" href="../assets/layer_mobile/need/layer.css" />
    <script type="text/javascript" src="../assets/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="../assets/layer_mobile/layer.js"></script>
    <script type="text/javascript" src="../assets/js/font-size.js"></script>
    <script type="text/javascript" src="../assets/js/global_variable.js"></script>
    <title>小票查询</title>
</head>
<body style="background:#fff;">
<div class="main">
    <div class="main_bot">
        <div class="wx_sum">
            <p>
                <input type="text" placeholder="请输入“小票号”进行查询" value="" />
            </p>
            <button type="button">查询</button>
        </div>
    </div>
    <!-- 没有查询记录时显示的内容 -->
    <!-- <div>
       <p class="wit_condition">还没有你的历史记录</p>
       <p class="wit_service">赶快点开查询，查看您的购买信息</p>
   </div> -->
    <!-- 查询记录时已有的历史记录 -->
    <div class="discountgoods_title">
        <div class="kong"></div>
        <ul>
            <li class="synthesize">
                <img class="synthesize_img" src="../image/receipt/flashback.png"/>
            </li>
            <li class="sales">查询历史</li>
            <li class="price">
                <a href="moreReceipts.html">
                    更多
                    <span class="p_ret"></span>
                </a>

            </li>
        </ul>
    </div>
    <!-- 查询的列表 -->
    <div class="withdrawal_record">
        <ul>
            <li>
                <div class="record_infor">
                    <p class="infor_title">
                        <span>北京永辉超市有限公司</span>
                    </p>
                    <p class="record_plan">小票号：<em>15365478216485</em> <span class="record_t">消费: <i>0.50</i></span>  </p>
                </div>
                <div class="record_img" onclick="window.location=''">
                    <img src="../image/mine/enter.png" />
                </div>
            </li>
            <li>
                <div class="record_infor">
                    <p class="infor_title">
                        <span>北京永辉超市有限公司</span>
                    </p>
                    <p class="record_plan">小票号：<em>15365478216485</em> <span class="record_t">消费: <i>0.50</i></span>  </p>
                </div>
                <div class="record_img" onclick="window.location=''">
                    <img src="../image/mine/enter.png" />
                </div>
            </li>
            <li>
                <div class="record_infor">
                    <p class="infor_title">
                        <span>北京永辉超市有限公司</span>
                    </p>
                    <p class="record_plan">小票号：<em>15365478216485</em> <span class="record_t">消费: <i>0.50</i></span>  </p>
                </div>
                <div class="record_img" onclick="window.location=''">
                    <img src="../image/mine/enter.png" />
                </div>
            </li>
        </ul>
    </div>

</div>
</body>
<script type="text/javascript" src="../js/receipt/receipt.js"></script>
</html>
