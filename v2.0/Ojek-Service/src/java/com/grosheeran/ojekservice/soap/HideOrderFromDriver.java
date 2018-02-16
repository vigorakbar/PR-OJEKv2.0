/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.ojekservice.soap;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author kingfalcon
 */
@WebService(serviceName = "HideOrderFromDriver")
public class HideOrderFromDriver {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hideOrderFromDriver")
    public int hideOrderFromDriver(@WebParam(name = "orderId") int orderId) {
        try {
            String url        = "jdbc:mysql://139.59.238.193:3306/ojek_service";
            String username   = "root";
            String dbpassword = "password";

            DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
            Connection conn = DriverManager.getConnection(url, username, dbpassword);
            
            String query = "UPDATE orders SET is_visible_by_driver=0 WHERE id=?";
	    PreparedStatement preparedStatement = conn.prepareStatement(query);
	    preparedStatement.setInt(1, orderId);
            
            if (preparedStatement.executeUpdate() == 0) {
                return 0;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
        
        return 1;
    }
}
