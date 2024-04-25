<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shop.sys.entities.Category"%>
<%@page import="com.shop.sys.dao.CategoryDao"%>
<%@page import="com.sho.sys.helper.ConnectionProvider"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Stylish E-commerce Navbar</title>
        <!-- Bootstrap CSS -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <style>
            /* Custom styles */
            .navbar {
                background-color: #343a40; /* Dark background color */
            }
            .navbar-brand, .navbar-nav .nav-link {
                color: #ffffff; /* White text color */
            }
            .navbar-brand:hover, .navbar-nav .nav-link:hover {
                color: #f8f9fa; /* Lighter text color on hover */
            }
            .form-inline .form-control {
                width: 300px; /* Adjust the width of the search input */
            }
            .dropdown-menu {
                background-color: #343a40; /* Dark background color for dropdown */
            }
            .dropdown-menu .dropdown-item {
                color: #ffffff; /* White text color for dropdown items */
            }
            .dropdown-menu .dropdown-item:hover {
                background-color: #212529; /* Darker background color on hover */
            }
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container">
                <a class="navbar-brand" href="#">E-commerce Site</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="#">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Shop</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a id="categoryDropdown" class="nav-link dropdown-toggle" href="#" role="button"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                All
                            </a>
                            <div class="dropdown-menu" aria-labelledby="categoryDropdown">
                                
                                <% 
                                    CategoryDao cd = new CategoryDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> categories = cd.getCategory();
                                    for (Category cat : categories) {
                                %>
                                <a class="dropdown-item category-item" href="#" data-cid="<%= cat.getCid() %>"><%= cat.getCname() %></a>
                                <% } %>
                            </div>
                        </li>
                    </ul>

                    <form class="form-inline my-2 my-lg-0 mr-3">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-light my-2 my-sm-0" type="submit"><i class="fas fa-search"></i></button>
                    </form>

                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-user"></i> My Account
                            </a>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="#">Profile</a>
                                <a class="dropdown-item" href="#">Orders</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">Logout</a>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"><i class="fas fa-shopping-cart"></i> Cart</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="container" id="showProduct">
            
        </div>


        <!-- Bootstrap JS and dependencies -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const categoryItems = document.querySelectorAll(".category-item");
                fetchProductByCategoryId(0);
                categoryItems.forEach(function (item) {
                    item.addEventListener('click', function (e) {
                        e.preventDefault();
                        const categoryDropdown = document.getElementById('categoryDropdown'); // Corrected ID name
                        const name = item.textContent;
                        categoryDropdown.innerText = name;

                        const catid = item.getAttribute('data-cid');
                        fetchProductByCategoryId(catid);
                    });
                });

                function fetchProductByCategoryId(catid) {

                    let url = 'Load.jsp?catid=' + catid;

                    fetch(url)
                            .then(response => response.text())
                            .then(data => {
                                document.getElementById('showProduct').innerHTML = data; // Print the response from the second JSP page
                            })
                            .catch(error => {
                                console.error('Error:', error);
                            });
                }
            });
        </script>

    </body>
</html>
