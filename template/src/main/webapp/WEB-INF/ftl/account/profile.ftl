
<html>
<head>
	<title>资料修改</title>
</head>

<body>
	<form id="inputForm" action="${ctx}/profile" method="post" class="" role="form">
		<input type="hidden" name="id" value="${user.id}"/>
		<fieldset>
			<legend><small>资料修改</small></legend>
			<div class="col-xs-4 ">
			<div class="form-group">
				<label for="name" class="control-label">用户名:</label>
				<input type="text" id="name" name="name" value="${user.name}" class="form-control input-large required"/>
			</div>
			<div class="form-group">
				<label for="plainPassword" class="control-label">密码:</label>
				<input type="password" id="plainPassword" name="plainPassword" class="form-control input-large" placeholder="...Leave it blank if no change"/>
			</div>
			<div class="form-group">
				<label for="confirmPassword" class="control-label">确认密码:</label>
				<input type="password" id="confirmPassword" name="confirmPassword" class="form-control input-large" equalTo="#plainPassword" />
			</div>
			<div class="form-actions">
				<input id="submit_btn" class="btn btn-primary" type="submit" value="提交"/>&nbsp;	
				<input id="cancel_btn" class="btn" type="button" value="返回" onclick="history.back()"/>
			</div>
			</div>
		</fieldset>
	</form>
	
	<script>
		$(document).ready(function() {
			//聚焦第一个输入框
			$("#name").focus();
			//为inputForm注册validate函数
			$("#inputForm").validate();
		});
	</script>
</body>
</html>
