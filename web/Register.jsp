<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link href="CSS/login.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        
        <div class="container">
            <section class="vh-100">
                <div class="container h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col-lg-12 col-xl-11">
                            <div class="card text-black" style="border-radius: 25px;">
                                <div class="card-body p-md-8">
                                    <div class="row justify-content-center">
                                        <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">
                                            <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Sign up</p>
                                            <form class="mx-1 mx-md-4" method="POST" id="reg-form">
                                                <div class="d-flex flex-row align-items-center mb-4">
                                                    <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                                    <div data-mdb-input-init class="form-outline flex-fill mb-0">
                                                        <input type="text" id="username" class="form-control" name="username" required>
                                                        <label class="form-label" for="username">Your Name</label>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-row align-items-center mb-4">
                                                    <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                                                    <div data-mdb-input-init class="form-outline flex-fill mb-0">
                                                        <input type="email" id="useremail" class="form-control" name="useremail" required>
                                                        <label class="form-label" for="useremail">Your Email</label>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-row align-items-center mb-4">
                                                    <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
                                                    <div data-mdb-input-init class="form-outline flex-fill mb-0">
                                                        <input type="password" id="password" class="form-control" name="password" required>
                                                        <label class="form-label" for="password">Password</label>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-row align-items-center mb-4">
                                                    <i class="fas fa-key fa-lg me-3 fa-fw"></i>
                                                    <div data-mdb-input-init class="form-outline flex-fill mb-0">
                                                        <input type="password" id="repeatpassword" class="form-control" name="repeatpassword" required>
                                                        <label class="form-label" for="repeatpassword">Repeat your password</label>
                                                    </div>
                                                    <div id="passwordNotMatch" class="mb-1" style="display: none; color: red;">Passwords don't match</div>
                                                </div>
                                                <div class="form-check d-flex justify-content-center mb-5">
                                                    <input class="form-check-input me-2" type="checkbox" value="true" name="agreeTerms" id="checkBox" required>
                                                    <label class="form-check-label" for="checkBox">
                                                        I agree all statements in <a href="#!">Terms of service</a>
                                                    </label>
                                                </div>
                                                <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                                    <button type="submit" class="btn btn-primary btn-lg gradient-custom-2" id="submit-btn">Register</button>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
                                            <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp" class="img-fluid" alt="Sample image">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        
        
        <script>

            $(document).ready(function () {
                $('#reg-form').submit(function (event) {
                    event.preventDefault();

                    var formData = {
                        username: $('#username').val(),
                        useremail: $('#useremail').val(),
                        password: $('#password').val(),
                        repeatpassword: $('#repeatpassword').val(),
                        agreeTerms: $('#checkBox').is(':checked')
                    };

                    // Example validation (check if password matches repeat password)
                    if (formData.password !== formData.repeatpassword) {
                        $('#passwordNotMatch').show();
                        return;
                    }

                    // Submit form data via AJAX
                    $.ajax({
                        url: 'RegisterServlet', // Adjust the URL according to your servlet endpoint
                        type: 'POST',
                        data: formData,
                        success: function (data) {
                            if (data.trim() === 'Registered') {
                                swal({
                                    title: 'Good job!',
                                    text: 'Registration successful!',
                                    icon: 'success',
                                    button: 'Login Page'
                                }).then((value) => {
                                    if (value) {
                                        window.location.href = 'Login.jsp'; // Redirect to login page
                                    }
                                });
                            } else {
                                swal(data); // Display server response
                            }
                        },
                        error: function () {
                            swal('Something went wrong, please try again.');
                        }
                    });
                });
            });
        </script>
    </body>
</html>
