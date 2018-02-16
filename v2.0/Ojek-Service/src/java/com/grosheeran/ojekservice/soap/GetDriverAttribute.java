/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.ojekservice.soap;

import com.grosheeran.ojekservice.DriverAttribute;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author kingfalcon
 */
@WebService(serviceName = "GetDriverAttribute")
public class GetDriverAttribute {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "getDriverAttribute")
    public DriverAttribute getDriverAttribute(@WebParam(name = "driverId") int driverId) {
        DriverAttribute hasil = new DriverAttribute(0, 0);
        try {
            String url        = "jdbc:mysql://139.59.238.193:3306/ojek_service";
            String username   = "root";
            String dbpassword = "password";

            DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
            Connection conn = DriverManager.getConnection(url, username, dbpassword);
            
            String query = "SELECT COUNT(*) AS count, AVG(rating) AS average FROM ratings JOIN orders ON ratings.order_id=orders.id WHERE orders.driver_id=?;";
	    PreparedStatement preparedStatement = conn.prepareStatement(query);
	    preparedStatement.setInt(1, driverId);
            
            ResultSet rs = preparedStatement.executeQuery();
            
            if (rs.next()) {
                hasil.setNumberOfRating(rs.getInt("count"));
                hasil.setAverageRating(rs.getFloat("average"));
            }
        }   
       
        catch (SQLException e) {
            
        }
        return hasil;
    }
}
