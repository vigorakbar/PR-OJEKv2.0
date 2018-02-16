/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.ojekservice.soap;

import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;

/**
 *
 * @author user
 */
@WebService
@SOAPBinding(style = SOAPBinding.Style.RPC)
public interface OrderInterface {
    @WebMethod
    String getDriver(String token, String pickingpoint, String destination, String prefdriver);
    @WebMethod
    String completeOrder(String token, String pickingpoint, String destination, String prefdriver);
    @WebMethod
    String getCustomerOrder(String token);
    @WebMethod
    String getDriverOrder(String token);
    @WebMethod
    String hideCustomer(String token);
    @WebMethod
    String hideDriver(String token);
}
