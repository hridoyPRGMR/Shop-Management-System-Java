package com.shop.sys.dao;

import java.sql.Connection;
import java.sql.*;
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

    public boolean updateProduct(Products p) {
        boolean flag = false;
        try {
            
            String sql = "UPDATE products SET pname=?, pimg=?, unitprice=?, totalp=?, pcompany=?, pdes=?, cid=? WHERE pid=?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, p.getPname());
            pstmt.setString(2, p.getPimg());
            pstmt.setInt(3, p.getUnitprice());
            pstmt.setInt(4, p.getTotalp());
            pstmt.setString(5, p.getPcompany());
            pstmt.setString(6, p.getPdes());
            pstmt.setInt(7, p.getCid());
            pstmt.setInt(8, p.getPid());

            int rowAffected = pstmt.executeUpdate();

            flag = (rowAffected > 0);

            pstmt.close(); // Close PreparedStatement

        } catch (SQLException e) {
            // Handle SQL exceptions
            e.printStackTrace();
        } catch (Exception e) {
            // Handle other exceptions
            e.printStackTrace();
        }
        return flag;
    }

    public List<Products> getAllProducts() {

        List<Products> list = new ArrayList<>();

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

        try {
            String q = "SELECT * FROM products WHERE cid=? ORDER BY date ASC";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setInt(1, catId);
            ResultSet set = pstmt.executeQuery();

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

    public boolean deleteProductById(int productId) {
        boolean flag = false;

        try {

            String q = "DELETE FROM products WHERE pid=?";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setInt(1, productId);
            pstmt.executeUpdate();

            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public Products getProductByPid(int pid) {
        Products p = null;

        try {
            String q = "SELECT * FROM products WHERE pid=?";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setInt(1, pid);
            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                int productId = set.getInt("pid");
                String pname = set.getString("pname");
                String pimg = set.getString("pimg");
                int unitprice = set.getInt("unitprice");
                int pCount = set.getInt("totalp");
                String company = set.getString("pcompany");
                String pdes = set.getString("pdes");
                Timestamp date = set.getTimestamp("date");
                int cid = set.getInt("cid");

                p = new Products(productId, pname, pimg, unitprice, pCount, company, pdes, date, cid);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }
}
