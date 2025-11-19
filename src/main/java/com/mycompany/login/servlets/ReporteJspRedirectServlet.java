package com.mycompany.login.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Usuario
 */
@WebServlet(name = "ReporteJspRedirectServlet", urlPatterns = {"/reporte.jsp"})
public class ReporteJspRedirectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/reportar.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Si alguien hace POST a /reporte.jsp mantenemos el flujo y lo procesamos con ReportarServlet
        request.getRequestDispatcher("/WEB-INF/reportar.jsp").forward(request, response);
    }
}