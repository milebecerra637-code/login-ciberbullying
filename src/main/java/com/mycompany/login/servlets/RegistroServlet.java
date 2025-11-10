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

@WebServlet(name = "RegistroServlet", urlPatterns = {"/registro"})
public class RegistroServlet extends HttpServlet {

    private static final String URL = "jdbc:mysql://127.0.0.1:3307/login?useTimezone=true&serverTimezone=UTC&useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String edadStr = request.getParameter("edad");
        String curso = request.getParameter("curso");
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        if (usuario == null || usuario.trim().isEmpty() ||
            contrasena == null || contrasena.trim().isEmpty()) {
            request.setAttribute("error", "Usuario y contraseña son obligatorios");
            request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
            return;
        }

        int edad = 0;
        try {
            if (edadStr != null && !edadStr.trim().isEmpty()) {
                edad = Integer.parseInt(edadStr.trim());
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Edad inválida");
            request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error interno del servidor");
            request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
            return;
        }

        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {

            String checkUser = "SELECT COUNT(*) FROM usuarios WHERE nombre_usuario=?";
            try (PreparedStatement checkStmt = con.prepareStatement(checkUser)) {
                checkStmt.setString(1, usuario);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    request.setAttribute("error", "El nombre de usuario ya existe");
                    request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
                    return;
                }
            }

            String sql = "INSERT INTO usuarios (nombre, apellido, edad, curso, nombre_usuario, contrasena, rol) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, nombre);
                ps.setString(2, apellido);
                if (edad > 0) ps.setInt(3, edad);
                else ps.setNull(3, java.sql.Types.INTEGER);
                ps.setString(4, curso);
                ps.setString(5, usuario);
                ps.setString(6, contrasena); // En producción: hashear la contraseña
                ps.setString(7, "ESTUDIANTE");

                int filas = ps.executeUpdate();

                if (filas > 0) {
                    // Redirigir al servlet de login y pasar parametro para mostrar mensaje
                    response.sendRedirect(request.getContextPath() + "/login?registered=true");
                    return;
                } else {
                    request.setAttribute("error", "No se pudo registrar el usuario");
                    request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error de base de datos: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/registro.jsp").forward(request, response);
        }
    }
}