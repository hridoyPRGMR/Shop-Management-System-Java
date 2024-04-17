<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shop.sys.entities.User"%>

<%
    User user=(User)session.getAttribute("currentUser");
    if(user==null){
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link href="CSS/sidebar.css" rel="stylesheet" type="text/css"/>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <title>Home</title>
    </head>
    <body>

        <div class="sidebar">
            <div class="logo_details">
                <i class="bx bxl-audible icon"></i>
                <div class="logo_name">Code Effect</div>
                <i class="bx bx-menu" id="btn"></i>
            </div>
            <ul class="nav-list">
                <li>
                    <i class="bx bx-search"></i>
                    <input type="text" placeholder="Search...">
                    <span class="tooltip">Search</span>
                </li>
                <li>
                    <a href="#" class="navLink" data-page-url="DashBoard.jsp">
                        <i class="bx bx-grid-alt" ></i>
                        <span class="link_name">Dashboard</span>
                    </a>
                    <span class="tooltip">Dashboard</span>
                </li>
                
                <li>
                    <a a="#" class="navLink" data-page-url="ManageProducts.jsp">
                        <i class="fa-solid fa-cart-plus"></i>
                        <span class="link_name">Manage</span>
                    </a>
                    <span class="tooltip">Manage</span>
                </li>
                
                <li>
                    <a href="#" class="navLink" data-page-url="Profile.jsp">
                        <i class="bx bx-user"></i>
                        <span class="link_name">User</span>
                    </a>
                    <span class="tooltip">User</span>
                </li>
                <li>
                    <a href="#">
                        <i class="bx bx-chat"></i>
                        <span class="link_name">Message</span>
                    </a>
                    <span class="tooltip">Message</span>
                </li>
                <li>
                    <a href="#">
                        <i class="bx bx-pie-chart-alt-2"></i>
                        <span class="link_name">Analytics</span>
                    </a>
                    <span class="tooltip">Analytics</span>
                </li>
                <li>
                    <a href="#">
                        <i class="bx bx-folder"></i>
                        <span class="link_name">File Manger</span>
                    </a>
                    <span class="tooltip">File Manger</span>
                </li>
                <li>
                    <a href="#">
                        <i class="bx bx-cart-alt"></i>
                        <span class="link_name">Order</span>
                    </a>
                    <span class="tooltip">Order</span>
                </li>
                <li>
                    <a href="#">
                        <i class="bx bx-cog"></i>
                        <span class="link_name">Settings</span>
                    </a>
                    <span class="tooltip">Settings</span>
                </li>
                <li class="profile">
                    <div class="profile_details">
                        <img src="" alt="profile image">
                        <div class="profile_content">
                            <div class="name">Anna Jhon</div>
                            <div class="designation">Admin</div>
                        </div>
                    </div>
                    <a href="LogoutServlet" id="log_out" class="logout-link" ">
                        <i  class="bx bx-log-out" style="margin-left:10px"></i>
                    </a>
                </li>
            </ul>
        </div>
        <section class="home-section" id="main-content">
            <%@include file="DashBoard.jsp"%>
        </section>


        <script src="JS/sidebar.js" type="text/javascript"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <script>
            $(document).ready(function () {
                $('.navLink').click(function (event) {
                    event.preventDefault(); // Prevent default link behavior
                    const pageUrl = $(this).data('page-url');
                    loadPage(pageUrl);
                });

                function loadPage(pageUrl) {
                    $.ajax({
                        url: pageUrl,
                        type: 'GET',
                        success: function (response) {
                            $('#main-content').html(response); // Inject the loaded content into main content area
                        },
                        error: function (xhr, status, error) {
                            console.error('Error loading page:', error);
                            $('#main-content').html('<p>Failed to load the page.</p>');
                        }
                    });
                }
            });
        </script>

    </body> 
</html>
