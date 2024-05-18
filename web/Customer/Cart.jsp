<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shop.sys.entities.Products"%>
<%@page import="com.shop.sys.entities.Category"%>
<%@page import="com.shop.sys.entities.Customer"%>
<%@page import="com.shop.sys.dao.CategoryDao"%>
<%@page import="com.sho.sys.helper.ConnectionProvider"%>
<%@page import="java.util.List"%>

<%
    Customer customer = (Customer) session.getAttribute("currentCustomer");

    if (customer == null) return;

    CategoryDao cd = new CategoryDao(ConnectionProvider.getConnection());
    List<Products> cart = (List<Products>) session.getAttribute("cart");
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shopping Cart</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link href="cart.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <section class="h-100 h-custom">
            <div class="container px-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12">
                        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                            <div class="card-body p-0">
                                <div class="row g-0 custom">
                                    <div class="col-lg-8">
                                        <div class="p-5">
                                            <div class="d-flex justify-content-between align-items-center mb-5">
                                                <h1 class="fw-bold mb-0 text-black">Shopping Cart</h1>
                                                <% if (cart != null && cart.size() > 0) { %>
                                                <p><%= cart.size() %></p>
                                                <% } %>
                                            </div>
                                            <hr class="my-4">

                                            <% 
                                                int totalPrice = 0;
                                                if (cart != null && !cart.isEmpty()) {
                                                    for (Products product : cart) {
                                                        Category category = cd.getCategoryByCid(product.getCid());
                                            %>

                                            <div class="row mb-4 d-flex justify-content-between align-items-center cart-section"
                                                 id="cart-section">
                                                <input type="hidden" class="productId" value="<%=product.getPid()%>">
                                                <div class="col-md-2 col-lg-2 col-xl-2">
                                                    <img src="../Image/<%=product.getPimg()%>"
                                                         class="img-fluid rounded-3" alt="Product Image">
                                                </div>
                                                <div class="col-md-3 col-lg-3 col-xl-3">
                                                    <h6 class="text-muted"><%=category.getCname()%></h6>
                                                    <h6 class="text-black mb-0"><%=product.getPname()%></h6>
                                                </div>

                                                <div class="col-md-3 col-lg-3 col-xl-3 d-flex">
                                                    <input id="form1" min="0" name="quantity" value="1" type="number"
                                                           class="form-control form-control-sm quantity" /> 
                                                </div>

                                                <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                                                    <%totalPrice += product.getUnitprice();%>
                                                    <h6 class="mb-0 unit-price" data-unit-price="<%=product.getUnitprice()%>">Price per unit: <%=product.getUnitprice()%></h6>
                                                </div>
                                                <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                                    <a href="#!" value="<%=product.getPid()%>" class="text-muted removeProductFromCart"><i
                                                            class="fas fa-times"></i></a>
                                                </div>
                                                <hr class="my-4">
                                            </div>

                                            <% 
                                                }
                                                } else {
                                            %>
                                            <tr>
                                                <td colspan="3">Your cart is empty</td>
                                            </tr>
                                            <% } %>

                                            <div class="pt-5">
                                                <h6 class="mb-0"><a href="#!" class="text-body"><i
                                                            class="fas fa-long-arrow-alt-left me-2"></i>Back to shop</a>
                                                </h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 bg-grey">
                                        <div class="p-5">
                                            <h3 class="fw-bold mb-5 mt-2 pt-1">Summary</h3>
                                            <hr class="my-4">

                                            <div class="d-flex justify-content-between mb-4">
                                                <%if(cart!=null && cart.size()>0){%>
                                                <h5 class="text-uppercase">items <%=cart.size()%></h5>
                                                <%}else{%>
                                                <h5 class="text-uppercase">items 0</h5>
                                                <%}%>
                                                <h5> <span class="total-price"><%=totalPrice%></span></h5>
                                            </div>

                                            <h5 class="text-uppercase mb-3">Shipping</h5>

                                            <div class="mb-4 pb-2">
                                                <select data-mdb-select-init>
                                                    <option value="1">Standard-Delivery- $10.00</option>

                                                </select>
                                            </div>

                                            <hr class="my-4">

                                            <div class="d-flex justify-content-between mb-5">
                                                <h5 class="text-uppercase">Total price</h5>
                                                <h5> <span class="total-price"><%=totalPrice+10%></span></h5>
                                            </div>

                                            <button type="button" id="order"
                                                    class="btn btn-dark btn-block btn-lg" data-mdb-ripple-color="dark">Order</button>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/36faa4be31.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const quantityInputs = document.querySelectorAll('.quantity');
                const rmvPrFromCart = document.querySelectorAll('.removeProductFromCart');
                const orderButton = document.getElementById('order');

                quantityInputs.forEach(input => {
                    input.addEventListener('input', updateTotalPrice);
                });

                rmvPrFromCart.forEach(remove => {
                    remove.addEventListener('click', function (e) {
                        e.preventDefault();
                        const productId = remove.getAttribute('value');

                        fetch(`/ShopManagementSystem/RemoveFromCartServlet?productId=${productId}`, {
                            method: 'POST'
                        })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error('Network Response Was Not ok');
                                    }
                                    return response.text();
                                })
                                .then(data => {
                                    const cartSection = remove.closest('.cart-section');
                                    if (cartSection) {
                                        cartSection.innerHTML = data;
                                        window.location.reload();
                                        updateTotalPrice();
                                    } else {
                                        console.error('Cart section not found');
                                    }
                                })
                                .catch(error => {
                                    console.error('There was a problem with the fetch operation:', error);
                                });
                    });
                });

                orderButton.addEventListener('click', function (e) {
                    e.preventDefault();

                    Swal.fire({
                        title: "Are you sure!",
                        showDenyButton: true,
                        confirmButtonText: "Yes! Confirm",
                        denyButtonText: "Cancel It"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            placeOrder();
                        } else if (result.isDenied) {
                            Swal.fire("Order cancelled", "", "info");
                        }
                    });
                });

                function placeOrder() {
                    const customerId = '<%=customer.getCid()%>';
                    const formData = new FormData();
                    formData.append('customerId', customerId);

                    const productRows = document.querySelectorAll('.cart-section');
                    productRows.forEach(row => {
                        const productId = row.querySelector('.productId').value;
                        const quantity = parseInt(row.querySelector('.quantity').value, 10);
                        formData.append('productId[]', productId);
                        formData.append('quantity[]', quantity);
                    });

                    const urlEncodedData = new URLSearchParams(formData);

                    fetch('/ShopManagementSystem/CustomerOrderServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: urlEncodedData.toString()
                    })
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error('Network response was not ok');
                                }
                                return response.text();
                            })
                            .then(data => {
                                productRows.forEach(row => {
                                    row.querySelector('.quantity').value = '';
                                });
                                Swal.fire({
                                    position: "top",
                                    icon: "success",
                                    title: "Ordered placed successfully",
                                    showConfirmButton: false,
                                    timer: 1500
                                });
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1500);
                            })
                            .catch(error => {
                                console.error('There was a problem with the fetch operation:', error);
                            });
                }

                function updateTotalPrice() {
                    const quantityInputs = document.querySelectorAll('.quantity');
                    let totalPrice = 0;
                    quantityInputs.forEach(input => {
                        const quantity = parseInt(input.value, 10);
                        const unitPrice = parseFloat(input.closest('.cart-section').querySelector('.unit-price').dataset.unitPrice);
                        totalPrice += quantity * unitPrice;
                    });
                    document.querySelectorAll('.total-price').forEach(element => {
                        element.textContent = '$' + (totalPrice + 10);
                    });
                }
            });
        </script>

    </body>

</html>
