<%-- 
    Document   : editpreferredlocations
    Created on : Nov 8, 2017, 9:08:00 PM
    Author     : Asus
--%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.xml.ws.Service"%>
<%@page import="javax.xml.namespace.QName"%>
<%@page import="java.net.URL"%>
<%@page import="org.apache.http.HttpEntity"%>
<%@page import="java.text.ParseException"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.impl.client.HttpClients"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.apache.http.entity.ContentType"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.entity.StringEntity"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.grosheeran.ojekservice.soap.AddPreferredLocation"%>
<%@page import="com.grosheeran.ojekservice.soap.GetPreferredLocation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
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
        response.sendRedirect("login.jsp");
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
    long is_driver = (long) userObject.get("driver");
    if (is_driver == 0) {
        response.sendRedirect("profile.jsp?token=" + token);
        return;
    }
    if(request.getMethod().equals("POST")) {
        URL wsdlUrl = new URL("http://localhost:8080/Ojek-Service/AddPreferredLocation?wsdl");
        QName qname = new QName("http://soap.ojekservice.grosheeran.com/", "AddPreferredLocation");
        QName qnamePort = new QName("http://soap.ojekservice.grosheeran.com/", "AddPreferredLocationPort");
        Service service = Service.create(wsdlUrl, qname);
        AddPreferredLocation apl = service.getPort(qnamePort, AddPreferredLocation.class);
        String AddStat = apl.addPreferredLocation(request.getParameter("location"), token);
        if ("berhasil".equals(AddStat)) {
            out.print("<script>alert('Penambahan lokasi berhasil')</script>");
        } else {
            out.print("<script>alert('Error. Penambahan lokasi gagal')</script>");
        }
        response.sendRedirect("editpreferredlocations.jsp?token="+token);
    }       
    %>
    <head>
        <title>Edit Profile</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">        
        <link rel="stylesheet" href="css/profile.css">
    </head>
    <body>
        <div class="apps">
            <div class="heading">
                <h2>EDIT PREFERRED LOCATIONS</h2>
            </div>
            <table border="1" class="data-location">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Location</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        //akses ojek web service
                        URL wsdlUrl = new URL("http://localhost:8080/Ojek-Service/GetPreferredLocation?wsdl");
                        QName qname = new QName("http://soap.ojekservice.grosheeran.com/", "GetPreferredLocation");
                        QName qnamePort = new QName("http://soap.ojekservice.grosheeran.com/", "GetPreferredLocationPort");
                        Service service = Service.create(wsdlUrl, qname);
                        GetPreferredLocation gpl = service.getPort(qnamePort, GetPreferredLocation.class);
                        List<String> prefLoc = gpl.getPreferredLocation(token);
                        int i = 1;
                        for (String loc : prefLoc) {
                            %>
                            <tr>
                                <td><%= i %></td>
                                <td><%= loc %></td>
                                <td>hapus</td>
                            </tr>
                            <%
                        }
                    %>
                </tbody>
            </table>
            <div class="add-location">
                <h3>ADD NEW LOCATION</h3>
                <form action="" method="post">
                    <input type="text" name="location" required>
                    <input type="submit" name="submit" value="ADD">
                </form>
            </div>
            <div class="back">
                <a href="profile.jsp?token=<% out.print(token); %>">BACK</a>
            </div>
        </div>
        <script src="js/editlocation.js"></script>
    </body>
</html>
