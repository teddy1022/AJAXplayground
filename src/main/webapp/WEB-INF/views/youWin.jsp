<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.systex.playground.model.Member" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>You Win!</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index">Guess Game</a>
            <div class="ml-auto">
                <span class="navbar-text">
                    Welcome,
                    <% 
                        Member loggedInUser = (Member) session.getAttribute("loggedInUser");
                        String username = (loggedInUser != null) ? loggedInUser.getUsername() : "Guest";
                    %>
                    <%= username %>!
                </span>

            </div>
        </div>
    </nav>

    <div class="container mt-5 text-center">
        <h1 class="display-4 text-success">Congratulations! You guessed the correct number!</h1>
        <p class="lead mt-4">Great job!</p>
        <a href="guess" class="btn btn-primary btn-lg mt-3">Play Again</a>
    </div>
    <div class="text-center mt-3">
        <a href="${pageContext.request.contextPath}/guesshistory" class="btn btn-info my-2 my-sm-0">View History</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
