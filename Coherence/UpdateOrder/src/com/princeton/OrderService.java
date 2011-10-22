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
    public void putOrder(int orderID, int customerID){   
        CacheFactory.ensureCluster();
        NamedCache orders = CacheFactory.getCache("orders");
        
        Order o = new Order(orderID, customerID);
        
        /*try{
                         
        }
        catch(Exception e){
            StringWriter writer = new StringWriter();
            e.printStackTrace(new PrintWriter(writer));
            return writer.toString();
        }
        finally{
                CacheFactory.shutdown();    
        }*/       
        orders.put(o.getOrderID(), o);    
        
        //CacheFactory.shutdown();
    }
    
    @WebMethod
    public String getOrder(int orderID){
        CacheFactory.ensureCluster();
        NamedCache orders = CacheFactory.getCache("orders");
        
        Order o = (Order)orders.get(orderID);
        
        //CacheFactory.shutdown();
        return o.toString();
    }
}
