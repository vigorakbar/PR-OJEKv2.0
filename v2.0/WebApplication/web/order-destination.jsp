<%-- 
    Document   : order-destination
    Created on : Nov 8, 2017, 1:00:27 PM
    Author     : Rizky Faramita
--%>


<%@page import="java.text.ParseException"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.apache.http.HttpEntity"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.entity.StringEntity"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.impl.client.HttpClientBuilder"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="java.net.URL"%>
<%@page import="org.json.simple.JSONObject"%>
<!--DOCTYPE html>-->
<html>

<!-- code for tabs learned from https://www.w3schools.com/w3css/w3css_tabulators.asp -->
    <%
        String message = null;
        if (request.getMethod().equals("POST")){
            JSONObject jsonForm = new JSONObject();
            URL obj = null;
            HttpClient httpClient = HttpClientBuilder.create().build();
            try {
                String pickingpoint = request.getParameter("pickingpoint");
                String destination = request.getParameter("destination");
                String prefdriver = request.getParameter("prefdriver");

                jsonForm.put("pickingpoint", pickingpoint);
                jsonForm.put("destination", destination);
                jsonForm.put("predriver", prefdriver);

                HttpPost postRequest = new HttpPost("http://localhost:8084/WebApplication/order-driver.jsp");
                StringEntity params = new StringEntity(jsonForm.toJSONString());
                postRequest.addHeader("content-type", "application/json");
                postRequest.setEntity(params);
                HttpResponse resp = httpClient.execute(postRequest);
                HttpEntity entity = resp.getEntity();
                String responseString = EntityUtils.toString(entity, "UTF-8");
                out.print(responseString);
		JSONParser parser = new JSONParser();
		JSONObject jsonResp = new JSONObject();

                Integer statusCode = resp.getStatusLine().getStatusCode();
                if (statusCode == 200) {
                    //berhasil register
                    session.setAttribute("token", jsonResp.get("token"));
                    out.print("<script>alert('test"+jsonResp.get("error")+"')</script>");
                    JSONObject userJson = (JSONObject) jsonResp.get("user");
                    response.sendRedirect("order-driver.jsp");
                    return;
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
    <title>ORDER</title>
    <meta charset="UTF-8">
    <meta name="description" content="order an OJEK">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/order.css">
</head>

<body>
<div id="outer-wrapper">
    <div id="inner-wrapper">
        <div id="title" class="wrapper">
            <h2>MAKE AN ORDER</h2>
        </div>

        <div id="tab" class="wrapper">
            <div id="destination" class="left tab-item">
                <div class="circle">
                    1
                </div>
                <p class="tab-message">
                    Select Destination
                </p>
            </div>

            <div id="select" class="middle tab-item">
                <div class="circle">
                    2
                </div>
                <p class="tab-message">
                    Select a Driver
                </p>
            </div>

            <div id="complete" class="right tab-item">
                <div class="circle">
                    3
                </div>
                <p class="tab-message">
                    Complete your order
                </p>
            </div>
        </div>

        <div id="content" class="wrapper">
            <form action="" method="POST">
                <div class="form">
                    <div class="form-name">
                        Picking point
                    </div>
                    <div class="form-input">

                        <input class="destination" type="text" name="picking-point">

                    </div>
                </div>

                <div class="form">
                    <div class="form-name">
                        Destination
                    </div>
                    <div class="form-input">

                        <input class="destination" type="text" name="destination">

                    </div>
                </div>

                <div class="form">
                    <div class="form-name">
                        Preferred Driver
                    </div>
                    <div class="form-input">

                        <input class="destination" type="text" name="preferred-driver" placeholder="(optional)">

                    </div>
                </div>

                <div class="break">
                </div>
                <div class="button-wrapper">
                    <a href="order-driver.jsp">
                            <input class="destination" type="submit" value="Next">
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>

</html>
