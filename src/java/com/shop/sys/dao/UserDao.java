package com.shop.sys.dao;

import com.shop.sys.entities.Customer;
import com.shop.sys.entities.User;
import java.sql.*;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    public boolean saveUser(User user) {
        boolean flag = false;

        try {
            String q = "INSERT INTO user(username,useremail,userpassword) VALUES(?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(q);

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.executeUpdate();

            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public User getUserByEmailPassword(String email, String password) {
        User user = null;

        try {
            String q = "SELECT * FROM user WHERE useremail=? AND userpassword=?";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();

                user.setId(rs.getInt("userid"));
                user.setName(rs.getString("username"));
                user.setEmail(rs.getString("useremail"));
                user.setPassword(rs.getString("userpassword"));
                user.setProfile(rs.getString("userimg"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean saveCustomer(Customer c) {
        boolean flag = false;

        try {
            String q = "INSERT INTO customers(cname,cemail,cphone,address,cpassword) VALUES(?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, c.getCname());
            pstmt.setString(2, c.getEmail());
            pstmt.setString(3, c.getPhnone());
            pstmt.setString(4,c.getAddress());
            pstmt.setString(5, c.getPassword());
            
            pstmt.executeUpdate();
            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public Customer getCustomerByEmailPassword(String email, String password) {
        Customer customer = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        try {
            String query = "SELECT * FROM customers WHERE cemail=? AND cpassword=?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            res = ps.executeQuery();

            if (res.next()) {
                customer = new Customer();
                customer.setCid(res.getInt("cid"));
                customer.setCname(res.getString("cname"));
                customer.setEmail(res.getString("cemail"));
                customer.setPhnone(res.getString("cphone")); 
                customer.setPassword(res.getString("cpassword"));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Better to log the exception
            // Throw a custom exception or handle the error as needed
        } 
        return customer;
    }
    
    public Customer getCustomerById(int id){
        Customer customer=null;
        
        try{
            String q="SELECT * FROM customers WHERE cid=?";
            PreparedStatement ps=con.prepareStatement(q);
            ps.setInt(1, id);
            ResultSet res=ps.executeQuery();
            
            if(res.next()){
                customer = new Customer();
                customer.setCid(res.getInt("cid"));
                customer.setCname(res.getString("cname"));
                customer.setEmail(res.getString("cemail"));
                customer.setPhnone(res.getString("cphone"));
                customer.setAddress(res.getString("address"));
                customer.setPassword(res.getString("cpassword"));
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return customer;
    }

}
