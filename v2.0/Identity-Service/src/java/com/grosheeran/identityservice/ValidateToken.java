package com.grosheeran.identityservice;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
/**
 * Servlet implementation class ValidateToken
 */
public class ValidateToken extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidateToken() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
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
			
			if (!requestObject.containsKey("token")) {
				throw new Exception("Token not found.");
			}
			
			String token = (String) requestObject.get("token");
			int userId = Token.getUserIdFromToken(token);
			
		    if (userId == -2) {
		    	throw new Exception("Expired token.");
		    }
		    else if (userId == -1) {
		    	throw new Exception("Invalid token.");
		    } else {
				String url        = "jdbc:mysql://139.59.238.193:3306/identity_service";
		    String user       = "root";
		    String dbpassword = "password";
			    DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
			    Connection conn = DriverManager.getConnection(url, user, dbpassword);
			    
			    String query = "SELECT * FROM users WHERE ID=?";
			    PreparedStatement preparedStatement = conn.prepareStatement(query);
			    preparedStatement.setInt(1, userId);
			    
			    ResultSet rs = preparedStatement.executeQuery();
				if (rs.next()) {
		    		int id = rs.getInt("ID");
		    		responseObject.put("userId", id);

		    		String name = rs.getString("name");
		    		responseObject.put("name", name);
		    		
		    		String userName = rs.getString("username");
		    		responseObject.put("username", userName);
		    		
		    		String userEmail = rs.getString("email");
		    		responseObject.put("email", userEmail);
		    		
		    		String phoneNumber = rs.getString("phone_number");
		    		responseObject.put("phoneNumber", phoneNumber);
		    		
		    		int driver = rs.getInt("driver");
		    		responseObject.put("driver", driver);
		    		
		    		String image = rs.getString("image");
		    		responseObject.put("image", image);
			    }
			    else {
			    	throw new Exception("Wrong username/password.");
			    }
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
