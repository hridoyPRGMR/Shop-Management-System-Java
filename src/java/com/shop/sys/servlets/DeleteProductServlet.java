package com.shop.sys.servlets;

import com.sho.sys.helper.ConnectionProvider;
import com.sho.sys.helper.Helper;
import com.shop.sys.dao.ProductsDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;

public class DeleteProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String imgSrc = request.getParameter("imgSrc");
            ProductsDao pd = new ProductsDao(ConnectionProvider.getConnection());

            String realPath = request.getServletContext().getRealPath("/");
            String productImagePath= realPath + "Image" + File.separator + imgSrc;

            Helper.deleteFile(productImagePath);

            if (pd.deleteProductById(productId)) {
                out.println("ok");
            } else {
                out.println("eroor");
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
