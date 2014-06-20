<!DOCTYPE html>
<html>
<head>
    <title>登录</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta http-equiv="Cache-Control" content="no-store"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>

    <link type="image/x-icon" href="${ctx!''}/static/images/favicon.ico" rel="shortcut icon">
    <link href="${ctx!''}/static/bootstrap/2.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx!''}/static/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx!''}/static/styles/default.css" type="text/css" rel="stylesheet"/>
    <script src="${ctx!''}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="${ctx!''}/static/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
    <script src="${ctx!''}/static/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>

</head>

<body>
<div class="container">
    <div id="content">
        <div id="header">
            <div id="title">
                <h1>Backoffice
                </h1>
            </div>
        </div>
        <form id="loginForm" action="${ctx!''}/login" method="post" class="form-horizontal">

		<#if error??>
            <div class="alert alert-error input-medium controls">
                <button class="close" data-dismiss="alert">×</button>
                登录失败，请重试.
            </div>
		</#if>
            <div class="control-group">
                <label for="username" class="control-label">名称:</label>

                <div class="controls">
                    <input type="text" id="username" name="username" value="" class="input-medium required"/>
                </div>
            </div>
            <div class="control-group">
                <label for="password" class="control-label">密码:</label>

                <div class="controls">
                    <input type="password" id="password" name="password" class="input-medium required"/>
                </div>
            </div>

            <div class="control-group">
                <div class="controls">
                    <label class="checkbox" for="rememberMe"><input type="checkbox" id="rememberMe" name="rememberMe"/>
                        记住我</label>
                    <input id="submit_btn" class="btn btn-primary" type="submit" value="登录"/>
                </div>
            </div>
        </form>

        <script>
            $(document).ready(function () {
                $("#loginForm").validate();
            });
        </script>
    </div>
    <div id="footer">
        Copyright  &copy; 2012-2014 YYOrz
    </div>

</div>
<script src="${ctx!''}/static/bootstrap/2.3.2/js/bootstrap.min.js" type="text/javascript"></script>
</body>
</html>


