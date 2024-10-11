<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AJAX Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index">Playground</a>
            <div id="navActions" class="ml-auto">
                <a href="register" id="registerButton" class="btn btn-outline-primary">Register</a>
                <span id="welcomeUser" class="navbar-text" style="display: none;">Welcome, <span id="usernameDisplay"></span>!</span>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h1 class="text-center">AJAX Login</h1>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div id="loginError" class="alert alert-danger mt-3" style="display: none;"></div>
                <form id="ajaxLoginForm">
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" id="username" name="username" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" class="form-control" required>
                    </div>
                    <button type="button" id="loginButton" class="btn btn-primary btn-block">Login</button>
                </form>
                
                <p id="switchToStandardLogin" class="mt-3 text-center">
                    Or switch to <a href="login">Standard Login</a>
                </p>
                <p id="registerLink" class="mt-3 text-center">Don't have an account? <a href="register">Register here</a></p>

                <div id="loginSuccess" class="alert alert-success mt-3" style="display: none;"></div>
            </div>
        </div>
    </div>

    <script src="<%= request.getContextPath() %>/javascripts/ajaxlogin.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>