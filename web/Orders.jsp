<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.shop.sys.dao.CategoryDao, com.shop.sys.dao.ProductsDao, com.shop.sys.entities.Category, com.shop.sys.entities.User, com.shop.sys.entities.Products, com.sho.sys.helper.ConnectionProvider, com.shop.sys.dao.OrdersDao, java.util.List, java.util.ArrayList, java.sql.Timestamp" %>
<%@page import="java.util.Set"%>
<%@page import="com.google.gson.Gson"%>

<%
    Gson gson = new Gson();
%>

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
                            <option value="<%= date %>" class="c-link shaon"><%= date %></option>
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
                            document.getElementById('order-container').innerHTML = data;
                            const confirmOrderRequests = document.querySelectorAll('.confirmOrderRequest');
                            const removeOrder = document.querySelectorAll('.btn-outline-danger');

                            confirmOrderRequests.forEach(confirm => {
                                confirm.addEventListener('click', function (e) {
                                    e.preventDefault();

                                    Swal.fire({
                                        title: "Are you sure?",
                                        showDenyButton: true,
                                        confirmButtonText: "Yes",
                                        denyButtonText: `No,Cancel It`
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            const orderDetails = JSON.parse(this.dataset.orderDetails);
                                            const payload = {
                                                orderDetails: orderDetails
                                            };
                                            fetch('OrderConfirmServlet', {
                                                method: 'POST',
                                                headers: {
                                                    'Content-Type': 'application/json'
                                                },
                                                body: JSON.stringify(payload)
                                            })
                                                    .then(response => {
                                                        if (!response.ok) {
                                                            throw new Error('Network response was not ok');
                                                        }
                                                        return response.json();
                                                    })
                                                    .then(data => {
                                                        if (data.success) {
                                                            Swal.fire("Deleted!", "", "success");
                                                            filterProducts();
                                                        } else {
                                                            Swal.fire("Something wrong", "", "error");
                                                        }
                                                    })
                                                    .catch(error => console.error('Error:', error));
                                        } else if (result.isDenied) {
                                            Swal.fire("Canceled", "", "info");
                                        }
                                    });
                                });
                            });

                            removeOrder.forEach(remove => {
                                remove.addEventListener('click', function (e) {
                                    e.preventDefault();

                                    const str = remove.value;

                                    let cnt = 0;
                                    let arr = ["", "", ""];

                                    for (let i = 0; i < str.length; i++) {
                                        if (cnt <= 1 && str[i] == '-') {
                                            cnt++;
                                            continue;
                                        }
                                        if (cnt == 0)
                                            arr[0] += str[i];
                                        else if (cnt == 1)
                                            arr[1] += str[i];
                                        else
                                            arr[2] += str[i];
                                    }

                                    const formData = new FormData();
                                    formData.append("cid", arr[0]);
                                    formData.append("pid", arr[1]);
                                    formData.append("date", arr[2]);
                                    const urlEncodedData = new URLSearchParams(formData);

                                    fetch('RemoveOrderServlet', {
                                        method: 'POST',
                                        headers: {
                                            'Content-Type': 'application/x-www-form-urlencoded'
                                        },
                                        body: urlEncodedData
                                    })
                                            .then(response => {
                                                if (!response.ok) {
                                                    throw new Error('net work response was not ok');
                                                }
                                                return response.text();
                                            })
                                            .then(data => {
                                                if (data.trim() == "ok") {
                                                    Swal.fire({
                                                        position: "top",
                                                        icon: "success",
                                                        title: "Successfully removed",
                                                        showConfirmButton: false,
                                                        timer: 1500
                                                    });
                                                    filterProducts();
                                                }
                                            })
                                            .catch(error => {
                                                console.error("problem with fetch operation:", error);
                                            });
                                });
                            });
                        })
                        .catch(error => {
                            console.error('Error fetching details:', error);
                        });
            }
        </script>

    </body>

</html>
