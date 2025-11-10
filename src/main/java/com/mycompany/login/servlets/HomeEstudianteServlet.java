package com.mycompany.login.servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "HomeEstudianteServlet", urlPatterns = {"/homeEstudiante"})
public class HomeEstudianteServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        String usuario = null;
        
        if (session != null) {
            usuario = (String) session.getAttribute("usuario");
        }
        
        // Verificar autenticación
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Direccionar a la vista de estudiante
        request.getRequestDispatcher("/WEB-INF/homeEstudiante.jsp").forward(request, response);
    }
}
