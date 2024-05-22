
package com.shop.sys.entities;

import java.sql.Timestamp;

public class OrderDetails {
    private Customer customer;
    private Products product;
    private int quantity;
    private Timestamp date;

    public OrderDetails() {
    }

    public OrderDetails(Customer customer, Products product, int quantity,Timestamp date) {
        this.customer = customer;
        this.product = product;
        this.quantity = quantity;
        this.date=date;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
    
    
}
