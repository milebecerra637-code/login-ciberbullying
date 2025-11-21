package com.mycompany.login.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/publicarNoticia")
public class PublicarNoticiaServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/colegio_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "tu_password";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || !"admin".equals(session.getAttribute("rol"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/publicarNoticia.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        
        if (session == null || !"admin".equals(session.getAttribute("rol"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String titulo = request.getParameter("titulo");
        String contenido = request.getParameter("contenido");
        Integer adminId = (Integer) session.getAttribute("userId");
        
        if (titulo == null || titulo.trim().isEmpty() || 
            contenido == null || contenido.trim().isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios");
            request.getRequestDispatcher("/WEB-INF/publicarNoticia.jsp").forward(request, response);
            return;
        }
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO noticias (titulo, contenido, admin_id) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, titulo);
                stmt.setString(2, contenido);
                stmt.setInt(3, adminId);
                
                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect(request.getContextPath() + "/homeAdmin");
                } else {
                    request.setAttribute("error", "Error al publicar noticia");
                    request.getRequestDispatcher("/WEB-INF/publicarNoticia.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en la base de datos: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/publicarNoticia.jsp").forward(request, response);
        }
    }
}