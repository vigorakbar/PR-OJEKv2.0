<%-- 
    Document   : update_profile
    Created on : Nov 16, 2017, 2:19:44 PM
    Author     : kingfalcon
--%>


<%@page import="com.grosheeran.identityservice.soap.UpdateUser"%>
<%@page import="javax.xml.ws.Service"%>
<%@page import="javax.xml.namespace.QName"%>
<%@page import="java.net.URL"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.impl.client.HttpClients"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.apache.http.entity.ContentType"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.entity.StringEntity"%>
<%@page import="org.json.simple.JSONObject"%>
<%
    String message;
  
    HttpClient httpClient = HttpClients.createDefault();
    JSONObject requestObject = new JSONObject();
    JSONObject userObject = new JSONObject();
    
    String token = request.getParameter("token");
    if (token == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    requestObject.put("token", token);
    
    StringEntity requestEntity = new StringEntity(requestObject.toJSONString(), ContentType.APPLICATION_JSON);
    HttpPost postMethod = new HttpPost("http://localhost:8080/Identity-Service/ValidateToken");
    postMethod.setEntity(requestEntity);
    
    HttpResponse rawResponse = httpClient.execute(postMethod);
    
    if (rawResponse.getStatusLine().getStatusCode() != 200) {
        //response.sendRedirect("login.jsp");
        
            String json = EntityUtils.toString(rawResponse.getEntity());
            JSONObject refreshObject = (JSONObject) (new JSONParser()).parse(json);
        out.print(refreshObject.toJSONString() + "<br />" + token);
        return;
    }
    else {
        StringEntity refreshEntity = new StringEntity(requestObject.toJSONString(), ContentType.APPLICATION_JSON);
        HttpPost postRefresh = new HttpPost("http://localhost:8080/Identity-Service/RefreshToken");
        postRefresh.setEntity(refreshEntity);
        
        HttpResponse refreshResponse = httpClient.execute(postRefresh);
        
        if (refreshResponse.getStatusLine().getStatusCode() == 200) {
            String json = EntityUtils.toString(refreshResponse.getEntity());
            JSONObject refreshObject = (JSONObject) (new JSONParser()).parse(json);
            token = (String) refreshObject.get("token");
        }
    }
    
    String json = EntityUtils.toString(rawResponse.getEntity());
    userObject = (JSONObject) (new JSONParser()).parse(json);
    
    
    if (request.getMethod().equals("POST")) {
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phone_number");
        String image = request.getParameter("image");
        int driver = (request.getParameter("driver") == null ? 0 : 1);
        
        URL wsdlUrl = new URL("http://localhost:8080/Identity-Service/UpdateUser?wsdl");
        QName qname = new QName("http://soap.identityservice.grosheeran.com/", "UpdateUser");
        QName qnamePort = new QName("http://soap.identityservice.grosheeran.com/", "UpdateUserPort");
        Service service = Service.create(wsdlUrl, qname);
        UpdateUser us = service.getPort(qnamePort, UpdateUser.class);
        
        us.updateUser(token, name, phoneNumber, driver, image);
        response.sendRedirect("profile.jsp?token=" + token);
        return;
    }
%>  

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype HTML>
<html>
    <head>
        <title>PR-OJEK</title>
        <meta name="viewport" content="width=device-width">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta charset="utf-8">
        <link rel="stylesheet" href="css/turfa.css" />
    </head>
    
    <body>
        <h1>Edit Profile</h1>
        <form method="POST">
            Name:<br />
            <input type="text" name="name" value="<% out.print(userObject.get("name")); %>" /> <br />
            
            Phone Number:<br />
            <input type="text" name="phone_number" value="<% out.print(userObject.get("phoneNumber")); %>" /> <br />
            
            Status Driver:<br />
            <input type="checkbox" name="driver" <% if (((long) userObject.get("driver")) != 0) out.print("checked"); %> /><br />
            
            Image URL:<br />
            <input type="text" name="image" value="<% out.print(userObject.get("image")); %>" /><br />
            
            <input type="submit" class="btn" value="Update" />
        </form>
    </body>
</html>