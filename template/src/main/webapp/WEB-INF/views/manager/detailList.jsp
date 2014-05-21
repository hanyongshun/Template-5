<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>积分管理</title>
</head>

<body>
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>${message}</div>
	</c:if>
	<div class="row">
		<div class="span6 offset7">
			<form class="form-search" action="${ctx}/manager/dataDetail">
				<label>工号：</label> <input type="text" name="userId" class="input-medium" value="${userId}">
				<button type="submit" class="btn" id="search_btn">搜索(全匹配)</button>
		    </form>
	    </div>
	</div>
	
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>工号</th><th>增加积分</th><th>ip</th><th>地区</th><th>设备类型</th><th>设备号</th><th>appkey</th><th>时间</th></tr></thead>
		<tbody>
		<c:forEach items="${datas.content}" var="data">
			<tr>
                <td><a class="" href="${ctx}/manager/dataDetail?userId=${data.userId}">${data.userId}</a></td>
                <td>${data.point}</td>
                <td>${data.ip}</td>
                <td>${data.ipRegion}</td>
                <td>${data.deviceType}</td>
                <td>${data.deviceId}</td>
                <td>${data.appkey}</td>
                <td>${data.insertTime}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<tags:pagination page="${datas}" paginationSize="5"/>
</body>
</html>
