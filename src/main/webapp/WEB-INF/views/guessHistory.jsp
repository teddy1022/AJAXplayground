<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.systex.playground.model.GameRecord" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guess Game History</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index">Playground</a>
            <div class="ml-auto">
                <span class="navbar-text">
                    Welcome,
                    <% 
                        com.systex.playground.model.Member loggedInUser = (com.systex.playground.model.Member) session.getAttribute("loggedInUser");
                        String username = (loggedInUser != null) ? loggedInUser.getUsername() : "Guest";
                    %>
                    <%= username %>!
                </span>
                <form id="logoutForm" action="logout" method="get" class="d-inline">
                    <button class="btn btn-outline-danger my-2 my-sm-0" type="button" onclick="confirmLogout()">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h1 class="text-center mb-4">Your Guess Game History</h1>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th scope="col" style="width: 50%;">Play Time (yyyy/mm/dd HH:mm)</th>
                        <th scope="col" style="width: 50%;">Result</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<GameRecord> gameRecords = (List<GameRecord>) request.getAttribute("gameRecords");
                        if (gameRecords != null && !gameRecords.isEmpty()) {
                            for (GameRecord record : gameRecords) {
                    %>
                    <tr>
                        <td><%= record.getTime().format(java.time.format.DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm")) %></td>
                        <td style="<%= record.getResult() == 1 ? "background-color: #d4edda;" : "background-color: #f8d7da;" %>">
                            <%= record.getResult() == 1 ? "Win" : "Lose" %>
                        </td>
                    </tr>
                    <% 
                            }
                        } else { 
                    %>
                    <tr>
                        <td colspan="2" class="text-center">No game history available.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="text-center mt-4">
            <a href="index" class="btn btn-secondary">Back to Home</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="<%= request.getContextPath() %>/javascripts/logout.js"></script>
</body>
</html>
