

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Beautiful Dashboard</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
        <style>
            /* Custom styles (optional) */
            body {
                background-color: #f8f9fc;
            }

            .topbar {
                background-color: #ffffff;
            }

            .topbar .search-input {
                width: 300px;
            }

            .card {
                border: none;
                transition: transform 0.3s ease;
            }

            .card:hover {
                transform: translateY(-5px);
            }
        </style>
    </head>

    <body>

        <div id="content">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white topbar static-top shadow">
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>
                <form class="form-inline my-2 my-lg-0 ml-auto">
                    <input class="form-control search-input" type="search" placeholder="Search for..." aria-label="Search">
                    <button class="btn btn-primary my-2 my-sm-0 ml-2" type="submit"><i class="fas fa-search"></i></button>
                </form>
            </nav>
            <!-- End of Topbar -->

            <!-- Begin Page Content -->
            <div class="container-fluid pt-4">

                <!-- Page Heading -->
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
                    <a href="#" class="btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
                </div>

                <!-- Content Row -->
                <div class="row">

                    <!-- Earnings (Monthly) Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-primary text-white shadow">
                            <div class="card-body">
                                Earnings (Monthly)
                                <div class="text-white-50 mt-2">$40,000</div>
                            </div>
                        </div>
                    </div>

                    <!-- Earnings (Annual) Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-success text-white shadow">
                            <div class="card-body">
                                Earnings (Annual)
                                <div class="text-white-50 mt-2">$215,000</div>
                            </div>
                        </div>
                    </div>

                    <!-- Tasks Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-info text-white shadow">
                            <div class="card-body">
                                Tasks
                                <div class="text-white-50 mt-2">50% Complete</div>
                            </div>
                        </div>
                    </div>

                    <!-- Pending Requests Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-warning text-white shadow">
                            <div class="card-body">
                                Pending Requests
                                <div class="text-white-50 mt-2">18</div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.row -->

                <!-- Content Row -->
                <div class="row">

                    <!-- Area Chart -->
                    <div class="col-xl-8 col-lg-7 mb-4">
                        <div class="card shadow">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Top Selling Product</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <img src="#" class="img-fluid" alt="Product Image">
                                    </div>
                                    <div class="col-md-8">
                                        <h5 class="font-weight-bold mb-3">Product Name</h5>
                                        <p>Description of the product goes here. This could include details about features, benefits, etc.</p>
                                        <p><strong>Price:</strong> $XX.XX</p>
                                        <p><strong>Units Sold:</strong> XXX</p>
                                        <!-- Add more relevant information as needed -->
                                        <a href="#" class="btn btn-primary">View Product Details</a>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>


                    <!-- Pie Chart -->
                    <div class="col-xl-4 col-lg-5 mb-4">
                        <div class="card shadow">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Revenue Sources</h6>
                            </div>
                            <div class="card-body">
                                <!-- Pie Chart Canvas (replace with your chart) -->
                                <canvas id="myPieChart" width="100%" height="40"></canvas>
                                <!-- Legend -->
                                <div class="mt-4 text-center small">
                                    <span class="mr-2">
                                        <i class="fas fa-circle text-primary"></i> Direct
                                    </span>
                                    <span class="mr-2">
                                        <i class="fas fa-circle text-success"></i> Social
                                    </span>
                                    <span class="mr-2">
                                        <i class="fas fa-circle text-info"></i> Referral
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>



       
    </body>

</html>
