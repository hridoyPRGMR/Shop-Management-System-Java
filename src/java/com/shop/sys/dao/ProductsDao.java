package com.shop.sys.dao;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import com.shop.sys.entities.Products;
import java.util.ArrayList;
import java.util.List;

public class ProductsDao {

    private Connection con;

    public ProductsDao() {
    }

    public ProductsDao(Connection con) {
        this.con = con;
    }

    public boolean AddProduct(Products product) {
        boolean flag = false;

        try {
            String q = "INSERT INTO products(pname,pimg,unitprice,totalp,pcompany,pdes,cid) VALUES(?,?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(q);

            ps.setString(1, product.getPname());
            ps.setString(2, product.getPimg());
            ps.setInt(3, product.getUnitprice());
            ps.setInt(4, product.getTotalp());
            ps.setString(5, product.getPcompany());
            ps.setString(6, product.getPdes());
            ps.setInt(7, product.getCid());

            ps.executeUpdate();
            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public List<Products>getAllProducts() {

        List<Products>list=new ArrayList<>();

        try {
            String q = "SELECT * FROM products ORDER BY date ASC";
            PreparedStatement pstmt = con.prepareStatement(q);
            ResultSet set = pstmt.executeQuery(q);

            while (set.next()) {
                int pid = set.getInt("pid");
                String pname = set.getString("pname");
                String pimg = set.getString("pimg");
                int unitprice = set.getInt("unitprice");
                int pCount = set.getInt("totalp");
                String company = set.getString("pcompany");
                String pdes = set.getString("pdes");
                Timestamp date = set.getTimestamp("date");
                int cid = set.getInt("cid");

                Products product = new Products(pid, pname, pimg, unitprice, pCount, company, pdes, date, cid);
                list.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Products> getProductsByCid(int catId) {
        List<Products> list = new ArrayList<>();
        
        try{
            String q="SELECT * FROM products WHERE cid=? ORDER BY date ASC";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setInt(1, catId);
            ResultSet set = pstmt.executeQuery();
            
            
            while(set.next()) {
                int pid = set.getInt("pid");
                String pname = set.getString("pname");
                String pimg = set.getString("pimg");
                int unitprice = set.getInt("unitprice");
                int pCount = set.getInt("totalp");
                String company = set.getString("pcompany");
                String pdes = set.getString("pdes");
                Timestamp date = set.getTimestamp("date");
                int cid = set.getInt("cid");

                Products product = new Products(pid, pname, pimg, unitprice, pCount, company, pdes, date, cid);
                list.add(product);
            }
            
        }
        catch(Exception e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    public boolean deleteProductById(int productId){
        boolean flag=false;
        
        try{
            
            String q="DELETE FROM products WHERE pid=?";
            PreparedStatement pstmt=con.prepareStatement(q);
            pstmt.setInt(1,productId);
            pstmt.executeUpdate();
            
            flag=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return flag;
    }
}
