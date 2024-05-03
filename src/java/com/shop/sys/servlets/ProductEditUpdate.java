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

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 20 // 20MB
)
public class ProductEditUpdate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //out.println("update servlet");

            int pid = Integer.parseInt(request.getParameter("pid"));
            String pName = request.getParameter("productName");

            int cid = Integer.parseInt(request.getParameter("cid"));
            int uPrice = Integer.parseInt(request.getParameter("unitPrice"));
            int pCount = Integer.parseInt(request.getParameter("productCount"));
            String manufacturer = request.getParameter("manufacturer");
            String des = request.getParameter("shortDescription");
            String oldImg = request.getParameter("oldImg");
            
            Part part = request.getPart("productImage");
            String imgName = part.getSubmittedFileName();
            
            String img = (imgName == null || imgName.isEmpty()) ? oldImg : pName + "_" + imgName;

         
            
            Products p=new Products(pid,pName,img,uPrice,pCount,manufacturer,des,null,cid);
            ProductsDao pd=new ProductsDao(ConnectionProvider.getConnection());
            
            if(pd.updateProduct(p)){
                String realPath = request.getServletContext().getRealPath("/");
                String productImagePath = realPath + "Image" + File.separator + img;
                String oldImagePath = realPath + "Image" + File.separator + oldImg;
                
                Helper.deleteFile(oldImagePath);
                Helper.saveFile(part.getInputStream(),productImagePath);
                
                out.println("updated");
            }
            else{
                out.println("update error");
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
