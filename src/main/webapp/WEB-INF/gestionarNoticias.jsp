package com.mycompany.login.servlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/gestionarNoticias")
public class GestionarNoticiasServlet extends HttpServlet {
    
    public static class Noticia {
        private int id;
        private String titulo;
        private String contenido;
        private Timestamp fechaPublicacion;
        
        public Noticia(int id, String titulo, String contenido, Timestamp fechaPublicacion) {
            this.id = id;
            this.titulo = titulo;
            this.contenido = contenido;
            this.fechaPublicacion = fechaPublicacion;
        }
        
        public int getId() { return id; }
        public String getTitulo() { return titulo; }
        public String getContenido() { return contenido; }
        public Timestamp getFechaPublicacion() { return fechaPublicacion; }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || !"ADMIN".equalsIgnoreCase((String)session.getAttribute("rol"