package com.mycompany.login.servlets;

import com.mycompany.login.servlets.DatabaseConfig;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ConsultarEstadoServlet", urlPatterns = {"/consultarEstado"})
public class ConsultarEstadoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Mostrar el formulario de consulta
        request.getRequestDispatcher("/WEB-INF/consultarEstado.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String radicado = request.getParameter("radicado");

        if (radicado == null || radicado.trim().isEmpty()) {
            request.setAttribute("error", "Debes ingresar un número de radicado");
            request.getRequestDispatcher("/WEB-INF/consultarEstado.jsp").forward(request, response);
            return;
        }

        String sql = "SELECT tipo, fecha, lugar, descripcion, estado, creado FROM reportes WHERE radicado = ?";

        try (Connection con = DatabaseConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, radicado.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Encontrado - pasar datos al JSP
                    request.setAttribute("radicado", radicado);
                    request.setAttribute("tipo", rs.getString("tipo"));
                    request.setAttribute("fecha", rs.getDate("fecha"));
                    request.setAttribute("lugar", rs.getString("lugar"));
                    request.setAttribute("descripcion", rs.getString("descripcion"));
                    request.setAttribute("estado", rs.getString("estado"));
                    request.setAttribute("creado", rs.getTimestamp("creado"));
                    
                    System.out.println("Consulta de radicado: " + radicado + 
                                     " | Estado: " + rs.getString("estado"));
                    
                    request.getRequestDispatcher("/WEB-INF/consultarEstado.jsp").forward(request, response);
                } else {
                    // No encontrado
                    request.setAttribute("error", "No se encontró ningún reporte con ese radicado");
                    request.getRequestDispatcher("/WEB-INF/consultarEstado.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al consultar la base de datos");
            request.getRequestDispatcher("/WEB-INF/consultarEstado.jsp").forward(request, response);
        }
    }
}