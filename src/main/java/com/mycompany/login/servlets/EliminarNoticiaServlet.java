package com.mycompany.login.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/eliminarNoticia")
public class EliminarNoticiaServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/colegio_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "tu_password";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
                String sql = "DELETE FROM noticias WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    
                    int rows = stmt.executeUpdate();
                    if (rows > 0) {
                        response.sendRedirect(request.getContextPath() + "/gestionarNoticias?success=deleted");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/gestionarNoticias?error=notfound");
                    }
                }
            }
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/gestionarNoticias?error=database");
        }
    }
}