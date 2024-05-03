<%@page import="com.shop.sys.entities.Products"%>
<%@page import="com.shop.sys.dao.CategoryDao"%>
<%@page import="com.shop.sys.dao.ProductsDao"%>
<%@page import="com.shop.sys.entities.Category"%>
<%@page import="com.shop.sys.entities.User"%>
<%@page import="com.sho.sys.helper.ConnectionProvider"%>
<%@page import="java.util.ArrayList"%>

<%
    Products p=(Products)request.getAttribute("product");
    if(p!=null){
%>

<form id="editProductForm">
    <input type="text" name="pid" style="display:none" value="<%=p.getPid()%>">
    <div class="form-group">
        <label for="productName">Product Name</label>
        <input type="text" class="form-control" id="productNameInput" name="productName" placeholder="Enter product name" value="<%=p.getPname()%>">
    </div>
    
    <div class="form-group">
        <img class="img-fluid" id="currProductImg" src="Image/<%=p.getPimg()%>" style="max-width: 120px">
    </div>
    <input type="hidden" id="oldImg" name="oldImg" value="<%=p.getPimg()%>">
    <div class="form-group">
        <label>Select Product Image</label>
        <input id="productImageInput" name="productImage" type="file"> 
    </div>
    <div class="form-group">
        <label for="productCategory">Product Category</label>
        <select class="form-control" id="productCategorySelect" name="cid" required>
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
            <label  for="unitPrice">Unit Price ($)</label>
            <input type="number" class="form-control" id="unitPriceInput" name="unitPrice" placeholder="Enter unit price" value="<%=p.getUnitprice()%>">
        </div>
        <div class="form-group col-md-6">
            <label for="productCount">Product Count</label>
            <input type="number" class="form-control" id="productCountInput" name="productCount" placeholder="Enter product count" value="<%=p.getTotalp()%>">
        </div>
    </div>
    <div class="form-group">
        <label for="manufacturer">Manufacturer</label>
        <input type="text" class="form-control" id="manufacturerInput" name="manufacturer" placeholder="Enter manufacturer name" value="<%=p.getPcompany()%>">
    </div>
    <div class="form-group">
        <label for="shortDescription">Short Description</label>
        <textarea class="form-control" id="shortDescriptionInput" name="shortDescription" rows="3" placeholder="Enter short description"><%=p.getPdes()%></textarea>

    </div>
    <button type="submit" id="submitButton" class="btn btn-primary btn-block">Save Changes</button>
</form>
        
<%}%>

