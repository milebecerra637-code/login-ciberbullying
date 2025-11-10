package com.mycompany.login.servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "HomeAdminServlet", urlPatterns = {"/homeAdmin"})
public class HomeAdminServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        String usuario = null;
        String rol = null;
        
        if (session != null) {
            usuario = (String) session.getAttribute("usuario");
            rol = (String) session.getAttribute("rol");
        }
        
        // Verificar autenticación
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Verificar que sea administrador
        if (!"ADMIN".equalsIgnoreCase(rol)) {
            response.sendRedirect(request.getContextPath() + "/homeEstudiante");
            return;
        }
        
        // Direccionar a la vista de administrador
        request.getRequestDispatcher("/WEB-INF/homeAdmin.jsp").forward(request, response);
    }
}