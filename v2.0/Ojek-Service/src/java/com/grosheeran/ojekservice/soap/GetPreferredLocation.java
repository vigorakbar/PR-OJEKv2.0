/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.ojekservice.soap;

import com.grosheeran.identityservice.soap.User;
import com.grosheeran.ojekservice.IdentityServiceConnector;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author Asus
 */
@WebService(serviceName = "GetPreferredLocation")
public class GetPreferredLocation {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "getPreferredLocation")
    public List<String> getPreferredLocation(@WebParam(name="token") String token) {
        IdentityServiceConnector ISC = new IdentityServiceConnector();
        User user = ISC.getUserFromToken(token);
        List<String> result = new ArrayList<String>();
        try {
            String url        = "jdbc:mysql://139.59.238.193:3306/ojek_service";
            String username   = "root";
            String dbpassword = "password";
            
            DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
            Connection conn = DriverManager.getConnection(url, username, dbpassword);
            int id_driver = user.getUserId();
            String query = "SELECT location FROM preferred_locations WHERE driver_id = ?";
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, id_driver);
            
            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()) {
                String locStr = rs.getString("location");
                result.add(locStr);
            }
        }  catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }
}
