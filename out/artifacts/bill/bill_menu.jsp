<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree"  lay-filter="test">
            <li class="layui-nav-item layui-nav-itemed">
                <a class="" href="javascript:;">小票管理</a>
                <dl class="layui-nav-child">
                    <%--<dd><a href="bill_list.jsp">小票管理</a></dd>--%>
                    <dd><a href="bill_list.jsp">小票列表</a></dd>
                    <dd><a href="recommend_list.jsp">账户明细查询</a></dd>
                </dl>
            </li>
        </ul>
    </div>
</div>
<%@ include file="/common/footer.jsp"%>
