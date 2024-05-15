
package com.shop.sys.servlets;

import com.shop.sys.entities.Products;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Iterator;
import java.util.Map;

public class RemoveFromCartServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session=request.getSession();
            
            int productId=Integer.parseInt(request.getParameter("productId"));
            List<Products>cart=(List<Products>)session.getAttribute("cart");
            Map<Integer,Integer>productFreq=(Map<Integer,Integer>)session.getAttribute("productFreq");
            
            if(cart!=null && productFreq!=null){
                Iterator<Products> it=cart.iterator();
                
                while(it.hasNext()){
                    Products product=it.next();
                    if(product.getPid()==productId){
                        it.remove();
                        productFreq.remove(productId);
                    }
                }
            }
            
            //out.println("remove cart "+productId);
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
