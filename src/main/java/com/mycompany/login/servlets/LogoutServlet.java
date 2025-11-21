package com.mycompany.login.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            String usuario = (String) session.getAttribute("usuario");
            System.out.println("🚪 Cerrando sesión: " + usuario);
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/login");
    }
}