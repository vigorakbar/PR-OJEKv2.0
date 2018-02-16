<%-- 
    Document   : login
    Created on : Nov 8, 2017, 8:28:51 PM
    Author     : Asus
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
        if (request.getMethod().equals("POST")){
            JSONObject jsonForm = new JSONObject();
            URL obj = null;
            HttpClient httpClient = HttpClientBuilder.create().build();
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                jsonForm.put("username", username);
                jsonForm.put("password", password);
                HttpPost postRequest = new HttpPost("http://localhost:8080/Identity-Service/Login");
                StringEntity params = new StringEntity(jsonForm.toJSONString());
                postRequest.addHeader("content-type", "application/json");
                postRequest.setEntity(params);
                HttpResponse resp = httpClient.execute(postRequest);
                HttpEntity entity = resp.getEntity();
                String responseString = EntityUtils.toString(entity, "UTF-8");
                
                JSONParser parser = new JSONParser();
		JSONObject jsonResp = new JSONObject();
		try {
                    jsonResp = (JSONObject) parser.parse(responseString);
		} catch (ParseException e) {
		}
                Integer statusCode = resp.getStatusLine().getStatusCode();
                if (statusCode == 200) {
                    //berhasil register
                    //session.setAttribute("token", jsonResp.get("token"));
                    JSONObject userJson= (JSONObject) jsonResp.get("user");
                    if ((Long) userJson.get("driver") == 1) {
                        response.sendRedirect(response.encodeRedirectURL("profile.jsp?token=" + jsonResp.get("token")));
                        return;
                    } else {
                        response.sendRedirect(response.encodeRedirectURL("order-destination.jsp?token=" + jsonResp.get("token")));
                        return;
                    }
                } else {
                    //gagal login
                    out.print("<script>alert('"+jsonResp.get("error")+"')</script>");
                }
            } catch (Exception e) {
                out.print(e.getMessage());
            }
        }
    %>
    <head>
        <title>Halaman Login</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
        <link rel="stylesheet" href="css/auth.css">
        <script src="js/validation.js"></script>
    </head>
    <body>
        <div class="apps">
            <div class="form-heading">
                <div class="heading-left">
                    <hr>
                </div>
                <div class="heading-title">
                    LOGIN  
                </div>
                <div class="heading-right">
                    <hr>
                </div>
            </div>
            <div class="form-login">
                <form action="" method="POST" autocomplete="off" onsubmit="return validateLogin()" name="login">
                    <div class="form-group">
                        <label for="username">Username </label>                            
                        <input id="username" type="text" name="username" placeholder="your username">
                    </div>
                    <div class="form-group">
                        <label for="password">Password </label>                            
                        <input id="password" type="password" name="password" placeholder="your password" pattern=".{5,10}" title="5 to 10 characters">                        
                    </div>
                    <div class="action">
                        <div class="register">
                            <a href="signup.jsp">Don't have an account ?</a>
                        </div>
                        <div class="submit">
                            <input type="submit" name="submit" value="GO!">                            
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>

