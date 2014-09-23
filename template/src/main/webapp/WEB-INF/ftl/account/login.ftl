<!DOCTYPE html>
<html>
<head>
    <title>登录</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta http-equiv="Cache-Control" content="no-store"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>

    <link type="image/x-icon" href="${ctx!''}/static/images/favicon.ico" rel="shortcut icon">
    <link href="${ctx!''}/static/bootstrap/3.2.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx!''}/static/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx!''}/static/styles/default.css" type="text/css" rel="stylesheet"/>
    <script src="${ctx!''}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="${ctx!''}/static/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
    <script src="${ctx!''}/static/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
    <style type="text/css">


    </style>
</head>

<body style="padding-top: 40px;padding-bottom: 40px;background-color: #eee;">
<div class="container">
<#if error??>
    <div class="alert alert-error input-medium controls">
        <button class="close" data-dismiss="alert">×</button>
        登录失败，请重试.
    </div>
</#if>
    <form id="loginForm" class="form-signin" action="${ctx!''}/login" method="post">
        <h2 class="form-signin-heading">Please sign in</h2>
        <input type="text"  id="username" name="username" class="form-control" placeholder="用户名" required="" autofocus="">
        <input type="password" id="password" name="password" class="form-control" placeholder="密码" required="">
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me" name="rememberMe"> Remember me
            </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
    </form>
</div>

    <script>
        $(document).ready(function () {
            $("#loginForm").validate();
        });
    </script>
    <div id="footer">
        Copyright  &copy; 2012-2014 YYOrz
    </div>

<script src="${ctx!''}/static/bootstrap/3.2.0/js/bootstrap.min.js" type="text/javascript"></script>
</body>
</html>


