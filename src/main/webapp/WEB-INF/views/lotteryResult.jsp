<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lottery Result</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index">Lottery Number Generator</a>
            <div class="ml-auto">
                <span class="navbar-text">
                    Welcome,
                    <% 
                        com.systex.playground.model.Member loggedInUser = (com.systex.playground.model.Member) session.getAttribute("loggedInUser");
                        String username = (loggedInUser != null) ? loggedInUser.getUsername() : "Guest";
                    %>
                    <%= username %>!
                </span>
                
            </div>
        </div>
    </nav>

    <div class="container mt-0 text-center">
        <h1 class="mb-3 mt-3">Generated Lottery Numbers</h1>

        <div class="table-responsive">
            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th scope="col" style="width: 10%; font-size: 1.5rem;">Set</th>
                        <th scope="col" style="font-size: 1.5rem;">Lottery Numbers</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<List<Integer>> currentPageResults = (List<List<Integer>>) request.getAttribute("currentPageResults");
                        if (currentPageResults != null) {
                            for (int i = 0; i < currentPageResults.size(); i++) {
                                int setNumber = ((Integer) request.getAttribute("currentPage") - 1) * 10 + i + 1;
                                List<Integer> numbers = currentPageResults.get(i);
                    %>
                    <tr>
                        <td><%= setNumber %></td>
                        <td style="font-size: 1.5rem;">
                            <% for (Integer number : numbers) { %>
                                <%= String.format("%02d", number) %> 
                            <% } %>
                        </td>
                    </tr>
                    <% 
                            }
                        } 
                    %>
                </tbody>
            </table>
        </div>

        <!-- Pagination Controls -->
        <div class="d-flex justify-content-center align-items-center">
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center" style="margin-top : 1.2rem">
                    <% 
                        int currentPage = (Integer) request.getAttribute("currentPage");
                        int totalPages = (Integer) request.getAttribute("totalPages");
                        int maxPagesToShow = 5;
                    %>
                    <% if (currentPage > 1) { %>
                        <li class="page-item">
                            <a class="page-link" href="lotteryResult?page=<%= currentPage - 1 %>" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                    <% } %>

                    <% 
                        int startPage = Math.max(1, currentPage - maxPagesToShow / 2);
                        int endPage = Math.min(totalPages, startPage + maxPagesToShow - 1);
                        if (startPage > 1) { 
                    %>
                        <li class="page-item">
                            <a class="page-link" href="lotteryResult?page=1">1</a>
                        </li>
                        <% if (startPage > 2) { %>
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        <% } %>
                    <% } %>

                    <% for (int i = startPage; i <= endPage; i++) { %>
                        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                            <a class="page-link" href="lotteryResult?page=<%= i %>"><%= i %></a>
                        </li>
                    <% } %>

                    <% if (endPage < totalPages) { %>
                        <% if (endPage < totalPages - 1) { %>
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        <% } %>
                        <li class="page-item">
                            <a class="page-link" href="lotteryResult?page=<%= totalPages %>"><%= totalPages %></a>
                        </li>
                    <% } %>

                    <% if (currentPage < totalPages) { %>
                        <li class="page-item">
                            <a class="page-link" href="lotteryResult?page=<%= currentPage + 1 %>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    <% } %>
                </ul>
            </nav>
            <% if (totalPages > 10) { %>
                <form action="lotteryResult" method="get" class="form-inline ml-3">
                    <div class="form-group">
                        <label for="pageInput" class="mr-2">Go to page:</label>
                        <input type="number" class="form-control" id="pageInput" name="page" min="1" max="<%= totalPages %>" required>
                    </div>
                    <button type="submit" class="btn btn-primary ml-2">Go</button>
                </form>
            <% } %>
            
        </div>
		<a href="lottery" class="btn btn-primary btn-lg ml-2 mt-3">Generate Again</a>
        
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
        function confirmLogout() {
            if (confirm("Are you sure you want to log out?")) {
                document.getElementById("logoutForm").submit();
            }
        }
    </script>
</body>
</html>