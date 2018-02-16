/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.ojekservice.soap;

import com.grosheeran.ojekservice.Order;
import com.grosheeran.ojekservice.Rating;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author kingfalcon
 */
@WebService(serviceName = "GetRatingFromOrderId")
public class GetRatingFromOrderId {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "getRatingFromOrderId")
    public Rating getRatingFromOrderId(@WebParam(name = "orderId") int orderId) {
        Rating hasil = new Rating();
        
        try {
            String url        = "jdbc:mysql://139.59.238.193:3306/ojek_service";
            String username   = "root";
            String dbpassword = "password";

            DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
            Connection conn = DriverManager.getConnection(url, username, dbpassword);
            
            String query = "SELECT * FROM ratings WHERE order_id=?;";
	    PreparedStatement preparedStatement = conn.prepareStatement(query);
	    preparedStatement.setInt(1, orderId);
            
            ResultSet rs = preparedStatement.executeQuery();
            if(rs.next()) {
                hasil = new Rating(rs.getInt("id"), rs.getInt("order_id"), rs.getInt("rating"), rs.getString("comment"));
            }
            else {
                hasil.setId(-1);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
       
        return hasil;
    }
}
