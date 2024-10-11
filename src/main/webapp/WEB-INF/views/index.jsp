<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <span class="navbar-text">
                Welcome, ${sessionScope.loggedInUser.username}!
            </span>
            <div class="ml-auto">
                <!-- 查看历史按钮 -->
                <a href="${pageContext.request.contextPath}/guesshistory" class="btn btn-info my-2 my-sm-0 mr-2">Guess Game History</a>
                <!-- 登出按钮 -->
                <form id="logoutForm" action="logout" method="get" class="d-inline">
                    <button class="btn btn-outline-danger my-2 my-sm-0" type="button" onclick="confirmLogout()">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <!-- 主体内容 -->
    <div class="container mt-5">
        <h1 class="text-center">Welcome!!!</h1>
        <div class="row mt-4">
            <div class="col text-center">
                <a href="lottery" class="btn btn-primary btn-lg m-2">Go to Lottery Number Generator</a>
                <a href="guess" class="btn btn-success btn-lg m-2">Guess Game</a>
            </div>
        </div>
    </div>

    <!-- 引入 Bootstrap JS 和依赖 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="<%= request.getContextPath() %>/javascripts/logout.js"></script>
</body>
</html>
