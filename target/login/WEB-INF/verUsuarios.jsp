<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.login.servlets.VerUsuariosServlet.Usuario" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ver Usuarios</title>
    <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root{--accent:#02a6c1;--bg:#eaf8fb;--card-dark-1:#053447;--radius:16px}
        *{box-sizing:border-box;margin:0;padding:0}
        body{
            font-family:'Baloo 2', sans-serif;
            background:linear-gradient(180deg,#e6fbff, var(--bg));
            min-height:100vh;
            padding:28px;
        }
        .container{max-width:1200px;margin:0 auto}
        h1{color:var(--card-dark-1);margin-bottom:30px;font-size:2.2em}
        .stats{
            display:grid;
            grid-template-columns:repeat(auto-fit, minmax(200px, 1fr));
            gap:15px;
            margin-bottom:30px;
        }
        .stat-card{
            background:white;
            padding:20px;
            border-radius:var(--radius);
            box-shadow:0 4px 16px rgba(2,40,60,0.08);
            text-align:center;
        }
        .stat-card h3{font-size:2em;color:var(--accent);margin-bottom:5px}
        .stat-card p{color:#6b8894;font-size:0.95em}
        table{
            width:100%;
            background:white;
            border-radius:var(--radius);
            overflow:hidden;
            box-shadow:0 4px 16px rgba(2,40,60,0.08);
        }
        thead{background:linear-gradient(135deg,var(--card-dark-1),#02475a)}
        th{
            padding:18px;
            text-align:left;
            color:white;
            font-weight:700;
            font-size:0.95em;
        }
        td{
            padding:18px;
            border-bottom:1px solid #e2e8f0;
            color:#2d3748;
        }
        tr:hover{background:#f7fafc}
        .badge{
            display:inline-block;
            padding:5px 12px;
            border-radius:20px;
            font-size:0.85em;
            font-weight:700;
        }
        .badge-admin{background:#fef3c7;color:#92400e}
        .badge-estudiante{background:#dbeafe;color:#1e40af}
        .btn-back{
            display:inline-block;
            background:rgba(2,166,193,0.1);
            color:var(--accent);
            padding:12px 25px;
            border-radius:10px;
            text-decoration:none;
            font-weight:700;
            margin-top:20px;
            transition:all 0.3s;
        }
        .btn-back:hover{background:rgba(2,166,193,0.2)}
        @media (max-width: 768px){
            table{font-size:0.9em}
            th, td{padding:12px 8px}
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>👥 Usuarios Registrados</h1>
        
        <%
            List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
            int totalUsuarios = usuarios != null ? usuarios.size() : 0;
            int admins = 0, estudiantes = 0;
            
            if (usuarios != null) {
                for (Usuario u : usuarios) {
                    if ("ADMIN".equalsIgnoreCase(u.getRol())) admins++;
                    else estudiantes++;
                }
            }
        %>
        
        <div class="stats">
            <div class="stat-card">
                <h3><%= totalUsuarios %></h3>
                <p>Total Usuarios</p>
            </div>
            <div class="stat-card">
                <h3><%= admins %></h3>
                <p>🛡️ Administradores</p>
            </div>
            <div class="stat-card">
                <h3><%= estudiantes %></h3>
                <p>? Estudiantes</p>
            </div>
        </div>
        
        <% if (usuarios != null && !usuarios.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Rol</th>
                        <th>Reportes</th>
                        <th>Fecha Registro</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        for (Usuario usuario : usuarios) {
                    %>
                        <tr>
                            <td><%= usuario.getId() %></td>
                            <td><strong><%= usuario.getNombre() %></strong></td>
                            <td><%= usuario.getEmail() %></td>
                            <td>
                                <span class="badge <%= "ADMIN".equalsIgnoreCase(usuario.getRol()) ? "badge-admin" : "badge-estudiante" %>">
                                    <%= "ADMIN".equalsIgnoreCase(usuario.getRol()) ? "🛡️ ADMIN" : "🎓 Estudiante" %>
                                </span>
                            </td>
                            <td><%= usuario.getNumReportes() %></td>
                            <td><%= sdf.format(usuario.getFechaCreacion()) %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <% } else { %>
            <div style="background:white;padding:60px;text-align:center;border-radius:var(--radius)">
                <p style="font-size:3em;margin-bottom:20px">👥</p>
                <p style="font-size:1.3em;color:#6b8894">No hay usuarios registrados</p>
            </div>
        <% } %>
        
        <a href="<%= request.getContextPath() %>/homeAdmin" class="btn-back">
            ← Volver al panel
        </a>
    </div>
</body>
</html>