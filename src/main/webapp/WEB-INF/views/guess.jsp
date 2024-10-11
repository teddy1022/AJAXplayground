<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guess Game</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index">Guess Game</a>
            <div class="ml-auto">
                <span class="navbar-text">
                    Welcome, ${sessionScope.loggedInUser.username}!
                </span>
                <form id="logoutForm" class="form-inline d-inline" action="logout" method="get">
                    <button class="btn btn-outline-danger ml-2" type="button" onclick="confirmLogout()">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h1 class="text-center mb-4">Guess a number between 1 and 10</h1>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <form action="guess" method="post">
                    <div class="form-group">
                        <label for="guessNumber">Your guess:</label>
                        <input type="text" class="form-control" id="guessNumber" name="guessNumber" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Submit Guess</button>
                </form>

                <div class="mt-4">
                    <%
                        String error = request.getParameter("error");
                        String remains = request.getParameter("remains");
                        String hint = (String) session.getAttribute("hint");
                    %>
                
                    <% if ("invalid".equals(error)) { %>
                        <div class="alert alert-danger" role="alert">
                            Please enter a valid number!
                        </div>
                    <% } %>

                    <% if (remains != null && !remains.isEmpty()) { %>
                        <div class="alert alert-info" role="alert">
                            You have <%= remains %> guesses left.
                        </div>
                    <% } %>
                
                    <% if (hint != null && !hint.isEmpty()) { %>
                        <div class="alert alert-success" role="alert">
                            <%= hint %>
                        </div>
                        <%
                            session.removeAttribute("hint");
                        %>
                    <% } %>
                </div>
                
                <div class="text-center mt-3">
                    <a href="index" class="btn btn-secondary">Back to Home</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="<%= request.getContextPath() %>/javascripts/logout.js"></script>
</body>
</html>
