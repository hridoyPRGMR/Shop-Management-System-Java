package com.shop.sys.servlets;

import com.sho.sys.helper.ConnectionProvider;
import com.shop.sys.dao.UserDao;
import com.shop.sys.entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class RegisterServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String name=request.getParameter("username");
            String email=request.getParameter("useremail");
            String password=request.getParameter("password");
            String repeatpassword=request.getParameter("repeatpassword");
            String agreeTerms=request.getParameter("agreeTerms");
            
            User user=new User(name,email,password);
            UserDao ud=new UserDao(ConnectionProvider.getConnection());
            
            
            if(agreeTerms!=null && agreeTerms.equals("true")){
                
                if(!password.equals(repeatpassword)){
                    response.sendRedirect("Register.jsp?error=password_mismatch");
                }
                else{

                    if(ud.saveUser(user)){
                        out.println("Registered");
                    }
                    else{
                        out.println("error! not Registered");
                    }
                }
            }
            else{
               out.println("You have to agree to terms and conditions");
            }
            ConnectionProvider.closeConnection();
 
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
