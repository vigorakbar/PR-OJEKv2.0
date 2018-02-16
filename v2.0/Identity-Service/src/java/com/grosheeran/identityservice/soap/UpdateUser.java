/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.identityservice.soap;

import static com.grosheeran.identityservice.Token.getUserIdFromToken;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author kingfalcon
 */
@WebService(serviceName = "UpdateUser")
public class UpdateUser {

    /**
     * This is a sample web service operation
     * @param token
     * @param name
     * @param phoneNumber
     * @param driver
     * @param image
     */
    @WebMethod(operationName = "updateUser")
    public void updateUser(@WebParam(name = "token") String token, @WebParam(name = "name") String name, @WebParam(name = "phoneNumber") String phoneNumber, @WebParam(name = "driver") int driver, @WebParam(name = "image") String image) {
        try {
            int id = getUserIdFromToken(token);
            
            String url        = "jdbc:mysql://139.59.238.193:3306/identity_service";
            String user       = "root";
            String dbpassword = "password";
            DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
            Connection conn = DriverManager.getConnection(url, user, dbpassword);

            String query = "UPDATE users SET name=?, phone_number=?, driver=?, image=? WHERE ID=?";
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, phoneNumber);
            preparedStatement.setBoolean(3, (driver != 0));
            preparedStatement.setString(4, image);
            preparedStatement.setInt(5, id);
            
            preparedStatement.executeUpdate();
        }
        catch (SQLException e) {
        }
    }
}
