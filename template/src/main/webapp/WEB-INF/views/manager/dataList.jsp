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
			<form class="form-search" action="${ctx}/manager/dataList">
				<label>工号：</label> <input type="text" name="userId" class="input-medium" value="${userId}">
				<button type="submit" class="btn" id="search_btn">搜索(模糊匹配)</button>
		    </form>
	    </div>
	</div>
	
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>工号</th><th>积分</th><th>管理</th></tr></thead>
		<tbody>
		<c:forEach items="${datas.content}" var="data">
			<tr>
                <td><a class="" href="${ctx}/manager/dataDetail?userId=${data.userId}">${data.userId}</a></td>
                <td>${data.point}</td>
				<td><a class="btn" href="javascript:toChange('${data.id}','${data.userId}','${data.point}');">修改积分</a>
                    <a class="btn" href="${ctx}/manager/dataDetail?userId=${data.userId}">查看明细</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
    <div class="row">
        <form id="changeModal" class="modal hide fade form-horizontal"
              method="post" action="${ctx}/manager/update" style="display: none">
            <div class="modal-header">
                <h3>积分修改</h3>
            </div>
            <div class="modal-body">
                <fieldset>
                    <div class="control-group">
                        <label class="control-label">工号:</label>
                        <label class="control-label" id="m_user_id"></label>
                    </div>
                    <div class="control-group">
                        <label class="control-label">积分:</label>
                        <div class="controls">
                            <input type="text" name="point" id="m_point">
                        </div>
                    </div>

                    <input type="hidden" id="m_id" name="userId" />
                </fieldset>
            </div>
            <div class="modal-footer">
                <input type="submit" class="btn btn-primary" value="提交修改">
                <input type="button" class="btn" value="取消" data-dismiss="modal">
            </div>
        </form>
    </div>
	<tags:pagination page="${datas}" paginationSize="5"/>
    <script type="text/javascript">
        function toChange(id,userId,point) {
            $("#m_id").val(userId);
            $("#m_user_id").text(userId);
            $("#m_point").val(point);
            $("#changeModal").modal();
        }
    </script>
</body>
</html>
