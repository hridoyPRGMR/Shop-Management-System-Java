<%@page import="com.shop.sys.entities.Products"%>
<%@page import="com.shop.sys.dao.ProductsDao"%>
<%@page import="com.sho.sys.helper.ConnectionProvider"%>
<%@page import="com.shop.sys.entities.User"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<div class="row pt-4">
    <%  
        User user = (User) session.getAttribute("currentUser");
        if (user == null) { 
            return; 
        }

        try {
            ProductsDao pd = new ProductsDao(ConnectionProvider.getConnection());
            int cid = Integer.parseInt(request.getParameter("cid"));
            List<Products> products = null;

            if (cid == 0) {
                products = pd.getAllProducts();
            } else {
                products = pd.getProductsByCid(cid);
            }

            if (products == null || products.isEmpty()) {
                return; 
            }

            for (Products p : products) {
    %>
    
    <div class="col-md-4">
        <div class="card product-card">
            <img src="Image/<%= p.getPimg() %>" class="card-img-top" alt="Product Image">
            <div class="card-body">
                <h5 class="card-title"><%= p.getPname() %></h5>
                <div class="row">
                    <div class="col-md-6">
                        <p class="card-text"><strong>Price:</strong> <%= p.getUnitprice() %></p>
                        <p class="card-text"><strong>Available:</strong> <%= p.getTotalp() %></p>
                    </div>
                    <div class="col-md-6">
                        <p class="card-text"><strong>Company:</strong> <%= p.getPcompany() %></p>
                    </div>
                </div>
                <p class="card-text"><strong>Details:</strong> <%= p.getPdes() %></p>
                <!-- Additional information like available count can be added here -->
            </div>
            <div class="card-footer">
                <a href="#" class="btn btn-primary">Edit</a>
                <a href="#" class="btn btn-danger">Delete</a>
            </div>
        </div>
    </div>

    <%  
            }
        } catch (Exception e) {
            // Handle database connection or query execution errors
            e.printStackTrace(); // Log the exception for troubleshooting
            // Optionally display an error message or take appropriate action
        }
    %>
</div>
