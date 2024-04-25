<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shop.sys.dao.CategoryDao"%>
<%@page import="com.shop.sys.dao.ProductsDao"%>
<%@page import="com.shop.sys.entities.Category"%>
<%@page import="com.shop.sys.entities.User"%>
<%@page import="com.shop.sys.entities.Products"%>
<%@page import="com.sho.sys.helper.ConnectionProvider"%>
<%@page import="java.util.ArrayList"%>

<%
    User user=(User)session.getAttribute("currentUser");
    if(user==null){
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
                background-color: white;
            }

            .container {
                max-width: 90%; /* Increase container size */
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                margin: 30px auto; /* Center container */
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
                background-color: #0056b3; /* Change color for active state */
                border-color: #0056b3;
                color: #fff; /* Change text color for active state */
            }

            /*lload post*/
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

        </style>
    </head>

    <body>
        <div class="container">
            <!-- Mini Navbar -->
            <div class="text-center mb-4">
                <button id="showProductButton" class="btn btn-primary active" onclick="showLatestProduct()">Show Product</button>
                <button id="addProductButton" class="btn btn-primary mr-3" onclick="showAddProduct()">Add Product</button>
            </div>

            <!-- Add Product Section -->
            <div id="addProductSection" style="display: none;">
                <div class="row">
                    <div class="col-lg-8 mb-4 add-product-column">
                        <h4 class="mb-4">Add Product</h4>

                        <form id="productForm">
                            <div class="form-group">
                                <label for="productName">Product Name</label>
                                <input type="text" class="form-control" id="productName" name="productName" placeholder="Enter product name" required>
                            </div>
                            <div class="form-group">
                                <label>Select Product Image</label>
                                <input id="productImage" name="productImage" type="file"> 
                            </div>
                            <div class="form-group">
                                <label for="productCategory">Product Category</label>
                                <select class="form-control" id="productCategory" name="cid" required>
                                    <option selected disabled>Select category</option>
                                    <%
                                       CategoryDao cd=new CategoryDao(ConnectionProvider.getConnection());
                                       ArrayList<Category>list=cd.getCategory();
                                       
                                       for(Category cat:list){
                                    %>
                                    <option value="<%=cat.getCid()%>"><%= cat.getCname() %></option>
                                    <%
                                        }   
                                    %>
                                    <!-- Add more categories as needed -->
                                </select>
                                <!--<small class="form-text text-muted">Can't find the category? <a href="#" data-toggle="modal" data-target="#exampleModal">Add category</a></small>-->
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="unitPrice">Unit Price ($)</label>
                                    <input type="number" class="form-control" id="unitPrice" name="unitPrice" placeholder="Enter unit price" required>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="productCount">Product Count</label>
                                    <input type="number" class="form-control" id="productCount" name="productCount" placeholder="Enter product count" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="manufacturer">Manufacturer</label>
                                <input type="text" class="form-control" id="manufacturer" name="manufacturer" placeholder="Enter manufacturer name" required>
                            </div>
                            <div class="form-group">
                                <label for="shortDescription">Short Description</label>
                                <textarea class="form-control" id="shortDescription" name="shortDescription" rows="3" placeholder="Enter short description"></textarea>
                            </div>
                            <button type="submit" id="submitBtn" class="btn btn-primary btn-block">Add Product</button>
                        </form>

                    </div>
                    <!--latest addded product-->
                    <div class="col-lg-4 mb-4">
                        <h1>Recent Added:</h1>
                        <div id="latestAddedProduct" style="display:none">

                        </div>
                    </div>

                </div>
            </div>

            <!-- Latest Product Section -->
            <div id="latestProductSection">
                <div class="row">
                    <nav class="navbar navbar-expand navbar-light bg-white topbar static-top shadow">
                        <form class="form-inline mr-auto">
                            <select id="filterSelect" class="form-control" onchange="filterProducts()">
                                <option value="0" class="c-link active">All</option>
                                <% 
                                    for (Category cat : list) {
                                %>
                                <option value="<%= cat.getCid() %>" class="c-link"><%= cat.getCname() %></option>
                                <% 
                                    } 
                                %>
                            </select>
                        </form>
                        <form class="form-inline my-2 my-lg-0 ml-auto" onsubmit="searchProducts(event)">
                            <div class="input-group">
                                <input id="searchInput" class="form-control search-input" type="search" placeholder="Search for..." aria-label="Search">
                                <div class="input-group-append">
                                    <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
                                </div>
                            </div>
                        </form>
                    </nav>
                    <!-- Your existing content for 'Add Product' and 'Show Product' sections -->
                    <div class="container-fluid" id="product-container">
                        
                    </div>
                </div>
            </div>
        </div>



        <!-- Bootstrap JS and dependencies -->

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="JS/myjs.js" type="text/javascript"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <!--add product script-->

        <script>

        </script>

        <script>
            $(document).ready(function () {
                $('#productForm').submit(function (e) {
                    e.preventDefault();

                    var formData = new FormData(this);

                    $.ajax({
                        type: 'POST',
                        url: 'AddProductsServlet',
                        data: formData,
                        contentType: false,
                        processData: false,
                        success: function (data, textStatus, jqXHR) {
                            if (data.trim() === 'Product Added') {
                                // Fetch form details
                                var productName = $('#productName').val();
                                var img = $('#productImage')[0]; // Assuming this is a file input, use .files[0].name to get the file name
                                var unitPrice = $('#unitPrice').val();
                                var productCount = $('#productCount').val();
                                var manufacturer = $('#manufacturer').val();
                                var productDescription = $('#shortDescription').val();

                                var selectedFile = img.files[0];
                                var imageUrl = URL.createObjectURL(selectedFile);

                                // Build HTML content for the card within the latestAddedProduct div
                                var content = '<div class="card">';
                                content += '<img src="' + imageUrl + '" class="card-img-top" style="max-width:300px" alt="Product Image">';
                                content += '<div class="card-body">';
                                content += '<h5 class="card-title">' + productName + '</h5>';
                                content += '<p class="card-text">' + productDescription + '</p>';
                                content += '<ul class="list-group list-group-flush">';
                                content += '<li class="list-group-item">Unit Price: $' + unitPrice + '</li>';
                                content += '<li class="list-group-item">Product Count: ' + productCount + '</li>';
                                content += '<li class="list-group-item">Manufacturer: ' + manufacturer + '</li>';
                                content += '</ul>';
                                content += '</div>';
                                content += '</div>';

                                // Display the content within the latestAddedProduct div
                                $('#latestAddedProduct').html(content).fadeIn();
                                // Clear the form
                                $('#productForm')[0].reset();
                            } else {
                                alert('Failed to add product.');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(errorThrown);
                            alert('An error occurred while adding product.');
                        }
                    });
                });
            });
        </script>
        <!--add product script ended-->

        <script>
            // Function to show the Add Product Section and hide the Latest Product Section
            function showAddProduct() {
                document.getElementById('addProductSection').style.display = 'block';
                document.getElementById('latestProductSection').style.display = 'none';

                // Add 'active' class to 'Add Product' button
                document.getElementById('addProductButton').classList.add('active');
                // Remove 'active' class from 'Show Product' button
                document.getElementById('showProductButton').classList.remove('active');
            }

            // Function to show the Latest Product Section and hide the Add Product Section
            function showLatestProduct() {
                document.getElementById('addProductSection').style.display = 'none';
                document.getElementById('latestProductSection').style.display = 'block';

                // Add 'active' class to 'Show Product' button
                document.getElementById('showProductButton').classList.add('active');
                // Remove 'active' class from 'Add Product' button
                document.getElementById('addProductButton').classList.remove('active');
            }
        </script>


        <script>
            function filterProducts() {
                let catId = $("#filterSelect").val(); // Get the selected category ID from the dropdown
                let temp = $("#filterSelect option:selected")[0]; // Get the selected option element

                $.ajax({
                    url: "LoadProducts.jsp",
                    method: "GET",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data); // Log the received data to the console for debugging
                        $("#product-container").html(data); // Update product container with fetched data
                        
                        // Toggle 'active' class based on selected category
                        $(".c-link").removeClass("active"); // Remove 'active' class from all links
                        $(temp).addClass("active"); // Add 'active' class to the selected option
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.error("Error loading products:", errorThrown); // Log any errors to the console
                        // Optionally display an error message or handle error gracefully
                    }
                });
            }

            $(document).ready(function () {
                // Load all products (category ID = 0) initially
                filterProducts(); // Call the filterProducts function on page load
            });
        </script>



    </body>

</html>