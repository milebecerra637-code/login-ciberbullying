package com.mycompany.login.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    
    // Configuración de la base de datos
    private final String URL = "jdbc:mysql://localhost:3307/login?useTimezone=true&serverTimezone=UTC&useSSL=false";
    private final String USER = "root";
    private final String PASS = "";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");
        
        // Validar campos vacíos
        if (usuario == null || usuario.trim().isEmpty() || 
            contrasena == null || contrasena.trim().isEmpty()) {
            request.setAttribute("error", "Usuario y contraseña son requeridos");
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            return;
        }
        
        // Validar con la base de datos - Ahora retorna un array con [userId, rol]
        String[] datosUsuario = validarUsuario(usuario, contrasena);
        
        if (datosUsuario != null) {
            int userId = Integer.parseInt(datosUsuario[0]);
            String rol = datosUsuario[1];
            
            // Crear sesión y almacenar datos
            HttpSession session = request.getSession(true);
            session.setMaxInactiveInterval(3600); // 1 hora
            session.setAttribute("userId", userId);        // ← NUEVO: Guardar ID
            session.setAttribute("usuario", usuario);
            session.setAttribute("rol", rol);
            
            System.out.println(" Login exitoso - Usuario: " + usuario + " | Rol: " + rol + " | ID: " + userId);
            System.out.println(" ID Sesión: " + session.getId());
            
            // USAR FORWARD DIRECTO en lugar de redirect
            if ("ADMIN".equalsIgnoreCase(rol)) {
                System.out.println("➡️ Enviando a homeAdmin.jsp");
                request.getRequestDispatcher("/WEB-INF/homeAdmin.jsp").forward(request, response);
            } else {
                System.out.println("➡️ Enviando a homeEstudiante.jsp");
                request.getRequestDispatcher("/WEB-INF/homeEstudiante.jsp").forward(request, response);
            }
            return;
        } else {
            // Usuario incorrecto
            System.out.println(" Login fallido para usuario: " + usuario);
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        }
    }
    
    // ACTUALIZADO: Ahora retorna [userId, rol]
    private String[] validarUsuario(String usuario, String contrasena) {
        String[] resultado = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            // Usar driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASS);
            
            System.out.println("🔍 Buscando usuario: " + usuario);
            
            // ACTUALIZADO: Ahora también obtenemos el ID
            String sql = "SELECT id, contrasena, rol FROM usuarios WHERE nombre_usuario = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                int userId = rs.getInt("id");
                String contrasenaBD = rs.getString("contrasena");
                String rolBD = rs.getString("rol");
                
                System.out.println(" Usuario encontrado en BD");
                System.out.println("   ID: " + userId);
                System.out.println("   Contraseña BD: [" + contrasenaBD + "]");
                System.out.println("   Contraseña ingresada: [" + contrasena + "]");
                System.out.println("   ¿Coinciden? " + contrasena.equals(contrasenaBD));
                
                // Validar contraseña
                if (contrasena.equals(contrasenaBD)) {
                    // Si rol es null o vacío, asignar ESTUDIANTE por defecto
                    if (rolBD == null || rolBD.trim().isEmpty()) {
                        rolBD = "ESTUDIANTE";
                    }
                    // Retornar array con [userId, rol]
                    resultado = new String[]{String.valueOf(userId), rolBD};
                }
            } else {
                System.out.println("❌ Usuario NO encontrado en BD");
            }
            
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Driver MySQL no encontrado: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("❌ Error de base de datos: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Cerrar recursos en orden inverso
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return resultado;
    }
}