package com.princeton;

import com.tangosol.io.pof.PofReader;
import com.tangosol.io.pof.PofWriter;
import com.tangosol.io.pof.PortableObject;

import com.tangosol.util.HashHelper;

import java.io.IOException;
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
     * @param reader
     * @throws IOException
     */
    public void readExternal(PofReader reader) throws java.io.IOException{
        this.setOrderID(reader.readInt(0));
        this.setCustomerID(reader.readInt(1));
    }

    /**
     * @param writer
     * @throws IOException
     */
    public void writeExternal(PofWriter writer) throws java.io.IOException{
        writer.writeInt(0, this.getOrderID());
        writer.writeInt(1, this.getCustomerID());
    }

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
        return HashHelper.hash(this.getOrderID(), 0);
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
