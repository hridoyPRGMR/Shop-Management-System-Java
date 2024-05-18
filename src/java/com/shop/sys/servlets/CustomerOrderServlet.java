package com.shop.sys.servlets;

import com.sho.sys.helper.ConnectionProvider;
import com.shop.sys.dao.OrdersDao;
import com.shop.sys.entities.Orders;
import com.shop.sys.entities.Products;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

public class CustomerOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session=request.getSession();
            
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            out.println(customerId + " order");

            String[] productIds = request.getParameterValues("productId[]");
            String[] quantities = request.getParameterValues("quantity[]");

            // Process each product
            OrdersDao od=new OrdersDao(ConnectionProvider.getConnection());
            boolean flag=false;
            
            if (productIds != null && quantities != null && productIds.length == quantities.length) {
                for (int i = 0; i < productIds.length; i++) {
                    int productId = Integer.parseInt(productIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);
                    
                    Orders order=new Orders(customerId,productId,quantity,null);
                    if(od.saveOrders(order)){
                         flag=true; 
                    }
                }
            }
            
            if(flag){
                List<Products> cart = (List<Products>) session.getAttribute("cart");
                Map<Integer,Integer>productFreq=(Map<Integer,Integer>)session.getAttribute("productFreq");
                
                cart.clear();
                productFreq.clear();
                
                response.sendRedirect("Customer/CustomerHome.jsp");
                
                out.println("order placed");
            }

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
