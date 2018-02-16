<%-- 
    Document   : history
    Created on : Nov 8, 2017, 10:04:45 PM
    Author     : kingfalcon
--%>

<%@page import="com.grosheeran.ojekservice.soap.Rating"%>
<%@page import="com.grosheeran.identityservice.soap.User"%>
<%@page import="com.grosheeran.ojekservice.soap.GetRatingFromOrderId"%>
<%@page import="com.grosheeran.identityservice.soap.GetUserFromUserId"%>
<%@page import="com.grosheeran.ojekservice.soap.GetDriverHistory"%>
<%@page import="com.grosheeran.ojekservice.soap.HideOrderFromUser"%>
<%@page import="java.util.List"%>
<%@page import="com.grosheeran.ojekservice.soap.Order"%>
<%@page import="com.grosheeran.ojekservice.soap.GetPreviousOrder"%>
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
    
    String action = request.getParameter("action");
    
    if (action != null) {
        if (action.equals("hide")) {
            String sOrderId = request.getParameter("order_id");
            if (sOrderId != null) {
                int orderId = Integer.parseInt(sOrderId);

                URL wsdlUrl = new URL("http://localhost:8080/Ojek-Service/HideOrderFromDriver?wsdl");
                QName qname = new QName("http://soap.ojekservice.grosheeran.com/", "HideOrderFromDriver");
                QName qnamePort = new QName("http://soap.ojekservice.grosheeran.com/", "HideOrderFromDriverPort");
                Service service = Service.create(wsdlUrl, qname);
                HideOrderFromUser hofu = service.getPort(qnamePort, HideOrderFromUser.class);

                int berhasil = hofu.hideOrderFromUser(orderId);
                if (berhasil == 1) {
                    response.sendRedirect("order_history.jsp?token=" + token);
                    return;
                }
                else {
                    out.print("Error code: " + Integer.toString(berhasil) + "<br />");
                }
            }
        }
    }
    
    String json = EntityUtils.toString(rawResponse.getEntity());
    userObject = (JSONObject) (new JSONParser()).parse(json);
    
    URL wsdlUrlGDH = new URL("http://localhost:8080/Ojek-Service/GetDriverHistory?wsdl");
    QName qnameGDH = new QName("http://soap.ojekservice.grosheeran.com/", "GetDriverHistory");
    QName qnamePortGDH = new QName("http://soap.ojekservice.grosheeran.com/", "GetDriverHistoryPort");
    Service serviceGDH = Service.create(wsdlUrlGDH, qnameGDH);
    GetDriverHistory gdh = serviceGDH.getPort(qnamePortGDH, GetDriverHistory.class);
    
    URL wsdlUrlGU = new URL("http://localhost:8080/Identity-Service/GetUserFromUserId?wsdl");
    QName qnameGU = new QName("http://soap.identityservice.grosheeran.com/", "GetUserFromUserId");
    QName qnamePortGU = new QName("http://soap.identityservice.grosheeran.com/", "GetUserFromUserIdPort");
    Service serviceGU = Service.create(wsdlUrlGU, qnameGU);
    GetUserFromUserId gu = serviceGU.getPort(qnamePortGU, GetUserFromUserId.class);
    
    URL wsdlUrlGR = new URL("http://localhost:8080/Ojek-Service/GetRatingFromOrderId?wsdl");
    QName qnameGR = new QName("http://soap.ojekservice.grosheeran.com/", "GetRatingFromOrderId");
    QName qnamePortGR = new QName("http://soap.ojekservice.grosheeran.com/", "GetRatingFromOrderIdPort");
    Service serviceGR = Service.create(wsdlUrlGR, qnameGR);
    GetRatingFromOrderId gr = serviceGR.getPort(qnamePortGR, GetRatingFromOrderId.class);
    
    List<Order> orders = gdh.getDriverHistory((String) token);
    
    out.print("<a href='history.jsp?token=" + token + "'>Previous Orders</a><br />");
    
    if (orders.size() == 0) {
        out.print("Tidak ada driver history.");
    }
    else {
        out.print("Daftar Driver History:<br/>");
        out.print("<ul>");
        for (Order order : orders) {
            User driver = gu.getUserFromUserId(order.getUserId());
            Rating rating = gr.getRatingFromOrderId(order.getId());
            
            String ratingString;
            
            if (rating.getId() == -1) {
                ratingString = "tidak ada info rating";
            }
            else {
                ratingString = "mendapat rating " + Integer.toString(rating.getRating()) + " dengan komentar '" + rating.getComment() + "'";
            }
            
            out.print("<li>[" + order.getTimestamp().toString() + "] Dari " + order.getPickingpoint() + " ke " + order.getDestination() + " mengantar " + driver.getName() + ", " + ratingString + ". <a href='history.jsp?token=" + token + "&order_id=" + order.getId() + "&action=hide'>Hide</a></li><br />");
        }
        out.print("</ul>");
    }
%>  