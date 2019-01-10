<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree"  lay-filter="test">
            <li class="layui-nav-item layui-nav-itemed">
                <dl class="layui-nav-child">
                    <dd><a href="publishTask.jsp">任务发布</a></dd>
                    <dd><a href="picture_category.jsp">任务管理</a></dd>
                    <dd><a href="taskQuery.jsp">任务查询</a></dd>
                    <dd><a href="task_list.jsp">任务审核</a></dd>
                </dl>
            </li>
        </ul>
    </div>
</div>
<%@ include file="/common/footer.jsp"%>
