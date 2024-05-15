package com.shop.sys.dao;

import com.shop.sys.entities.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CategoryDao {
    private Connection con;

    public CategoryDao(Connection con) {
        this.con = con;
    }

    public boolean addCategory(Category category) {
        String query = "INSERT INTO productcategory(cname, cdes) VALUES (?, ?)";
        boolean isSuccess = false;

        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, category.getCname());
            ps.setString(2, category.getCdes());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            System.err.println("Error occurred while adding category: " + e.getMessage());
        }
        return isSuccess;
    }
    
    public ArrayList<Category>getCategory(){
        ArrayList<Category>list=new ArrayList<>();
        
        try{
            String q="SELECT * FROM productcategory";
            Statement st = con.createStatement();
            ResultSet set=st.executeQuery(q);
            
            while(set.next()){
                int cid=set.getInt("cid");
                String cname=set.getString("cname");
                String cdes=set.getString("cdes");
                Category category=new Category(cid,cname,cdes);
                list.add(category);
            }
            st.close();
            set.close();
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    public Category getCategoryByCid(int cid){
        Category category=null;
        
        try{
            String q="SELECT * FROM productcategory WHERE cid=?";
            PreparedStatement ps=con.prepareStatement(q);
            ps.setInt(1, cid);
            ResultSet rs=ps.executeQuery();
            
            if(rs.next()){
                String cname=rs.getString("cname");
                String cdes=rs.getString("cdes");
                category=new Category(cid,cname,cdes);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return category;
    }
}
