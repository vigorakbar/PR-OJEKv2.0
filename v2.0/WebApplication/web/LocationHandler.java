/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;

/**
 *
 * @author Asus
 */
@WebServlet(urlPatterns = {"/LocationHandler"})
public class LocationHandler extends HttpServlet {

    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
                        String location = (String) requestObject.get("location");
                        //kirim ke Web service
                        URL url = new URL("http://localhost:8080/Ojek-Service/addPreferredLocation?wsdl");
                        QName qname = new QName("http://ws.mkyong.com/", "addPreferredLocation");
                        Service service = Service.create(url, qname);
                        
                } catch(Exception e) {
                    
                }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
