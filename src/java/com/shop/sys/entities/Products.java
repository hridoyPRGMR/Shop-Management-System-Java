package com.shop.sys.entities;
import java.sql.Timestamp;

public class Products {
    private int pid;
    private String pname;
    private String pimg;
    private int unitprice;
    private int totalp;
    private String pcompany;
    private String pdes;
    private Timestamp date;
    private int cid;

    public Products() {
    }

    public Products(String pname, String pimg, int unitprice, int totalp, String pcompany, String pdes, Timestamp date, int cid) {
        this.pname = pname;
        this.pimg = pimg;
        this.unitprice = unitprice;
        this.totalp = totalp;
        this.pcompany = pcompany;
        this.pdes = pdes;
        this.date = date;
        this.cid = cid;
    }

    public Products(int pid, String pname, String pimg, int unitprice, int totalp, String pcompany, String pdes, Timestamp date, int cid) {
        this.pid = pid;
        this.pname = pname;
        this.pimg = pimg;
        this.unitprice = unitprice;
        this.totalp = totalp;
        this.pcompany = pcompany;
        this.pdes = pdes;
        this.date = date;
        this.cid = cid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getPimg() {
        return pimg;
    }

    public void setPimg(String pimg) {
        this.pimg = pimg;
    }

    public int getUnitprice() {
        return unitprice;
    }

    public void setUnitprice(int unitprice) {
        this.unitprice = unitprice;
    }

    public int getTotalp() {
        return totalp;
    }

    public void setTotalp(int totalp) {
        this.totalp = totalp;
    }

    public String getPcompany() {
        return pcompany;
    }

    public void setPcompany(String pcompany) {
        this.pcompany = pcompany;
    }

    public String getPdes() {
        return pdes;
    }

    public void setPdes(String pdes) {
        this.pdes = pdes;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }
    
    
}
