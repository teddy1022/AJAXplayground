<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Login - Playground</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index">Playground</a>
            <div class="ml-auto">
                <a href="register" class="btn btn-outline-primary">Register</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h1 class="text-center mb-4">Login</h1>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <!-- 成功消息显示 -->
                <%
                    String success = (String) request.getAttribute("success");
                    if (success == null) {
                        success = (String) session.getAttribute("success");
                        if (success != null) {
                            session.removeAttribute("success");
                        }
                    }
                    if (success != null && !success.isEmpty()) {
                %>
                    <div class="alert alert-success" role="alert">
                        <%= success %>
                    </div>
                <% } %>

                <!-- 错误消息显示 -->
                <%
                    String error = (String) request.getAttribute("error");
                    if (error == null) {
                        error = (String) request.getParameter("error");
                    }
                    if (error != null && !error.isEmpty()) {
                %>
                    <div class="alert alert-danger" role="alert">
                        <%= error %>
                    </div>
                <% } %>

                <!-- 登录表单 -->
                <form action="login" method="post">
    <div class="form-group">
        <label for="username">Username:</label>
        <input type="text" class="form-control" id="username" name="username" required>
    </div>

    <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" class="form-control" id="password" name="password" required>
    </div>

    <button type="submit" class="btn btn-primary btn-block">Login</button>
</form>

                <!-- 切换到 AJAX 登录的链接 -->
                <p class="mt-3 text-center">
                    Or switch to <a href="ajaxlogin">AJAX Login</a>
                </p>

                <!-- 注册页面的链接 -->
                <p class="mt-3 text-center">
                    Don't have an account? <a href="register">Register here</a>
                </p>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
