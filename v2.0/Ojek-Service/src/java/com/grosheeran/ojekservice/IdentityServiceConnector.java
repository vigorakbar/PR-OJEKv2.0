/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.ojekservice;

import com.grosheeran.identityservice.soap.User;
import com.grosheeran.identityservice.soap.ValidateTokenSOAP;
import java.net.MalformedURLException;
import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;

/**
 *
 * @author kingfalcon
 */
public class IdentityServiceConnector {
    public User getUserFromToken(String token) {
        try {
            URL wsdlUrl = new URL("http://localhost:8080/Identity-Service/ValidateTokenSOAP?wsdl");
            QName qname = new QName("http://soap.identityservice.grosheeran.com/", "ValidateTokenSOAP");
            QName qnamePort = new QName("http://soap.identityservice.grosheeran.com/", "ValidateTokenSOAPPort");
            Service service = Service.create(wsdlUrl, qname);
            ValidateTokenSOAP validator = service.getPort(qnamePort, ValidateTokenSOAP.class);

            User user = validator.validate(token);

            return user;
        }
        catch (Exception e) {
            User user = new User();
            user.setUserId(-1);
            user.setName(e.getMessage());
            return user;
        }
    }
}
