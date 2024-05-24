
package com.shop.sys.entities;

import java.security.Timestamp;

public class Orders {
    private int orderId;
    private int customerId;
    private int productId;
    private int quantity;
    private Timestamp orderDate;
    private String status;
    
    public Orders(){
        
    }

    public Orders(int orderId, int customerId, int productId, int quantity, Timestamp orderDate) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.productId = productId;
        this.quantity = quantity;
        this.orderDate = orderDate;
    }

    public Orders(int customerId, int productId, int quantity, Timestamp orderDate) {
        this.customerId = customerId;
        this.productId = productId;
        this.quantity = quantity;
        this.orderDate = orderDate;
    }

    public Orders(int productId, int quantity,String status) {
        this.productId = productId;
        this.quantity = quantity;
        this.status = status;
    }
    
    

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
    
}
