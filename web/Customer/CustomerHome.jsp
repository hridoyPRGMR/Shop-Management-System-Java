<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shop.sys.entities.Category"%>
<%@page import="com.shop.sys.entities.Customer"%>
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

                                <%
                                    Customer customer=(Customer)session.getAttribute("currentCustomer");
                                    boolean customerExists=customer!=null;
                                    int customerId=0;
                                    if(customerExists){
                                        customerId=customer.getCid();
                                    }
                                %>

                                <%if(customer==null){%>
                                <a class="dropdown-item" href="#" id="signup">Sign Up</a>
                                <a class="dropdown-item" href="#" id="login">Login</a>
                                <%}else{%>

                                <a class="dropdown-item" href="#">Profile</a>
                                <a class="dropdown-item" href="#">Orders</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" id="logout">Logout</a>
                                <%}%>

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

        <!-- Sign Up Modal -->
        <div class="modal fade" id="signupModal" tabindex="-1" role="dialog" aria-labelledby="signupModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="signupModalLabel">Sign Up</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="signupForm">
                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="text" class="form-control" name="name" id="name" placeholder="Enter your name">
                            </div>
                            <div class="form-group">
                                <label for="email">Email address</label>
                                <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Enter email">
                                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                            </div>

                            <div class="form-group">
                                <label for="phoneNumber">Phone Number</label>
                                <input type="tel" class="form-control" name="phoneNumber" id="phoneNumber" placeholder="Enter phone number">
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" name="password" id="password" placeholder="Password">
                            </div>
                            <div class="form-group">
                                <label for="password2">Repeat Password</label>
                                <input type="password" class="form-control" name="password2" id="password2" placeholder="Repeat Password">
                                <div id="passwordMatchMsg" class="text-danger"></div>
                            </div>

                            <button type="submit" class="btn btn-primary">Sign Up</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="loginModalLabel">Sign Up</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="loginForm">
                            <div class="form-group">
                                <label for="email">Email address</label>
                                <input type="email" class="form-control" id="loginemail" name="email" aria-describedby="emailHelp" placeholder="Enter email">
                            </div>
                            <div class="form-group">
                                <label for="password">Name</label>
                                <input type="password" class="form-control" name="password" id="loginpassword" placeholder="Enter your password">
                            </div>
                            <button type="submit" class="btn btn-primary">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- Bootstrap JS and dependencies -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {



                const categoryItems = document.querySelectorAll(".category-item");
                fetchProductByCategoryId(0);
                categoryItems.forEach(function (item) {
                    item.addEventListener('click', function (e) {
                        e.preventDefault();
                        const categoryDropdown = document.getElementById('categoryDropdown');
                        const name = item.textContent;
                        categoryDropdown.innerText = name;

                        const catid = item.getAttribute('data-cid');
                        fetchProductByCategoryId(catid);
                    });
                });

                function fetchProductByCategoryId(catid) {
                    // Get the base URL dynamically
                    const baseUrl = window.location.origin + window.location.pathname.substring(0, window.location.pathname.lastIndexOf('/'));
                    const url = baseUrl + '/Customer/Load.jsp?catid=' + catid;
                    fetch(url)
                            .then(response => response.text())
                            .then(data => {
                                document.getElementById('showProduct').innerHTML = data;
                                const addToCartButtons = document.querySelectorAll('.addToCart');

                                //console.log(addToCartButtons);

                                const customerExists =<%=customerExists%>;
                                const customerId =<%=customerId%>

                                addToCartButtons.forEach(button => {
                                    button.addEventListener('click', function (e) {
                                        e.preventDefault();
                                        console.log("ok");
                                        if (customerExists) {
                                            console.log("customer id: ",customerId);
                                            console.log("product id: ",button.getAttribute('value'));
                                        }
                                    });
                                });

                            })
                            .catch(error => {
                                console.error('Error:', error);
                            });
                }

                //signup modal
                const signup = document.getElementById('signup');
                if (signup) {
                    signup.addEventListener('click', function (e) {
                        e.preventDefault();
                        $('#signupModal').modal('show');
                    });
                }

                //login modal
                const login = document.getElementById('login');
                if (login) {
                    login.addEventListener('click', function (e) {
                        e.preventDefault();
                        $('#loginModal').modal('show');
                    });
                }

//              logout
                const logout = document.getElementById('logout');
                if (logout) {
                    logout.addEventListener('click', function (e) {
                        e.preventDefault();

                        fetch('CustomerLogoutServlet', {
                            method: 'GET',
                        })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error('Network Response Was Not ok');
                                    }
                                    return response.text();
                                })
                                .then(data => {
                                    if (data.trim() === 'ok') {
                                        window.location.reload();
                                    }
                                })
                                .catch(error => {
                                    console.error('There was a problem with the fetch operation:', error);
                                });
                    });
                }


                //signup
                const signupForm = document.getElementById('signupForm');
                signupForm.addEventListener('submit', function (e) {
                    e.preventDefault();


                    const password1 = document.getElementById('password').value;
                    const password2 = document.getElementById('password2').value;


                    if (password1 !== password2) {
                        document.getElementById('passwordMatchMsg').textContent = "Passwords do not match. Please try again.";
                        setTimeout(function () {
                            document.getElementById('passwordMatchMsg').textContent = "";
                        }, 3000);
                        return;
                    }

                    const formData = new FormData(this);
                    const urlEncodedData = new URLSearchParams(formData);

                    fetch('CustomerSignUpServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: urlEncodedData
                    })
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error('Network response was not ok');
                                }
                                return response.text();
                            })
                            .then(data => {

                                if (data.trim() === 'ok') {
                                    $('#signupModal').modal('hide');
                                    Swal.fire({
                                        title: "Registration Successfull,Try to Login",
                                        showClass: {
                                            popup: `
                                                    animate__animated
                                                    animate__fadeInUp
                                                    animate__faster
                                                    `
                                        },
                                        hideClass: {
                                            popup: `
                                                    animate__animated
                                                    animate__fadeOutDown
                                                    animate__faster
                                                    `
                                        }
                                    });
                                }
                            })
                            .catch(error => {
                                console.error('There was a problem with the fetch operation:', error);
                            });
                });

                //login
                const loginForm = document.getElementById('loginForm');
                loginForm.addEventListener('submit', function (e) {
                    e.preventDefault();

                    const formData = new FormData(this);
                    const urlEncodeData = new URLSearchParams(formData);

                    fetch('CustomerLoginServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: urlEncodeData
                    })
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error('Network response was not ok');
                                }
                                return response.text(); // Corrected: call response.text() to get response body
                            })
                            .then(data => {
                                if (data.trim() === 'loginOk') {
                                    console.log("ok");
                                    $('#loginModal').modal('hide');
                                    window.location.reload();
//                                    document.getElementById('signup').style.display = 'none';
//                                    document.getElementById('login').style.display = 'none';
                                }
                            })
                            .catch(error => {
                                console.error('There was a problem with the fetch operation:', error);
                                // Handle errors here
                            });
                });

            });
        </script>




    </body>
</html>
