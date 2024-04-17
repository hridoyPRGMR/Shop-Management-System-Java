package com.sho.sys.helper;
import java.sql.*;

public class ConnectionProvider {
    private static Connection con;
    
    private ConnectionProvider(){
        
    }
    
    public static Connection getConnection(){
        try{
            if(con==null || con.isClosed()){
                Class.forName("com.mysql.jdbc.Driver");
                con=DriverManager.getConnection("jdbc:mysql://localhost:3306/shop", "root", "admin");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return con;
    }
    
    public static void closeConnection(){
        try{
            if(con !=null && !con.isClosed()){
                con.close();
                con=null;
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
}
