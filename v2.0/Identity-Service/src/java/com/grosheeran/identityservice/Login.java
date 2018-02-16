package com.grosheeran.identityservice;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject responseObject = new JSONObject();
		JSONObject requestObject = new JSONObject();
		response.setContentType("application/json");
		try {
			StringBuffer jb = new StringBuffer();
			String line = null;
			
			BufferedReader reader = request.getReader();
			
			while ((line = reader.readLine()) != null) {
				jb.append(line);
			}
			
			JSONParser parser = new JSONParser();
			requestObject = (JSONObject) parser.parse(jb.toString());
			
			if (!requestObject.containsKey("username") || !requestObject.containsKey("password")) {
				throw new Exception("Enter username and password.");
			}
			
                    String url        = "jdbc:mysql://139.59.238.193:3306/identity_service";
		    String user       = "root";
		    String dbpassword = "password";
		    DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
		    Connection conn = DriverManager.getConnection(url, user, dbpassword);
		    
		    String query = "SELECT * FROM users WHERE username=? AND password=?";
		    PreparedStatement preparedStatement = conn.prepareStatement(query);
		    preparedStatement.setString(1, (String) requestObject.get("username"));
		    preparedStatement.setString(2, (String) requestObject.get("password"));
		    
		    ResultSet rs = preparedStatement.executeQuery();
		    
		    if (rs.next()) {
                        int id = rs.getInt("ID");
                        JSONObject userObject = new JSONObject();
                        userObject.put("userId", id);

                        String name = rs.getString("name");
                        userObject.put("name", name);

                        String userName = rs.getString("username");
                        userObject.put("username", userName);

                        String userEmail = rs.getString("email");
                        userObject.put("email", userEmail);

                        String phoneNumber = rs.getString("phone_number");
                        userObject.put("phoneNumber", phoneNumber);

                        int driver = rs.getInt("driver");
                        userObject.put("driver", driver);

                        String image = rs.getString("image");
                        userObject.put("image", image);


                        String userToken = Token.addUserToken(rs.getInt("ID"));
                        responseObject.put("token", userToken);
                        responseObject.put("user", userObject);
		    }
		    else {
		    		throw new Exception("Wrong username/password.");
		    }
		    
		    response.getWriter().append(responseObject.toString());
		}
		catch (Exception e) {
			e.printStackTrace();
			
			responseObject.put("error", e.getMessage());
			
			response.setStatus(400);
			response.getWriter().append(responseObject.toString());
		}
	}
}
