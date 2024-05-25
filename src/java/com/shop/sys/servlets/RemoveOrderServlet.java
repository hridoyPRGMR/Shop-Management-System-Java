package com.shop.sys.servlets;

import com.sho.sys.helper.ConnectionProvider;
import com.shop.sys.dao.OrdersDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class RemoveOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            int cid = Integer.parseInt(request.getParameter("cid"));
            int pid = Integer.parseInt(request.getParameter("pid"));
            String dateString = request.getParameter("date");
            

            OrdersDao od = new OrdersDao(ConnectionProvider.getConnection());
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            java.util.Date parsedDate=null;
            try{
               parsedDate = dateFormat.parse(dateString);
            }catch(Exception e){
                e.printStackTrace();
            }
            Timestamp timestamp = new Timestamp(parsedDate.getTime());
            
            if(od.removeProduct(cid, pid, timestamp)){
                out.println("ok");
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
