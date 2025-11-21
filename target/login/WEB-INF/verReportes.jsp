<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.login.servlets.VerReportesServlet.Reporte" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestionar Reportes</title>
    <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root{
            --accent:#02a6c1;
            --bg:#eaf8fb;
            --card-dark-1:#053447;
            --radius:16px;
        }
        *{box-sizing:border-box;margin:0;padding:0}
        body{
            font-family:'Baloo 2', sans-serif;
            background: linear-gradient(180deg,#e6fbff, var(--bg));
            min-height:100vh;
            padding:28px;
        }
        .container{max-width:1200px;margin:0 auto}
        h1{color:var(--card-dark-1);margin-bottom:30px;font-size:2.2em}
        .success, .error{
            padding:15px;
            border-radius:12px;
            margin-bottom:20px;
            font-weight:600;
        }
        .success{background:#c6f6d5;color:#22543d;border-left:4px solid #38a169}
        .error{background:#fed7d7;color:#c53030;border-left:4px solid #c53030}
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
        .reporte-card{
            background:white;
            border-radius:var(--radius);
            padding:25px;
            margin-bottom:20px;
            box-shadow:0 4px 16px rgba(2,40,60,0.08);
            border-left:4px solid var(--accent);
        }
        .reporte-header{
            display:flex;
            justify-content:space-between;
            align-items:start;
            margin-bottom:15px;
            gap:20px;
        }
        .reporte-info h3{color:var(--card-dark-1);font-size:1.4em;margin-bottom:8px}
        .reporte-meta{
            display:flex;
            gap:20px;
            flex-wrap:wrap;
            color:#6b8894;
            font-size:0.9em;
            margin-bottom:15px;
        }
        .badge{
            display:inline-block;
            padding:5px 12px;
            border-radius:20px;
            font-size:0.85em;
            font-weight:700;
        }
        .badge-pendiente{background:#fef3c7;color:#92400e}
        .badge-proceso{background:#dbeafe;color:#1e40af}
        .badge-resuelto{background:#d1fae5;color:#065f46}
        .reporte-descripcion{
            color:#2d3748;
            line-height:1.6;
            margin:15px 0;
            padding:15px;
            background:#f7fafc;
            border-radius:8px;
        }
        .btn{
            padding:10px 20px;
            border:none;
            border-radius:10px;
            font-weight:700;
            cursor:pointer;
            text-decoration:none;
            display:inline-block;
            transition:all 0.3s;
            font-family:inherit;
            font-size:0.95em;
        }
        .btn-primary{
            background:linear-gradient(135deg,#0288a7,#06b6d4);
            color:white;
        }
        .btn-primary:hover{transform:translateY(-2px);box-shadow:0 8px 20px rgba(2,136,167,0.3)}
        .btn-back{
            background:rgba(2,166,193,0.1);
            color:var(--accent);
            margin-top:20px;
        }
        .no-reportes{
            background:white;
            border-radius:var(--radius);
            padding:60px;
            text-align:center;
            color:#6b8894;
        }
        @media (max-width: 768px){
            .reporte-header{flex-direction:column}
            .stats{grid-template-columns:1fr}
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📊 Gestionar Reportes</h1>
        
        <% 
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if ("updated".equals(success)) {
        %>
            <div class="success">✅ Reporte actualizado correctamente</div>
        <% } else if ("notfound".equals(error)) { %>
            <div class="error">⚠️ Reporte no encontrado</div>
        <% } else if ("database".equals(error)) { %>
            <div class="error">⚠️ Error en la base de datos</div>
        <% } %>
        
        <%
            List<Reporte> reportes = (List<Reporte>) request.getAttribute("reportes");
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            
            int totalReportes = reportes != null ? reportes.size() : 0;
            int pendientes = 0, enProceso = 0, resueltos = 0;
            
            if (reportes != null) {
                for (Reporte r : reportes) {
                    if ("pendiente".equals(r.getEstado())) pendientes++;
                    else if ("en_proceso".equals(r.getEstado())) enProceso++;
                    else if ("resuelto".equals(r.getEstado())) resueltos++;
                }
            }
        %>
        
        <div class="stats">
            <div class="stat-card">
                <h3><%= totalReportes %></h3>
                <p>Total Reportes</p>
            </div>
            <div class="stat-card">
                <h3><%= pendientes %></h3>
                <p>⏳ Pendientes</p>
            </div>
            <div class="stat-card">
                <h3><%= enProceso %></h3>
                <p>🔄 En Proceso</p>
            </div>
            <div class="stat-card">
                <h3><%= resueltos %></h3>
                <p>✅ Resueltos</p>
            </div>
        </div>
        
        <%
            if (reportes != null && !reportes.isEmpty()) {
                for (Reporte reporte : reportes) {
                    String badgeClass = "";
                    String estadoTexto = "";
                    if ("pendiente".equals(reporte.getEstado())) {
                        badgeClass = "badge-pendiente";
                        estadoTexto = "⏳ Pendiente";
                    } else if ("en_proceso".equals(reporte.getEstado())) {
                        badgeClass = "badge-proceso";
                        estadoTexto = "🔄 En Proceso";
                    } else {
                        badgeClass = "badge-resuelto";
                        estadoTexto = "✅ Resuelto";
                    }
        %>
                    <div class="reporte-card">
                        <div class="reporte-header">
                            <div class="reporte-info">
                                <h3><%= reporte.getTitulo() %></h3>
                                <div class="reporte-meta">
                                    <span>📋 <strong>Código:</strong> <%= reporte.getCodigoReporte() %></span>
                                    <span>👤 <strong>Estudiante:</strong> <%= reporte.getNombreEstudiante() %></span>
                                    <span>📅 <%= sdf.format(reporte.getFechaReporte()) %></span>
                                </div>
                            </div>
                            <span class="badge <%= badgeClass %>"><%= estadoTexto %></span>
                        </div>
                        
                        <div class="reporte-descripcion">
                            <strong>Descripción:</strong><br>
                            <%= reporte.getDescripcion() %>
                        </div>
                        
                        <% if (reporte.getComentariosAdmin() != null && !reporte.getComentariosAdmin().isEmpty()) { %>
                            <div style="background:#e6f7ff;padding:15px;border-radius:8px;margin-top:15px">
                                <strong style="color:#1e40af">💬 Comentarios del Admin:</strong><br>
                                <%= reporte.getComentariosAdmin() %>
                            </div>
                        <% } %>
                        
                        <a href="<%= request.getContextPath() %>/actualizarReporte?id=<%= reporte.getId() %>" 
                           class="btn btn-primary" style="margin-top:15px">
                            ✏️ Actualizar Estado
                        </a>
                    </div>
        <%
                }
            } else {
        %>
                <div class="no-reportes">
                    <p style="font-size:3em;margin-bottom:20px">📭</p>
                    <p style="font-size:1.3em">No hay reportes en el sistema</p>
                </div>
        <%
            }
        %>
        
        <a href="<%= request.getContextPath() %>/homeAdmin" class="btn btn-back">
            ← Volver al panel
        </a>
    </div>
</body>
</html>