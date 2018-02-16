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
import java.sql.SQLException;
import java.util.ArrayList;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
/**
 *
 * @author Asus
 */
@WebService(serviceName = "AddPreferredLocation")
public class AddPreferredLocation {
    @WebMethod(operationName = "addPreferredLocation")
    public String addPreferredLocation(@WebParam(name="location") String location, @WebParam(name="token") String token) {
        IdentityServiceConnector ISC = new IdentityServiceConnector();
        User user = ISC.getUserFromToken(token);
        String hasil = "";
        try {
            String url        = "jdbc:mysql://139.59.238.193:3306/ojek_service";
            String username   = "root";
            String dbpassword = "password";
            
            DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
            Connection conn = DriverManager.getConnection(url, username, dbpassword);
            
            int id_driver = user.getUserId();
            String query = "INSERT INTO preferred_locations (driver_id, location) VALUES (?,?)";
	    PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1,id_driver);
            pstmt.setString(2, location);
            int rowAffected = pstmt.executeUpdate();
            if (rowAffected == 1) {
                hasil = "berhasil";
            } else {
                hasil = "gagal";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return hasil;
    }
}
