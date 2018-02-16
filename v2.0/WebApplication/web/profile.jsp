<%-- 
    Document   : profile
    Created on : Nov 8, 2017, 1:03:51 AM
    Author     : kingfalcon
--%>

<%@page import="com.grosheeran.ojekservice.soap.DriverAttribute"%>
<%@page import="com.grosheeran.ojekservice.soap.GetDriverAttribute"%>
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
    
    URL wsdlUrlGDA = new URL("http://localhost:8080/Ojek-Service/GetDriverAttribute?wsdl");
    QName qnameGDA = new QName("http://soap.ojekservice.grosheeran.com/", "GetDriverAttribute");
    QName qnamePortGDA = new QName("http://soap.ojekservice.grosheeran.com/", "GetDriverAttributePort");
    Service serviceGDA = Service.create(wsdlUrlGDA, qnameGDA);
    GetDriverAttribute gda = serviceGDA.getPort(qnamePortGDA, GetDriverAttribute.class);
    
    DriverAttribute driverAttribute = gda.getDriverAttribute((Integer.parseInt(userObject.get("userId").toString())));
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
        <div class="page-container">
            <header>
                <div class="left container-column">
                    <p class="no-margin">
                        <b><font size="5" color="green">PR-</font><font size="5" color="red">OJEK</font></b>
                    </p>
                    <p class="no-margin">
                        <font color="green">wushh... wushh.. ngeeeeeeng...</font>
                    </p>
                </div>

                <div class="right container-column">
                    <p class="no-margin">
                        Hi, <b><% out.print(userObject.get("name")); %></b>
                    </p>
                    <p class="no-margin">
                        <a href="logout.jsp">Logout</a>
                    </p>
                </div>
            </header>
            <div>
                <ul class="tabs">
                    <li class="" onClick="location.href = 'order.jsp'"><button>ORDER</button></li>
                    <li class="" onClick="location.href = 'history.jsp?token=<% out.print(token); %>'"><button>HISTORY</button></li>
                    <li class="active-tab"  onClick="location.href = 'profile.jsp?token=<% out.print(token); %>'"><button>MY PROFILE</button></li>
                </ul>
            </div>
<style>
    #photo-container {
        width: 120px;
        height: 120px;
        border: solid 5px black;
        overflow: hidden;
    }
    #photo-container img {
        width: 120px;
        height: 120px;
    }
    #container-preffered-location ul {
        list-style: square url("img/play.png");
    }
</style>
<div class="float-container">
    <h1 class="title pull-left">MY PROFILE</h1>
    <div class="pull-right"><a href="update_profile.jsp?token=<% out.print(token); %>"><img src="img/edit.png"></a></div>
</div>
<div class="container-column row">
    <div id="photo-container" class="round center">
        <img src="<% out.print(userObject.get("image")); %>">
    </div>
    <div class="legend text-center">
        @<% out.print(userObject.get("username")); %>    </div>
    <div class="text-center">
        <% out.print(userObject.get("name")); %>    </div>
    <div class="text-center">
        <span><% if ((long) userObject.get("driver") == 0) out.print("Non-") ; %>Driver</span>
        <% if ((long) userObject.get("driver") != 0) { %>
        <span class="divider">&nbsp;</span>
        <span><img src="img/star.png" width="20px"><% out.print(driverAttribute.getAverageRating()); %> (<% out.print(driverAttribute.getNumberOfRating()); %> votes)</span>
            </div>
        <% } %>
    <div class="text-center">
        <% out.print(userObject.get("email")); %>    </div>
    <div class="text-center">
        <% out.print(userObject.get("phoneNumber")); %>    </div>
</div>
<div class="float-container row">
    <h2 class="title pull-left">PREFFERED LOCATION</h2>
    <div class="pull-right"><a href="editpreferredlocations.jsp?token=<% out.print(token); %>"><img src="img/edit.png"></a></div>
</div>
<div id="container-preffered-location" class="container">
        </div>
        </div>
    </body>
</html>
