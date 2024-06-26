<%@page import="com.sho.sys.helper.ConnectionProvider"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.shop.sys.entities.OrderDetails"%>
<%@page import="com.shop.sys.dao.OrdersDao"%>
<%@page import="com.shop.sys.dao.UserDao"%>
<%@page import="com.shop.sys.entities.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="com.shop.sys.entities.Products"%>
<%@page import="com.shop.sys.entities.Customer"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Timestamp"%>

<%@page import="com.google.gson.Gson"%>

<% 
Gson gson = new Gson();
%>

<%
    String date = request.getParameter("selectedDate");

    if (date == null || date.trim().isEmpty() || "0".equals(date)) {
        out.println("Please Select a Date to see the orders");
        return;
    }

    OrdersDao od = new OrdersDao(ConnectionProvider.getConnection());
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    Timestamp startTimestamp = null;
    Timestamp endTimestamp = null;

    try {
        Date parsedDate = dateFormat.parse(date);
        startTimestamp = new Timestamp(parsedDate.getTime());
        endTimestamp = new Timestamp(parsedDate.getTime() + (24 * 60 * 60 * 1000));
    } catch (ParseException e) {
        e.printStackTrace();
        out.println("Date parsing error: " + e.getMessage());
        return;
    }
    
    Map<Integer,List<OrderDetails>> orderDetailsMap = od.getOrderDetails(startTimestamp,endTimestamp);
    
    if (orderDetailsMap == null || orderDetailsMap.isEmpty()) {
        out.println("No orders found for the selected date.");
        return; 
    }

    out.println("Number of orders: " + orderDetailsMap.size());
    UserDao ud=new UserDao(ConnectionProvider.getConnection());
    
    for(Map.Entry<Integer,List<OrderDetails>>entry : orderDetailsMap.entrySet()){
        Integer customerId=entry.getKey();
        List<OrderDetails>orderDetails=entry.getValue();
%>

<ul class="list-group mt-3 w-100">
    <li class="list-group-item">
        <div class="d-flex justify-content-between align-items-center pb-2">
            <h3>Customer Name: <%=ud.getCustomerById(customerId).getCname()%></h3>
            <p class="p-1">Customer ID: <%=customerId%></p>
        </div>
        <div>
            <ul class="list-group">
                <%  
                    int totalPrice=0;
                    for(OrderDetails orderD:orderDetails){
                        Timestamp dateD=orderD.getDate();
                        int q=orderD.getQuantity();
                        int p=q*orderD.getProduct().getUnitprice();
                        int pid=orderD.getProduct().getPid();
                        int available=orderD.getProduct().getTotalp();
                        int cid=orderD.getCustomer().getCid();
                        totalPrice+=p;
                %>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <h5>Product Name: <%=orderD.getProduct().getPname()%></h5>
                    <h5>Product ID: <%=pid%></h5>
                    <img class="img-fluid" style="max-height: 50px;max-width: 50px" src="Image/<%=orderD.getProduct().getPimg()%>" alt="Product Image" />
                    <p>Quantity:<%=q%></p>
                    <h5>Price: <%=p%> </h5>
                    <h5>Available: <%=available%></h5>
                    <button type="button" value="<%=cid%>-<%=pid%>-<%=dateD%>" class="btn btn-outline-danger">Remove</button>
                </li>
                <%}%>
            </ul>
        </div>
        <div class="d-flex justify-content-between align-items-center mt-2 pb-2">
            <h5>Total Price: <%=totalPrice%></h5>
            <h5>Address:  <%=ud.getCustomerById(customerId).getAddress()%></h5>
        </div>
        <div class="d-grid gap-2 d-md-block">
            <button id="confirmOrderRequest" data-order-details='<%=gson.toJson(orderDetails)%>'
                    class="btn btn-primary confirmOrderRequest" type="button">Confirm Order Request</button>
        </div>
    </li>
</ul>
<%
    }
%>
