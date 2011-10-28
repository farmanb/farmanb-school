package com.princeton;

import java.io.Serializable;

/**
 * A simple, serializable class used to test the Coherence cache.
 */
public class Order implements Serializable{
    
    /*Constructors*/
    public Order() {
        super();
    }

    public Order(Integer orderID, Integer customerID) {
        super();
        this.orderID = orderID;
        this.customerID = customerID;
    }


    /*Accessors*/
    public void setOrderID(Integer orderID) {
        this.orderID = orderID;
    }

    public Integer getOrderID() {
        return orderID;
    }

    public void setCustomerID(Integer customerID) {
        this.customerID = customerID;
    }

    public Integer getCustomerID() {
        return customerID;
    }
    
    /*Functions*/
    @Override
    public String toString(){
        return "Order #: " + this.getOrderID() + "\n" + 
            "Customer #: " + this.getCustomerID();
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) {
            return true;
        }
        if (!(object instanceof Order)) {
            return false;
        }
        final Order other = (Order)object;
        if (!(orderID == null ? other.orderID == null : orderID.equals(other.orderID))) {
            return false;
        }
        if (!(customerID == null ? other.customerID == null : customerID.equals(other.customerID))) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        final int PRIME = 37;
        int result = 1;
        result = PRIME * result + ((orderID == null) ? 0 : orderID.hashCode());
        result = PRIME * result + ((customerID == null) ? 0 : customerID.hashCode());
        return result;
    }
    
    /*Members*/

    private Integer orderID;
    private Integer customerID;
}
