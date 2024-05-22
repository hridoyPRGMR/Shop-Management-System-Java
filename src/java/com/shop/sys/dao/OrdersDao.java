package com.shop.sys.dao;

import com.sho.sys.helper.ConnectionProvider;
import com.shop.sys.entities.Customer;
import com.shop.sys.entities.Orders;
import com.shop.sys.entities.OrderDetails;
import com.shop.sys.entities.Products;
import java.sql.Connection;
import java.sql.*;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Set;

public class OrdersDao {

    private Connection con;

    public OrdersDao() {
    }

    public OrdersDao(Connection con) {
        this.con = con;
    }

    public boolean saveOrders(Orders order) {
        boolean flag = false;

        try {
            String q = "INSERT INTO orders(customerid,productid,quantity) VALUES(?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setInt(1, order.getCustomerId());
            pstmt.setInt(2, order.getProductId());
            pstmt.setInt(3, order.getQuantity());

            pstmt.executeUpdate();
            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public void getOrderDetails() {
        OrderDetails orderDetails = null;

        Map<Integer, Integer> mp = new HashMap<>();
    }

    public Set<Timestamp> getOrderDates() {
        Set<Timestamp> orderDate = new HashSet<>();
        
        
        try {
            String q = "SELECT orderdate FROM orders";
            PreparedStatement ps = con.prepareStatement(q);
            ResultSet res = ps.executeQuery();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            
            while (res.next()) {
                Timestamp date = res.getTimestamp("orderdate");
                
                String formattedDateStr = dateFormat.format(date);
                Timestamp formattedDate = Timestamp.valueOf(formattedDateStr + " 00:00:00");
                
                orderDate.add(formattedDate);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderDate;
    }

    public Map<Integer,List<OrderDetails>>getOrderDetails(Timestamp startTimestamp,Timestamp endTimestamp) {
        
        Map<Integer,List<OrderDetails>>orderDetailsMap = new HashMap<>();
          
        try {
            
            String q="SELECT * FROM orders WHERE orderdate >= ? AND orderdate < ?";
            PreparedStatement ps=con.prepareStatement(q);
            ps.setTimestamp(1, startTimestamp);
            ps.setTimestamp(2, endTimestamp);

            ResultSet res=ps.executeQuery();
            
            ProductsDao pd=new ProductsDao(ConnectionProvider.getConnection());
            UserDao ud=new UserDao(ConnectionProvider.getConnection());
            Products p=null;
            Customer c=null;
            
            while(res.next()){
                int customerId=res.getInt("customerid");
                int productId=res.getInt("productid");
                int quantity=res.getInt("quantity");
                
                c=ud.getCustomerById(customerId);
                p=pd.getProductByPid(productId);
                
                OrderDetails od=new OrderDetails(c,p,quantity);
                
                if(orderDetailsMap.containsKey(customerId)){
                    orderDetailsMap.get(customerId).add(od);
                }
                else{
                    List<OrderDetails> orderList = new ArrayList<>();
                    orderList.add(od);
                    orderDetailsMap.put(customerId, orderList);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }

            return orderDetailsMap;
    }
}
