
package com.shop.sys.servlets;

import com.sho.sys.helper.ConnectionProvider;
import com.shop.sys.dao.ProductsDao;
import com.shop.sys.entities.Customer;
import com.shop.sys.entities.Products;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class AddToCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
//            out.println("addtocartservlet");
            HttpSession session=request.getSession();
            Customer customer=(Customer)session.getAttribute("currentCustomer");
            if(customer==null)return;
            
            
            List<Products> cart = (List<Products>) session.getAttribute("cart");
            if(cart==null){
                cart=new ArrayList<>();
                session.setAttribute("cart", cart);
            }
            
            Map<Integer,Integer>productFreq=(Map<Integer,Integer>)session.getAttribute("productFreq");
            if(productFreq==null){
                productFreq=new HashMap<>();
                session.setAttribute("productFreq", productFreq);
            }
            
            int customerId=Integer.parseInt(request.getParameter("customerId"));
            int productId=Integer.parseInt(request.getParameter("productId"));
            
            ProductsDao pd=new ProductsDao(ConnectionProvider.getConnection());
            Products product=pd.getProductByPid(productId);
            
            if(!productFreq.containsKey(productId)){
                cart.add(product);
                out.println("addedtocart");
                productFreq.put(productId,1);
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
