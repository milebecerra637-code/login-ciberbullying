package com.mycompany.login.servlets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Configuración centralizada de base de datos
 * Soporta tanto MySQL (local) como PostgreSQL (Render)
 */
public class DatabaseConfig {
    
    private static final String DB_URL;
    private static final String DB_USER;
    private static final String DB_PASSWORD;
    private static final String DB_DRIVER;
    
    static {
        // Detectar si estamos en Render (PostgreSQL) o local (MySQL)
        String databaseUrl = System.getenv("DATABASE_URL");
        
        if (databaseUrl != null && !databaseUrl.isEmpty()) {
            // Estamos en Render con PostgreSQL
            DB_URL = databaseUrl;
            DB_USER = null; // No se necesita, está en la URL
            DB_PASSWORD = null;
            DB_DRIVER = "org.postgresql.Driver";
        } else {
            // Desarrollo local con MySQL
            DB_URL = "jdbc:mysql://127.0.0.1:3307/login?useTimezone=true&serverTimezone=UTC&useSSL=false";
            DB_USER = "root";
            DB_PASSWORD = "";
            DB_DRIVER = "com.mysql.cj.jdbc.Driver";
        }
    }
    
    /**
     * Obtiene una conexión a la base de datos
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DB_DRIVER);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver de base de datos no encontrado: " + DB_DRIVER, e);
        }
        
        if (DB_USER != null) {
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } else {
            // PostgreSQL en Render - la URL ya incluye credenciales
            return DriverManager.getConnection(DB_URL);
        }
    }
    
    /**
     * Verifica si estamos usando PostgreSQL
     */
    public static boolean isPostgreSQL() {
        return DB_DRIVER.contains("postgresql");
    }
    
    /**
     * Obtiene el tipo de base de datos para logging
     */
    public static String getDatabaseType() {
        return isPostgreSQL() ? "PostgreSQL" : "MySQL";
    }
}