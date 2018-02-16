/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.ojekservice.soap;

import com.grosheeran.identityservice.soap.User;
import com.grosheeran.ojekservice.IdentityServiceConnector;
import com.grosheeran.ojekservice.Order;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author kingfalcon
 */
@WebService(serviceName = "GetDriverHistory")
public class GetDriverHistory {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "getDriverHistory")
    public ArrayList<Order> getDriverHistory(@WebParam(name = "token") String token) {
        IdentityServiceConnector ISC = new IdentityServiceConnector();
        User user = ISC.getUserFromToken(token);
        ArrayList<Order> hasil = new ArrayList<Order>();
        
        
        try {
            String url        = "jdbc:mysql://139.59.238.193:3306/ojek_service";
            String username   = "root";
            String dbpassword = "password";

            DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
            Connection conn = DriverManager.getConnection(url, username, dbpassword);
            
            String query = "SELECT * FROM orders WHERE driver_id=? AND is_visible_by_driver=1;";
	    PreparedStatement preparedStatement = conn.prepareStatement(query);
	    preparedStatement.setInt(1, user.getUserId());
            
            ResultSet rs = preparedStatement.executeQuery();
            while(rs.next()) {
                Order newOrder = new Order(rs.getInt("id"), rs.getInt("user_id"), rs.getInt("driver_id"), rs.getTimestamp("timestamp"), rs.getString("pickingpoint"), rs.getString("destination"), rs.getBoolean("is_complete"), rs.getBoolean("is_visible_by_user"), rs.getBoolean("is_visible_by_driver"));
                hasil.add(newOrder);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        
        return hasil;
    }
}
