package com.grosheeran.identityservice;

import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.json.simple.JSONObject;

public class Token {
	private static final String characterSet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	private static final int tokenLength = 64;
	private static final long tokenAge = 1*60*60*1000;
	
	private static SecureRandom rnd = new SecureRandom();

	private static String generateRandomString() {
	   StringBuilder sb = new StringBuilder(tokenLength);
	   for( int i = 0; i < tokenLength; i++ ) 
	      sb.append(characterSet.charAt( rnd.nextInt(characterSet.length()) ) );
	   return sb.toString();
	}
	
	public static int getUserIdFromToken(String token) throws SQLException {
		String url        = "jdbc:mysql://139.59.238.193:3306/identity_service";
		    String user       = "root";
		    String dbpassword = "password";
	    DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
	    Connection conn = DriverManager.getConnection(url, user, dbpassword);
	    
	    String query = "SELECT * FROM users_token WHERE token=?";
	    PreparedStatement preparedStatement = conn.prepareStatement(query);
	    preparedStatement.setString(1, token);
	    
	    ResultSet rs = preparedStatement.executeQuery();
	    if (rs.next()) {
	    		Timestamp expiry = rs.getTimestamp("expiry");
	    		Timestamp now = new Timestamp(System.currentTimeMillis());
	    		
	    		if (expiry.after(now)) {
	    			return rs.getInt("user_id");
	    		}
	    		else {
	    			return -2;
	    		}
	    }
	    else {
	    		return -1;
	    }
	}
	
	public static String addUserToken(int userId) throws Exception {
		String newToken = generateRandomString();
		
		while(getUserIdFromToken(newToken) != -1) {
			newToken = generateRandomString();
		}
		
		Timestamp expiry = new Timestamp(System.currentTimeMillis() + tokenAge);
		
		String url        = "jdbc:mysql://139.59.238.193:3306/identity_service";
		    String user       = "root";
		    String dbpassword = "password";
	    DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
	    Connection conn = DriverManager.getConnection(url, user, dbpassword);
	    
	    String query = "INSERT INTO users_token (user_id, token, expiry) VALUES (?, ?, ?)";
	    PreparedStatement preparedStatement = conn.prepareStatement(query);
	    preparedStatement.setInt(1, userId);
	    preparedStatement.setString(2, newToken);
	    preparedStatement.setTimestamp(3, expiry);
	    
	    int rowAffected = preparedStatement.executeUpdate();
	    
	    if (rowAffected == 0) {
	    		throw new Exception("Failed to add new user token.");
	    }
		return newToken;
	}
}