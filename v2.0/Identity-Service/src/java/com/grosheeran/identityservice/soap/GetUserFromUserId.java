/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.identityservice.soap;

import static com.grosheeran.identityservice.Token.getUserIdFromToken;
import com.grosheeran.identityservice.model.User;
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
@WebService(serviceName = "GetUserFromUserId")
public class GetUserFromUserId {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "getUserFromUserId")
    public User getUserFromUserId(@WebParam(name = "userId") int userId) {
        try {
            String url        = "jdbc:mysql://139.59.238.193:3306/identity_service";
            String user       = "root";
            String dbpassword = "password";
            DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
            Connection conn = DriverManager.getConnection(url, user, dbpassword);

            String query = "SELECT * FROM users WHERE ID=?";
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, userId);

            ResultSet rs = preparedStatement.executeQuery();
            if (!rs.next()) {
                throw new Exception("Invalid user id");
            }

            int id = rs.getInt("ID");
            String name = rs.getString("name");
            String username = rs.getString("username");
            String email = rs.getString("email");
            String phoneNumber = rs.getString("phone_number");
            int driver = rs.getInt("driver");
            String image = rs.getString("image");

            return new User(id, username, name, email, phoneNumber, driver, image);
        }
        catch (Exception e) {
            User error = new User();
            error.setUserId(-1);
            error.setName(e.getMessage());
            
            return error;
        }
    }
}
