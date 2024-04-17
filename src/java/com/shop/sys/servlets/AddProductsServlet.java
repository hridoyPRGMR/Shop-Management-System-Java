package com.shop.sys.servlets;

import com.sho.sys.helper.ConnectionProvider;
import com.sho.sys.helper.Helper;
import com.shop.sys.dao.ProductsDao;
import com.shop.sys.entities.Products;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;

@MultipartConfig
public class AddProductsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String pName=request.getParameter("productName");
            int cid=Integer.parseInt(request.getParameter("cid"));
            int uPrice=Integer.parseInt(request.getParameter("unitPrice"));
            int pCount=Integer.parseInt(request.getParameter("productCount"));
            String manufacturer=request.getParameter("manufacturer");
            String des=request.getParameter("shortDescription");
            
            Part part=request.getPart("productImage");
            String imageName=part.getSubmittedFileName();
            
            String img=pName+"_"+imageName;
            
            Products product=new Products(pName,img,uPrice,pCount,manufacturer,des,null,cid);
            ProductsDao apd=new ProductsDao(ConnectionProvider.getConnection());
            
            if(apd.AddProduct(product)){
                String realPath = request.getServletContext().getRealPath("/");
                String productImagePath = realPath + "Image" + File.separator + img;
                Helper.saveFile(part.getInputStream(), productImagePath);
                out.println("Product Added");
            }
            else{
                out.println("Not Submitted");
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
