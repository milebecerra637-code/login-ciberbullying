package com.mycompany.login.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private static final String URL = "jdbc:mysql://127.0.0.1:3307/login?useTimezone=true&serverTimezone=UTC&useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        if (usuario == null || usuario.trim().isEmpty() || contrasena == null || contrasena.trim().isEmpty()) {
            request.setAttribute("error", "Usuario y contraseña son requeridos.");
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error interno (driver DB).");
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            return;
        }

        // Roles
        String sql = "SELECT contrasena, rol FROM usuarios WHERE nombre_usuario = ?";

        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, usuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashEnBD = rs.getString("contrasena");
                    String rol = rs.getString("rol"); // NUEVO: Obtener rol
                    
                    // Si el rol es null, asignar ESTUDIANTE por defecto
                    if (rol == null || rol.trim().isEmpty()) {
                        rol = "ESTUDIANTE";
                    }
                    
                    boolean autenticado = false;

                    if (hashEnBD != null) {
                        String lower = hashEnBD.toLowerCase();
                        if (lower.startsWith("$2a$") || lower.startsWith("$2b$") || lower.startsWith("$2y$")) {
                            autenticado = BCrypt.checkpw(contrasena, hashEnBD);
                        } else {
                            // Fallback: texto plano -> comparar y re-hashear
                            if (contrasena.equals(hashEnBD)) {
                                autenticado = true;
                                String nuevoHash = BCrypt.hashpw(contrasena, BCrypt.gensalt(12));
                                String upd = "UPDATE usuarios SET contrasena = ? WHERE nombre_usuario = ?";
                                try (PreparedStatement ups = con.prepareStatement(upd)) {
                                    ups.setString(1, nuevoHash);
                                    ups.setString(2, usuario);
                                    ups.executeUpdate();
                                } catch (SQLException uex) {
                                    uex.printStackTrace();
                                }
                            }
                        }
                    }

                    if (autenticado) {
                        HttpSession session = request.getSession(true);
                        session.setAttribute("usuario", usuario);
                        session.setAttribute("rol", rol); // NUEVO: Guardar rol en sesión
                        
                        // NUEVO: Redirigir según el rol
                        if ("ADMIN".equalsIgnoreCase(rol)) {
                            response.sendRedirect(request.getContextPath() + "/homeAdmin");
                        } else {
                            response.sendRedirect(request.getContextPath() + "/homeEstudiante");
                        }
                        return;
                    }
                }

                request.setAttribute("error", "Usuario o contraseña incorrectos");
                request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error de base de datos. Revisa logs.");
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        }
    }
}