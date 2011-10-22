package com.princeton;

public class OrderDriver {
    public OrderDriver() {
        super();
    }

    public static void main(String[] args) {
        OrderService oService = new OrderService();
        
        oService.putOrder(1, 2);
        
        //OrderDriver orderDriver = new OrderDriver();
    }
}
