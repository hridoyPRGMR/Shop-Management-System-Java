package com.shop.sys.entities;


public class Customer {
    private int cid;
    private String cname;
    private String email;
    private String phnone;
    private String password;

    public Customer() {
    }

    public Customer(int cid, String cname, String email, String phnone, String password) {
        this.cid = cid;
        this.cname = cname;
        this.email = email;
        this.phnone = phnone;
        this.password = password;
    }

    public Customer(String cname, String email, String phnone, String password) {
        this.cname = cname;
        this.email = email;
        this.phnone = phnone;
        this.password = password;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhnone() {
        return phnone;
    }

    public void setPhnone(String phnone) {
        this.phnone = phnone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    
    
}
