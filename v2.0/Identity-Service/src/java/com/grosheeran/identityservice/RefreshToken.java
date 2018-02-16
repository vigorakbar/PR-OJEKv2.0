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
 * Servlet implementation class RefreshToken
 */
public class RefreshToken extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RefreshToken() {
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
				String newToken = Token.addUserToken(userId);
	    		responseObject.put("token", newToken);
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
