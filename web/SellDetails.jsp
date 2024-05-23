<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.sho.sys.helper.ConnectionProvider" %>
<%@ page import="com.shop.sys.dao.SellDetailsDao" %>
<%@ page import="com.shop.sys.entities.OrderDetails" %>
<%@ page import="com.shop.sys.entities.Products" %>
<%@ page import="com.shop.sys.entities.Customer" %>
<%@ page import="com.shop.sys.entities.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Sell Details</title>

    <style>
        .container {
            margin-top: 20px;
        }
        .navbar {
            border-radius: 5px;
        }
        .list-group-item {
            transition: background-color 0.3s ease;
        }
        .list-group-item:hover {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <%
        SellDetailsDao sd = new SellDetailsDao(ConnectionProvider.getConnection());
        List<OrderDetails> details = sd.getAllSellData();
    %>

    <div class="container">
        <div class="card">
            <nav class="navbar navbar-light bg-light">
                <div class="container-fluid">
                    <h3 class="navbar-brand">Sell Information</h3>
                    <h6 class="ms-auto">Total Sell: <%= details.size() %></h6>
                </div>
            </nav>

            <ul class="list-group list-group-flush">
                <%
                    for (OrderDetails d : details) {
                        String pname = d.getProduct().getPname();
                        int pid = d.getProduct().getPid();
                        int q = d.getQuantity();
                        int p = d.getProduct().getUnitprice() * q;
                %>
                <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                    <div class="d-flex flex-column">
                        <p class="mb-1"><strong>Customer Id:</strong> <%= d.getCustomer().getCid() %></p>
                        <p class="mb-1"><strong>Customer Name:</strong> <%= d.getCustomer().getCname() %></p>
                    </div>
                    <div class="d-flex flex-column text-end">
                        <p class="mb-1"><strong>Product Name:</strong> <%= pname %></p>
                        <p class="mb-1"><strong>Product Id:</strong> <%= pid %></p>
                        <p class="mb-1"><strong>Quantity:</strong> <%= q %></p>
                        <p class="mb-1"><strong>Price:</strong> $<%= p %></p>
                    </div>
                </li>
                <% } %>
            </ul>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
