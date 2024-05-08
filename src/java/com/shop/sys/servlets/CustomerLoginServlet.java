
package com.shop.sys.servlets;

import com.sho.sys.helper.ConnectionProvider;
import com.shop.sys.dao.UserDao;
import com.shop.sys.entities.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CustomerLoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           String email=request.getParameter("email");
           String password=request.getParameter("password");
           
           UserDao ud=new UserDao(ConnectionProvider.getConnection());
           Customer customer=ud.getCustomerByEmailPassword(email,password);
           
           
           
           if(customer!=null){
               HttpSession session=request.getSession();
               session.setAttribute("currentCustomer", customer);
               out.println("loginOk");
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
    }// </editor-fold>

}
