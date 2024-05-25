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
import java.sql.Date;

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
        PreparedStatement pstmt;
        try {
            String q = "INSERT INTO orders(customerid,productid,quantity) VALUES(?,?,?)";
            pstmt = con.prepareStatement(q);
            pstmt.setInt(1, order.getCustomerId());
            pstmt.setInt(2, order.getProductId());
            pstmt.setInt(3, order.getQuantity());

            pstmt.executeUpdate();

            String q2 = "INSERT INTO confirmorder(customerid,productid,quantity) VALUES(?,?,?)";
            pstmt = con.prepareStatement(q2);
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

    public Map<Integer, List<OrderDetails>> getOrderDetails(Timestamp startTimestamp, Timestamp endTimestamp) {

        Map<Integer, List<OrderDetails>> orderDetailsMap = new HashMap<>();

        try {

            String q = "SELECT * FROM orders WHERE orderdate >= ? AND orderdate < ?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setTimestamp(1, startTimestamp);
            ps.setTimestamp(2, endTimestamp);

            ResultSet res = ps.executeQuery();

            ProductsDao pd = new ProductsDao(ConnectionProvider.getConnection());
            UserDao ud = new UserDao(ConnectionProvider.getConnection());
            Products p = null;
            Customer c = null;

            while (res.next()) {
                int customerId = res.getInt("customerid");
                int productId = res.getInt("productid");
                int quantity = res.getInt("quantity");
                Timestamp date = res.getTimestamp("orderdate");

                c = ud.getCustomerById(customerId);
                p = pd.getProductByPid(productId);

                OrderDetails od = new OrderDetails(c, p, quantity, date);

                if (orderDetailsMap.containsKey(customerId)) {
                    orderDetailsMap.get(customerId).add(od);
                } else {
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

    public boolean deleteOrders(int customerId, int productId, Timestamp date) {
        boolean flag = false;
        PreparedStatement ps = null;

        try {
            String q = "DELETE FROM orders WHERE customerid=? AND productid=? AND DATE_FORMAT(orderdate, '%Y-%m-%d %H:%i:%s') = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            ps.setString(3, date.toString().substring(0, 19));

            //System.out.println(date);
            ps.executeUpdate();

            String q2 = "UPDATE confirmorder SET status=? WHERE customerid=? AND productid=? AND DATE(date) = DATE(?)";
            ps = con.prepareStatement(q2);
            ps.setString(1, "confirm");
            ps.setInt(2, customerId);
            ps.setInt(3, productId);
            ps.setTimestamp(4, date);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                flag = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        return flag;
    }

    public List<Orders> getOrdersByCid(int cid) {
        List<Orders> orders = new ArrayList<>();
        PreparedStatement ps = null;

        try {
            String q = "SELECT * FROM confirmorder WHERE customerid=?";
            ps = con.prepareStatement(q);
            ps.setInt(1, cid);

            ResultSet res = ps.executeQuery();

            while (res.next()) {
                int productid = res.getInt("productid");
                int quantity = res.getInt("quantity");
                String status = res.getString("status");
                Orders o = new Orders(productid, quantity, status);
                orders.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        return orders;
    }
    
    public boolean removeProduct(int cid,int pid,Timestamp date){
        boolean flag=false;
        PreparedStatement ps=null;
        
        try{
            String q="DELETE FROM orders WHERE customerid=? and productid=? and DATE(orderdate) = DATE(?)";
            ps=con.prepareStatement(q);
            ps.setInt(1, cid);
            ps.setInt(2,pid);
            ps.setTimestamp(3, date);
            
            ps.executeUpdate();
            
            String q2 = "UPDATE confirmorder SET status=? WHERE customerid=? AND productid=? AND DATE(date) = DATE(?)";
            ps = con.prepareStatement(q2);
            ps.setString(1, "cancel");
            ps.setInt(2, cid);
            ps.setInt(3, pid);
            ps.setTimestamp(4,date);
            ps.executeUpdate();
            
            flag=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        finally{
            if(ps!=null){
                try{
                    ps.close();
                }catch(Exception e){
                    e.printStackTrace();
                }
            }
        }
        
        return flag;
    }
    
}
