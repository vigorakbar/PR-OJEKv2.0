<%-- 
    Document   : signup
    Created on : Nov 7, 2017, 10:04:58 PM
    Author     : Vigor Akbar
--%>


<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="org.apache.http.client.HttpClient" %>
<%@page import="org.apache.http.impl.client.HttpClientBuilder" %>
<%@page import="org.apache.http.client.methods.HttpPost" %>
<%@page import="org.apache.http.entity.StringEntity" %>
<%@page import="org.apache.http.HttpEntity" %>
<%@page import ="org.json.simple.parser.ParseException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        String message = null;
        if (request.getMethod().equals("POST")){
            JSONObject jsonForm = new JSONObject();
            URL obj = null;
            HttpClient httpClient = HttpClientBuilder.create().build();
            try {
                String name = request.getParameter("name");
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String password_conf = request.getParameter("password_conf");
                String phone = request.getParameter("phone");
                String driver = request.getParameter("driver");
                Integer driverInt;
                if ("true".equals(driver)) {
                    driverInt = 1;
                } else {
                    driverInt = 0;
                }
                jsonForm.put("name", name);
                jsonForm.put("username", username);
                jsonForm.put("email", email);
                jsonForm.put("password", password);
                jsonForm.put("password_conf", password_conf);
                jsonForm.put("phone", phone);
                jsonForm.put("driver", driverInt);
                HttpPost postRequest = new HttpPost("http://localhost:8080/Identity-Service/Register");
                StringEntity params = new StringEntity(jsonForm.toJSONString());
                postRequest.addHeader("content-type", "application/json");
                postRequest.setEntity(params);
                HttpResponse resp = httpClient.execute(postRequest);
                HttpEntity entity = resp.getEntity();
                String responseString = EntityUtils.toString(entity, "UTF-8");
                out.print(responseString);
		JSONParser parser = new JSONParser();
		JSONObject jsonResp = new JSONObject();
		try {
                    jsonResp = (JSONObject) parser.parse(responseString);
		} catch (ParseException e) {
		}
                Integer statusCode = resp.getStatusLine().getStatusCode();
                if (statusCode == 200) {
                    //berhasil register
                    session.setAttribute("token", jsonResp.get("token"));
                    JSONObject userJson= (JSONObject) jsonResp.get("user");
                    if ((Long) userJson.get("driver") == 1) {
                        response.sendRedirect("profile.jsp");
                        return;
                    } else {
                        response.sendRedirect("order-destination.jsp");
                        return;
                    }
                } else {
                    //gagal register
                    out.print("<script>alert('"+jsonResp.get("error")+"')</script>");
                }
            } catch (Exception e) {
                out.print(e.getMessage());
            }
        }
    %>
    <head>
        <title>Halaman Signup</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="css/auth.css">

    </head>
    <body>
        <div class="apps">
            <div class="form-heading">
                <div class="heading-left">
                    <hr>
                </div>
                <div class="heading-title">
                    SIGNUP
                </div>
                <div class="heading-right">
                    <hr>
                </div>
            </div>
            <div class="form-signup">
                <form action="" method="POST" autocomplete="off">
                    <div class="form-group">
                        <label for="name">Your Name</label>                            
                        <input id="name" type="text" name="name" placeholder="your name" required>
                    </div>
                    <div class="form-group">
                        <label for="username">Username</label>                            
                        <input id="username" type="text" name="username" placeholder="your username" onfocusout="getUsernameValidation()" required> <span><i class="material-icons" id="checkUsername">check</i><i class="material-icons" id="wrongUsername">info</i></span>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>                            
                        <input id="email" type="text" name="email" placeholder="your email" onfocusout="getEmailValidation()" required><span><i class="material-icons" id="checkEmail">check</i><i class="material-icons" id="wrongEmail">info</i></span>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>                            
                        <input id="password" type="password" name="password" placeholder="your password" pattern=".{5,10}" title="5 to 10 characters" required>
                    </div>
                    <div class="form-group">
                        <label for="password_conf">Password Confirm</label>                            
                        <input id="password_conf" type="password" name="password_conf" placeholder="your password again" pattern=".{5,10}" title="5 to 10 characters" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>                            
                        <input id="phone" type="text" name="phone" placeholder="your phone" required>
                    </div>
                    <input type="checkbox" name="driver" value="true"> Also sign me up as a driver!
                    <div class="action">
                        <div class="login">
                            <a href="login.php">Already have an account ?</a>
                        </div>
                        <div class="submit">
                            <input id="submit" type="submit" name="submit" value="REGISTER">                            
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <script src="js/validation.js"></script>
    </body>
</html>

