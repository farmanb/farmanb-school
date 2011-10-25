package com.princeton;

import java.io.Serializable;

/**
 */
public class Order implements Serializable{
    
    /*Constructors*/

    /**
     */
    public Order() {
        super();
    }

    /**
     * @param orderID
     * @param customerID
     */
    public Order(int orderID, int customerID) {
        super();
        this.orderID = orderID;
        this.customerID = customerID;
    }


    /*Accessors*/

    /**
     * @param orderID
     */
    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    /**
     * @return
     */
    public int getOrderID() {
        return orderID;
    }

    /**
     * @param customerID
     */
    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    /**
     * @return
     */
    public int getCustomerID() {
        return customerID;
    }
    
    /*Functions*/


    /**
     * @param object
     * @return
     */
    @Override
    public boolean equals(Object object) {
        if (this == object) {
            return true;
        }
        if (!(object instanceof Order)) {
            return false;
        }
        final Order other = (Order)object;
        if (orderID != other.orderID) {
            return false;
        }
        if (customerID != other.customerID) {
            return false;
        }
        return true;
    }

    /**
     * @return
     */
    @Override
    public int hashCode() {
        final int PRIME = 37;
        int result = 1;
        result = PRIME * result + orderID;
        result = PRIME * result + customerID;
        return result;
    }


    /**
     * @return
     */
    @Override
    public String toString(){
        return "Order #: " + this.getOrderID() + "\n" + 
            "Customer #: " + this.getCustomerID();
    }
    
    /*Members*/

    /**
     */
    private int orderID;

    /**
     */
    private int customerID;

}
