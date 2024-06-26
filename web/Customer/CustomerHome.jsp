<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shop.sys.entities.Category"%>
<%@page import="com.shop.sys.entities.Customer"%>
<%@page import="com.shop.sys.entities.Products"%>
<%@page import="com.shop.sys.entities.Orders"%>
<%@page import="com.shop.sys.dao.CategoryDao"%>
<%@page import="com.shop.sys.dao.OrdersDao"%>
<%@page import="com.shop.sys.dao.ProductsDao"%>
<%@page import="com.sho.sys.helper.ConnectionProvider"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>



<%
    Customer customer=(Customer)session.getAttribute("currentCustomer");
    boolean customerExists=customer!=null;
    
    int cid=-1;
    if(customerExists){
        cid=customer.getCid();
    }
%>

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
                                <a class="dropdown-item" href="#" id="orders">Orders</a>

                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" id="logout">Logout</a>
                                <%}%>

                            </div>
                        </li>
                        <%if(customerExists){%>
                        <li class="nav-item">
                            <a class="nav-link" href="Customer/Cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
                        </li>
                        <%}%>
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
                                <label for="address">Address </label>
                                <input type="text" class="form-control" name="address" id="address" placeholder="Give your full Address">
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
                        <h5 class="modal-title" id="loginModalLabel">Login</h5>
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

        <!-- Orders Modal -->
        <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Orders</h5>
                    </div>
                    <div class="modal-body">
                        <%  
                            if(cid >= 1) {
                                OrdersDao od = new OrdersDao(ConnectionProvider.getConnection());
                                ProductsDao pd = new ProductsDao(ConnectionProvider.getConnection());
                                List<Orders> orders = od.getOrdersByCid(cid);
                        %>
                        <ul class="list-group">
                            <% for(Orders o : orders) {
                                Products p = pd.getProductByPid(o.getProductId());
                                int quantity = o.getQuantity();
                                int price = p.getUnitprice();
                            %>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <img class="img-fluid rounded mr-3" style="max-height: 30px; max-width: 30px;" src="Image/<%= p.getPimg() %>" alt="<%= p.getPname() %>"/>
                                    <div>
                                        <h6 class="mb-0"><%= p.getPname() %></h6>
                                        <small class="text-muted">Status: <%= o.getStatus() %></small>
                                    </div>
                                </div>
                                <div>
                                    <p class="mb-0">Quantity: <%= quantity %></p>
                                    <p class="mb-0">Price: <%= quantity * price %> </p>
                                </div>
                            </li>
                            <% } %>
                        </ul>
                        <% } else { %>
                        <div class="text-center">
                            <h5>Please log in</h5>
                        </div>
                        <% } %>
                    </div>

                    <div class="modal-footer">
                        <button type="button" id="closeOrderModal" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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

                const order = document.getElementById('orders');
                const closeOrderModal = document.getElementById('closeOrderModal');
                const modal = new bootstrap.Modal(document.getElementById('exampleModal2'));

                if (order) {
                    order.addEventListener('click', function (e) {
                        e.preventDefault();
                        modal.show();
                    });
                }

                closeOrderModal.addEventListener('click', function (e) {
                    e.preventDefault();
                    modal.hide();
                });

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
                                            const productId = button.getAttribute('value');
                                            addToCart(customerId, productId);
                                        } else {
                                            $('#loginModal').modal('show');
                                        }
                                    });
                                });

                            })
                            .catch(error => {
                                console.error('Error:', error);
                            });
                }

                function addToCart(customerId, productId) {
                    const formData = new FormData();
                    formData.append('customerId', customerId);
                    formData.append('productId', productId);
                    const urlEncodedData = new URLSearchParams(formData);

                    fetch('AddToCartServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: urlEncodedData
                    })
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error('Network Response Was Not ok');
                                }
                                return response.text();
                            })
                            .then(data => {
                                if (data.trim() === 'addedtocart') {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Product Added to Cart',
                                        showConfirmButton: false,
                                        timer: 1000 //0.5 sec
                                    });
                                } else {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Product already exist in cart',
                                        timer: 1000 //0.5 sec
                                    });
                                }

                            })
                            .catch(error => {
                                console.error('There was a problem with the fetch operation:', error);
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
