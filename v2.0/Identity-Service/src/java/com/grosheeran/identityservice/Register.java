package com.grosheeran.identityservice;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
/**
 * Servlet implementation class Register
 */
@SuppressWarnings("unchecked")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	// TODO Auto-generated method stub
		JSONObject resp = new JSONObject();
		PrintWriter out = response.getWriter();
                StringBuffer jb = new StringBuffer();
		BufferedReader reader = null;
		String line = null;
		  try {
		    reader = request.getReader();
		    char[] charBuffer = new char[128];
	        int bytesRead;
	        while ( (bytesRead = reader.read(charBuffer)) != -1 ) {
	            jb.append(charBuffer, 0, bytesRead);
	        }
		  } catch (IOException e) { 
			  throw e;
		  } finally {
			  if (reader != null) {
				  try {
					  reader.close();
				  } catch (IOException e) {
					  throw e;
				  }
			  }
		  }
		  line = jb.toString();

		JSONParser parser = new JSONParser();
		Object obj = new Object();
		try {
			obj = parser.parse(line);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		JSONObject jsonReq = (JSONObject) obj;
		String name = null, username = null, email = null, password = null;
		String password_conf = null, phone = null;
		Long driver = new Long(0);
		name = (String) jsonReq.get("name");
		username = (String) jsonReq.get("username");
		email = (String) jsonReq.get("email");
		password = (String) jsonReq.get("password");
		password_conf = (String) jsonReq.get("password_conf");
		phone = (String) jsonReq.get("phone");
		driver = (Long) jsonReq.get("driver");
		Connection conn = null;
		try {
                    String url        = "jdbc:mysql://139.59.238.193:3306/identity_service";
		    String user       = "root";
		    String dbpassword = "password";
		    DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
		    conn = DriverManager.getConnection(url, user, dbpassword);
		    String query = "SELECT username, email FROM users WHERE username=? OR email =?";
		    PreparedStatement preparedStatement = conn.prepareStatement(query);
		    preparedStatement.setString(1, username);
		    preparedStatement.setString(2, email);
		    ResultSet rs = preparedStatement.executeQuery();
                    response.setContentType("application/json");
                    boolean empty = true;
                    while(rs.next()) {
                        empty = false;
                    }
                    if(!empty) {
                    // Empty result set
                        response.setStatus(400);
		    	resp.put("error", "username atau email telah terpakai");
		    	out.print(resp);
		    } else if (!password.equals(password_conf)) {
		    	//response.getWriter().append("testing. konfirmasi password tidak sesuai");
		    	response.setStatus(400);
		    	resp.put("error", "konfirmasi password tidak sesuai");
		    	out.print(resp);
		    } else {
		    	query = "INSERT INTO users (name, username, email, password, phone_number, driver) "
		    			+ "VALUES(?,?,?,?,?,?)";
		    	PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		    	pstmt.setString(1, name);
		    	pstmt.setString(2, username);
		    	pstmt.setString(3, email);
		    	pstmt.setString(4, password);
		    	pstmt.setString(5, phone);
		    	pstmt.setLong(6, driver);
		    	int rowAffected = pstmt.executeUpdate();
		    	if (rowAffected == 1) {
		    		//test
		    		//response.getWriter().append("testing. insert berhasil");
                                System.out.print("TESTSETSET");
                                query = "SELECT * FROM users WHERE username=?";
                                pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
                                pstmt.setString(1, username);
                                rs = pstmt.executeQuery();
                                rs.next();
                                int id = rs.getInt("ID");
                                JSONObject userObject = new JSONObject();
                                userObject.put("userId", id);

                                String user_name = rs.getString("name");
                                userObject.put("name", user_name);

                                String userName = rs.getString("username");
                                userObject.put("username", userName);

                                String userEmail = rs.getString("email");
                                userObject.put("email", userEmail);

                                String phoneNumber = rs.getString("phone_number");
                                userObject.put("phoneNumber", phoneNumber);

                                int is_driver = rs.getInt("driver");
                                userObject.put("driver", is_driver);

                                String image = rs.getString("image");
                                userObject.put("image", image);


                                String userToken = Token.addUserToken(rs.getInt("ID"));
                                resp.put("token", userToken);
                                resp.put("user", userObject);
                                out.print(resp);
			    	//manggil login
		    	}
		    }
		    
		} catch(SQLException e) {
			System.out.println(e.getMessage());
                        response.setStatus(400);
                        resp.put("error","sqlexception");
			out.print(resp);
		} catch (Exception ex) {
                        Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
                        response.setStatus(400);
                        resp.put("error", "excpecce");
			out.print(resp);
                } finally {
			try {
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException ex){
				System.out.println(ex.getMessage());
			}
		}	
	}
}
