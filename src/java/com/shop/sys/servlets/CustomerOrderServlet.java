package com.shop.sys.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Enumeration;

public class CustomerOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            out.println(customerId + " order");

            String[] productIds = request.getParameterValues("productId[]");
            String[] quantities = request.getParameterValues("quantity[]");

            // Process each product
            if (productIds != null && quantities != null && productIds.length == quantities.length) {
                for (int i = 0; i < productIds.length; i++) {
                    int productId = Integer.parseInt(productIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);
                    
                    out.println(productId+" "+quantity);
                    
                    // Process the product with ID productId and quantity quantity
                    // For example, you might add the product to the customer's order
                }
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
