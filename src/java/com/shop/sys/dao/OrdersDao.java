
package com.shop.sys.dao;

import com.shop.sys.entities.Orders;
import java.sql.Connection;
import java.sql.*;



public class OrdersDao {
    private Connection con;

    public OrdersDao() {
    }
    
    public OrdersDao(Connection con) {
        this.con = con;
    }
    
    public boolean saveOrders(Orders order){
        boolean flag=false;
        
        try{
            String q="INSERT INTO orders(customerid,productid,quantity) VALUES(?,?,?)";
            PreparedStatement pstmt=con.prepareStatement(q);
            pstmt.setInt(1, order.getCustomerId());
            pstmt.setInt(2, order.getProductId());
            pstmt.setInt(3, order.getQuantity());
            
            pstmt.executeUpdate();
            flag=true;
                   
        }
        catch(Exception e){
            e.printStackTrace();
        }
        
        return flag;
    }
}
