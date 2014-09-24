<html>
<head>
    <title>用户管理</title>
</head>

<body>
<#if message??>
<div class="alert alert-success alert-dismissible" role="alert">
    <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
    <strong>Info!</strong> ${message}
</div>
</#if>

<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>登录名</th>
        <th>用户名</th>
        <th>注册时间
        <th>管理</th>
    </tr>
    </thead>
    <tbody>
	<#list users as user>
    <tr>
        <td><a href="${ctx}/admin/user/update/${user.id}">${user.loginName}</a></td>
        <td>${user.name}</td>
        <td>
		${user.registerDate}
        </td>
        <td><a href="${ctx}/admin/user/delete/${user.id}">删除</a></td>
    </tr>
	</#list>
    </tbody>
</table>
<#include "../page.ftl"/>
<script>
    Page.registerToPage(function () {
		alert("hehe")
		<#--window.location.href="${ctx}/admin/user";-->
    }, "test");
</script>
</body>
</html>
