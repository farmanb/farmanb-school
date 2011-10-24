package com.princeton;

import com.tangosol.net.CacheFactory;
import com.tangosol.net.Cluster;
import com.tangosol.net.NamedCache;

import java.io.PrintWriter;
import java.io.StringWriter;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService
public class OrderService {
    public OrderService() {
        super();
    }

    /**
     * @param orderID
     * @param customerID
     * @return
     */
    @WebMethod
    public String putOrder(int orderID, int customerID) {
        Order o = new Order(orderID, customerID);
        
        try {
            orders.put(o.getOrderID(), o);
        } 
        catch (Exception e) {
            StringWriter writer = new StringWriter();
            e.printStackTrace(new PrintWriter(writer));
            return writer.toString();
        }
        
        return o.toString();
    }

    @WebMethod
    public String getOrder(int orderID) {
        Order o = (Order)orders.get(orderID);

        return o.toString();
    }
    
    private static NamedCache orders = CacheFactory.getCache("orders");
}
