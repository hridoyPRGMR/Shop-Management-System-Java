package com.shop.sys.servlets;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sho.sys.helper.ConnectionProvider;
import com.shop.sys.dao.OrdersDao;
import com.shop.sys.dao.SellDetailsDao;
import com.shop.sys.entities.OrderDetails;
import java.io.BufferedReader;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import static java.lang.System.out;
import java.sql.Timestamp;

@WebServlet("/OrderConfirmServlet")
public class OrderConfirmServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        Map<String, Object> responseMap = new HashMap<>();
        
        try {
            // Read JSON data from request body
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            String jsonData = sb.toString();

            // Convert JSON data to Java objects
            Type type = new TypeToken<Map<String, List<OrderDetails>>>() {}.getType();
            Map<String, List<OrderDetails>> data = gson.fromJson(jsonData, type);

            List<OrderDetails> orderDetails = data.get("orderDetails");
            
            OrdersDao od=new OrdersDao(ConnectionProvider.getConnection());
            SellDetailsDao sd=new SellDetailsDao(ConnectionProvider.getConnection());
            
            //StringBuilder details = new StringBuilder();
            for (OrderDetails orderD : orderDetails) {
                int customerId=orderD.getCustomer().getCid();
                int productId=orderD.getProduct().getPid();
                int quantity=orderD.getQuantity();
                Timestamp date=orderD.getDate();
                od.deleteOrders(customerId, productId, date);
                sd.insertIntoSell(customerId,productId,quantity,date);
            }
            //System.out.println(details.toString());
            
            // Prepare success response
            responseMap.put("success", true);
            //responseMap.put("details", details.toString());
             
        } catch (Exception e) {
            // Handle errors and prepare error response
            responseMap.put("success", false);
            responseMap.put("message", e.getMessage());
        } finally {
            // Send JSON response
            response.getWriter().write(gson.toJson(responseMap));
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
        return "Order confirmation servlet";
    }
}
