package com.mycompany.login.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "HomeEstudianteServlet", urlPatterns = {"/homeEstudiante"})
public class HomeEstudianteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String usuario = null;
        String rol = null;

        if (session != null) {
            usuario = (String) session.getAttribute("usuario");
            rol = (String) session.getAttribute("rol");
        }

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("ADMIN".equalsIgnoreCase(rol)) {
            response.sendRedirect(request.getContextPath() + "/homeAdmin");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/homeEstudiante.jsp").forward(request, response);
    }
}
