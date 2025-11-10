package com.mycompany.login.servlets;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ReportarServlet", urlPatterns = {"/reportar"})
public class ReportarServlet extends HttpServlet {

    private static final String URL = "jdbc:mysql://127.0.0.1:3307/login?useTimezone=true&serverTimezone=UTC&useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/reportar.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String tipo = request.getParameter("tipo");
        String fecha = request.getParameter("fecha"); // yyyy-MM-dd
        String lugar = request.getParameter("lugar");
        String descripcion = request.getParameter("descripcion");
        String anonimo = request.getParameter("anonimo");
        boolean isAnonimo = "true".equals(anonimo);

        if (descripcion == null || descripcion.trim().isEmpty() || tipo == null || tipo.trim().isEmpty()) {
            request.setAttribute("error", "Tipo y descripción son obligatorios");
            request.getRequestDispatcher("/WEB-INF/reportar.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error interno del servidor (driver JDBC)");
            request.getRequestDispatcher("/WEB-INF/reportar.jsp").forward(request, response);
            return;
        }

        final String createTable = "CREATE TABLE IF NOT EXISTS `reportes` ("
                + "`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, "
                + "`radicado` VARCHAR(64) UNIQUE DEFAULT NULL, "
                + "`tipo` VARCHAR(64) NOT NULL, "
                + "`fecha` DATE DEFAULT NULL, "
                + "`lugar` VARCHAR(255) DEFAULT NULL, "
                + "`descripcion` TEXT NOT NULL, "
                + "`anonimo` TINYINT(1) NOT NULL DEFAULT 0, "
                + "`usuario` VARCHAR(100) DEFAULT NULL, "
                + "`estado` VARCHAR(32) NOT NULL DEFAULT 'Pendiente', "
                + "`creado` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP"
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

        final String sqlInsert = "INSERT INTO reportes (tipo, fecha, lugar, descripcion, anonimo, estado) VALUES (?, ?, ?, ?, ?, ?)";
        final String sqlUpdateRadicado = "UPDATE reportes SET radicado = ? WHERE id = ?";

        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {

            // Crear tabla si no existe (solo la primera vez)
            try (Statement stmt = con.createStatement()) {
                stmt.execute(createTable);
            }

            // Insertamos el reporte y recuperamos la llave generada (id)
            try (PreparedStatement ps = con.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, tipo);

                if (fecha != null && !fecha.trim().isEmpty()) {
                    try {
                        Date sqlFecha = Date.valueOf(fecha);
                        ps.setDate(2, sqlFecha);
                    } catch (IllegalArgumentException ex) {
                        ps.setNull(2, java.sql.Types.DATE);
                    }
                } else {
                    ps.setNull(2, java.sql.Types.DATE);
                }

                ps.setString(3, (lugar != null ? lugar : ""));
                ps.setString(4, descripcion);
                ps.setBoolean(5, isAnonimo);

                // Estado inicial: Pendiente
                ps.setString(6, "Pendiente");

                int affected = ps.executeUpdate();
                if (affected == 0) {
                    request.setAttribute("error", "No se pudo guardar el reporte");
                    request.getRequestDispatcher("/WEB-INF/reportar.jsp").forward(request, response);
                    return;
                }

                // Obtener id generado (primero via getGeneratedKeys, si falla fallback a LAST_INSERT_ID())
                long generatedId = -1;
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys != null && keys.next()) {
                        generatedId = keys.getLong(1);
                    }
                } catch (SQLException ex) {
                    // continuamos y probamos el fallback
                    generatedId = -1;
                }

                if (generatedId == -1) {
                    try (Statement s2 = con.createStatement();
                         ResultSet rs = s2.executeQuery("SELECT LAST_INSERT_ID()")) {
                        if (rs.next()) {
                            generatedId = rs.getLong(1);
                        }
                    } catch (SQLException ex) {
                        // si sigue fallando, registramos error
                        ex.printStackTrace();
                    }
                }

                if (generatedId == -1) {
                    request.setAttribute("error", "El reporte se guardó pero no se pudo recuperar el identificador generado.");
                    request.getRequestDispatcher("/WEB-INF/reportar.jsp").forward(request, response);
                    return;
                }

                // Generar radicado a partir de fecha/hora + id (garantiza unicidad)
                LocalDateTime now = LocalDateTime.now();
                String timestamp = now.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
                String radicado = "R" + timestamp + String.format("%06d", Math.max(0, generatedId));

                // Actualizar fila con el radicado
                try (PreparedStatement upd = con.prepareStatement(sqlUpdateRadicado)) {
                    upd.setString(1, radicado);
                    upd.setLong(2, generatedId);
                    upd.executeUpdate();
                }

                // Redirigir usando PRG y pasando radicado para que el JSP lo muestre (redirigimos a /reportar)
                String encoded = URLEncoder.encode(radicado, "UTF-8");
                response.sendRedirect(request.getContextPath() + "/reportar?success=true&radicado=" + encoded);
                return;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al guardar el reporte: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/reportar.jsp").forward(request, response);
        }
    }
}