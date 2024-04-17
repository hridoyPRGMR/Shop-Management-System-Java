package com.shop.sys.dao;
import com.shop.sys.entities.User;
import java.sql.*;

public class UserDao {
    private Connection con;
    
    public UserDao(Connection con){
        this.con=con;
    }
    
    /**
     *
     * @param user
     * @return
     */
    public boolean saveUser(User user){
        boolean flag=false;
        
        try{
            String q="INSERT INTO user(username,useremail,userpassword) VALUES(?,?,?)";
            PreparedStatement pstmt=this.con.prepareStatement(q);
            
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.executeUpdate();
            
            flag=true;
                    
        }catch(Exception e){
            e.printStackTrace();
        }
 
        return flag;
    }
    
    public User getUserByEmailPassword(String email,String password){
        User user=null;
        
        try{
            String q="SELECT * FROM user WHERE useremail=? AND userpassword=?";
            PreparedStatement pstmt=con.prepareStatement(q);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            ResultSet rs=pstmt.executeQuery();
            
            if(rs.next()){
                user=new User();
                
                user.setId(rs.getInt("userid"));
                user.setName(rs.getString("username"));
                user.setEmail(rs.getString("useremail"));
                user.setPassword(rs.getString("userpassword"));
                user.setProfile(rs.getString("userimg"));
            }
                    
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return user;
    }
    
}
