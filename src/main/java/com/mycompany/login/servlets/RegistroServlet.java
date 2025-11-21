package com.mycompany.login.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/registro"})
public class RegistroServlet extends HttpServlet {
    
    private final String URL = "jdbc:mysql://localhost:3307/login?useTimezone=true&serverTimezone=UTC&useSSL=false";
    private final String USER = "root";
    private final String PASS = "";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String nombreUsuario = request.getParameter("nombre_usuario");
        String contrasena = request.getParameter("contrasena");
        String confirmarContrasena = request.getParameter("confirmar_contrasena");
        String rol = request.getParameter("rol");
        
        // Validaciones
        if (nombreUsuario == null || nombreUsuario.trim().isEmpty() ||
            contrasena == null || contrasena.trim().isEmpty() ||
            confirmarContrasena == null || confirmarContrasena.trim().isEmpty() ||
            rol == null || rol.trim().isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios");
            request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
            return;
        }
        
        if (!contrasena.equals(confirmarContrasena)) {
            request.setAttribute("error", "Las contraseñas no coinciden");
            request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
            return;
        }
        
        // Registrar usuario
        if (registrarUsuario(nombreUsuario, contrasena, rol)) {
            response.sendRedirect(request.getContextPath() + "/login?registro=exitoso");
        } else {
            request.setAttribute("error", "Error al registrar usuario. El nombre de usuario puede estar en uso.");
            request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
        }
    }
    
    private boolean registrarUsuario(String nombreUsuario, String contrasena, String rol) {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASS);
            
            String sql = "INSERT INTO usuarios (nombre_usuario, contrasena, rol) VALUES (?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, nombreUsuario);
            ps.setString(2, contrasena);
            ps.setString(3, rol);
            
            int rows = ps.executeUpdate();
            return rows > 0;
            
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Driver MySQL no encontrado: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (SQLException e) {
            System.err.println("❌ Error al registrar usuario: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}