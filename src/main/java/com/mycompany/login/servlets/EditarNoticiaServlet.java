package com.mycompany.login.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/editarNoticia")
public class EditarNoticiaServlet extends HttpServlet {
    
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
        
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/gestionarNoticias");
            return;
        }
        
        try {
            int id = Integer.parseInt(idParam);
            
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT id, titulo, contenido FROM noticias WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            request.setAttribute("noticiaId", rs.getInt("id"));
                            request.setAttribute("noticiaTitulo", rs.getString("titulo"));
                            request.setAttribute("noticiaContenido", rs.getString("contenido"));
                            request.getRequestDispatcher("/WEB-INF/editarNoticia.jsp").forward(request, response);
                        } else {
                            response.sendRedirect(request.getContextPath() + "/gestionarNoticias");
                        }
                    }
                }
            }
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/gestionarNoticias");
        }
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
        
        String idParam = request.getParameter("id");
        String titulo = request.getParameter("titulo");
        String contenido = request.getParameter("contenido");
        
        if (idParam == null || titulo == null || titulo.trim().isEmpty() || 
            contenido == null || contenido.trim().isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios");
            request.setAttribute("noticiaId", idParam);
            request.setAttribute("noticiaTitulo", titulo);
            request.setAttribute("noticiaContenido", contenido);
            request.getRequestDispatcher("/WEB-INF/editarNoticia.jsp").forward(request, response);
            return;
        }
        
        try {
            int id = Integer.parseInt(idParam);
            
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "UPDATE noticias SET titulo = ?, contenido = ? WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, titulo);
                    stmt.setString(2, contenido);
                    stmt.setInt(3, id);
                    
                    int rows = stmt.executeUpdate();
                    if (rows > 0) {
                        response.sendRedirect(request.getContextPath() + "/gestionarNoticias?success=updated");
                    } else {
                        request.setAttribute("error", "No se pudo actualizar la noticia");
                        request.getRequestDispatcher("/WEB-INF/editarNoticia.jsp").forward(request, response);
                    }
                }
            }
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al actualizar: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/editarNoticia.jsp").forward(request, response);
        }
    }
}