<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.shop.sys.dao.CategoryDao, com.shop.sys.dao.ProductsDao, com.shop.sys.entities.Category, com.shop.sys.entities.User, com.shop.sys.entities.Products, com.sho.sys.helper.ConnectionProvider, com.shop.sys.dao.OrdersDao, java.util.List, java.util.ArrayList, java.sql.Timestamp" %>
<%@page import="java.util.Set"%>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }

            .container {
                max-width: 90%;
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                margin: 30px auto;
            }

            .form-group label {
                font-weight: bold;
            }

            .form-control {
                border-color: #ddd;
                box-shadow: none;
            }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 8px rgba(0, 123, 255, 0.4);
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }

            #latestProduct {
                display: none;
                margin-top: 30px;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #f5f5f5;
            }

            /* Custom Styling for Columns */
            .add-product-column {
                border-right: 1px solid #ddd;
            }

            @media (max-width: 768px) {
                .add-product-column {
                    border-right: none;
                    border-bottom: 1px solid #ddd;
                }
            }

            .btn-primary.active {
                background-color: #0056b3;
                border-color: #0056b3;
                color: #fff;
            }

            .product-card {
                border: 1px solid #ddd;
                border-radius: 8px;
                overflow: hidden;
                margin-bottom: 20px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .product-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .card-body {
                padding: 20px;
            }

            .card-title {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .card-text {
                color: #555;
            }

            .list-group-item {
                margin-bottom: 20px;
            }

            .list-group-item h3,
            .list-group-item h5,
            .list-group-item p {
                margin: 0;
                padding: 0;
            }

            .list-group-item img {
                max-width: 100px;
                height: auto;
                object-fit: cover;
            }
        </style>
    </head>

    <body>

        <%
            OrdersDao od = new OrdersDao(ConnectionProvider.getConnection());
            Set<Timestamp> orderDate = od.getOrderDates();
        %>

        <div class="container">
            <div class="row">
                <nav class="navbar navbar-expand navbar-light bg-white topbar static-top shadow mb-4">
                    <h6 class="pt-2 mr-2">Order Dates</h6>
                    <form class="form-inline mr-auto">
                        <select id="filterSelect" class="form-control" onchange="filterProducts()">
                            <option value="0" class="c-link active">Select Dates</option>
                            <% for (Timestamp date : orderDate) { %>
                            <option value="<%= date %>" class="c-link"><%= date %></option>
                            <% } %>
                        </select>
                    </form>
                </nav>

                <!-- Product Container -->
                <div class="container-fluid" id="order-container">
                    
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <script>

        </script>

        <script>
            function filterProducts() {
                const filterSelect = document.getElementById('filterSelect');
                const selectedValue = filterSelect.value;
                filter(selectedValue);
            }

            function filter(selectedDate) {
                fetch('LoadOrders.jsp', {// Update the URL to point to LoadOrders.jsp
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'selectedDate=' + encodeURIComponent(selectedDate)
                })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.text();
                        })
                        .then(data => {
                            //console.log(data);
                            document.getElementById('order-container').innerHTML=data;
                        })
                        .catch(error => {
                            console.error('Error fetching details:', error);
                        });
            }


        </script>

    </body>

</html>
