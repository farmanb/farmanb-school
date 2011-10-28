package com.princeton;


import com.tangosol.net.CacheFactory;
import com.tangosol.net.NamedCache;

import java.io.PrintWriter;
import java.io.StringWriter;

import javax.jws.WebMethod;
import javax.jws.WebService;

/**
 * A web service interface for the cache.
 * This is intended to simulate the web 
 * interface provided to a database.
 */
@WebService
public class OrderService {
    public OrderService() {
        super();
    }

    /**
     * This method puts an order in the cache.
     * @return The stringified order placed in the cache, used for debug purposes only.
     */
    @WebMethod
    public String putOrder(Integer orderID, Integer customerID) {
        NamedCache orders = CacheFactory.getCache("orders");
        Order o = new Order(orderID, customerID);
        
        try {
            orders.put(o.getOrderID(), o);
        } 
        catch (Exception e) {
            StringWriter writer = new StringWriter();
            e.printStackTrace(new PrintWriter(writer));
            return writer.toString();
        }
        
        CacheFactory.shutdown();
        return o.toString();
    }

    /**
     * This method gets an order, by the Order ID, from the cache.
     */
    @WebMethod
    public Order getOrder(Integer orderID) {
        NamedCache orders = CacheFactory.getCache("orders");
        Order o = (Order)orders.get(orderID);

        CacheFactory.shutdown();
        return o;
    }
}
