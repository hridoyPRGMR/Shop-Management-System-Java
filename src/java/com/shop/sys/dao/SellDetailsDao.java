
package com.shop.sys.dao;
import com.sho.sys.helper.ConnectionProvider;
import com.shop.sys.entities.Customer;
import com.shop.sys.entities.OrderDetails;
import com.shop.sys.entities.Products;
import java.sql.*;
import java.util.*;


public class SellDetailsDao {
    private Connection con;

    public SellDetailsDao() {
    }

    public SellDetailsDao(Connection con) {
        this.con = con;
    }
    
    public boolean insertIntoSell(int customerId,int productId,int quantity,Timestamp date){
        boolean flag=false;

        try{
            String q="INSERT INTO selldetails(productid,customerid,quantity,date) VALUES(?,?,?,?)";
            PreparedStatement ps=con.prepareStatement(q);
            ps.setInt(1,productId);
            ps.setInt(2, customerId);
            ps.setInt(3, quantity);
            ps.setTimestamp(4, date);
            
            ps.executeUpdate();
            
            flag=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return flag;
    }
    
    public List<OrderDetails>getAllSellData(){
        List<OrderDetails>orderDetails=new ArrayList<>();
        
        try{
            String q="SELECT * FROM selldetails";
            PreparedStatement ps=con.prepareStatement(q);
            ResultSet res=ps.executeQuery();
            ProductsDao pd=new ProductsDao(ConnectionProvider.getConnection());
            UserDao ud=new UserDao(ConnectionProvider.getConnection());
            
            while(res.next()){
                int productid=res.getInt("productid");
                Products p=pd.getProductByPid(productid);
                int customerid=res.getInt("customerid");
                Customer c=ud.getCustomerById(customerid);
                int quantity=res.getInt("quantity");
                Timestamp date=res.getTimestamp("date");
                
                OrderDetails o=new OrderDetails(c,p,quantity,date);
                orderDetails.add(o);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return orderDetails;
    }
    
}
