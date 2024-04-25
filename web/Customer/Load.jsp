
<%@ page import="com.shop.sys.entities.Products" %>
<%@ page import="com.shop.sys.dao.ProductsDao" %>
<%@ page import="com.sho.sys.helper.ConnectionProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*" %>

<div class="row justify-content-center">
    <%
        int catid = Integer.parseInt(request.getParameter("catid"));
//        out.println(catid);
        ProductsDao pd = new ProductsDao(ConnectionProvider.getConnection());
        List<Products> list=new ArrayList<>();
        
        if(catid==0){
            list=pd.getAllProducts();
        }
        else{
            list=pd.getProductsByCid(catid);
        }
        
        if (list.isEmpty()) return;

        for (Products p : list) {
    %>

    <div class="col-lg-3 pt-4 col-md-3 col-sm-3">
        <div class="card px-4 border shadow-0 mb mb-lg-0" style="justify-items: center">
            <div class="mask px-2" style="height: 50px;">
                <div class="d-flex justify-content-between">
                    <h6><span class="badge bg-danger pt-1 mt-3 ms-2">New</span></h6>
                    <a href="#"><i class="fas fa-heart text-primary fa-lg float-end pt-3 m-2"></i></a>
                </div>
            </div>
            <a href="#" class="">
                <img src="../Image/<%= p.getPimg() %>" class="card-img-top rounded-2" />
            </a>
            <div class="card-body d-flex flex-column pt-3 border-top">
                <a href="#" class="nav-link"><%=p.getPname().toUpperCase()%></a>
                <div class="price-wrap mb-2">
                    <strong class="">Price: <%=p.getUnitprice()%> $</strong>
                    <!--<del class="">$24.99</del>-->
                </div>
                <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                    <a href="#" class="btn btn-outline-primary w-100">Add to cart</a>
                </div>
            </div>
        </div>
    </div>

    <%}%>
</div>