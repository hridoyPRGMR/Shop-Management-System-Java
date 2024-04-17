package com.shop.sys.entities;

public class Category {
    private int cid;
    private String cname;
    private String cdes;

    public Category() {
    }
    
    public Category(String cname, String cdes) {
        this.cname = cname;
        this.cdes = cdes;
    }
    
    public Category(int cid, String cname, String cdes) {
        this.cid = cid;
        this.cname = cname;
        this.cdes = cdes;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getCdes() {
        return cdes;
    }

    public void setCdes(String cdes) {
        this.cdes = cdes;
    }
    
}
