package com.mycompany.login.servlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/gestionarNoticias")
public class GestionarNoticiasServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/colegio_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "tu_password";
    
    public static class Noticia {
        private int id;
        private String titulo;
        private String contenido;
        private Timestamp fechaPublicacion;
        
        public Noticia(int id, String titulo, String contenido, Timestamp fechaPublicacion) {
            this.id = id;
            this.titulo = titulo;
            this.contenido = contenido;
            this.fechaPublicacion = fechaPublicacion;
        }
        
        public int getId() { return id; }
        public String getTitulo() { return titulo; }
        public String getContenido() { return contenido; }
        public Timestamp getFechaPublicacion() { return fechaPublicacion; }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || !"admin".equals(session.getAttribute("rol"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        List<Noticia> noticias = new ArrayList<>();
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT id, titulo, contenido, fecha_publicacion FROM noticias ORDER BY fecha_publicacion DESC";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                
                while (rs.next()) {
                    noticias.add(new Noticia(
                        rs.getInt("id"),
                        rs.getString("titulo"),
                        rs.getString("contenido"),
                        rs.getTimestamp("fecha_publicacion")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar noticias: " + e.getMessage());
        }
        
        request.setAttribute("noticias", noticias);
        request.getRequestDispatcher("/WEB-INF/gestionarNoticias.jsp").forward(request, response);
    }
}