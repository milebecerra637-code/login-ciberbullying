package com.mycompany.login.servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class logoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession s = request.getSession(false);
        if (s != null) {
            s.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login");
    }
}