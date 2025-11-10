<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
  String usuario = (String) session.getAttribute("usuario");
  if (usuario == null) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
  }

  List<?> noticias = (List<?>) request.getAttribute("noticias");
  if (noticias == null) {
      noticias = new ArrayList<>();
  }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Portal Estudiantil — Contra el Ciberbullying</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
  <style>
    body { font-family: "Baloo 2", sans-serif; margin: 0; background: linear-gradient(180deg, #e6fbff 0%, #eaf9ff 100%); color: #333; min-height: 100vh; }
    .wrap { max-width: 1100px; margin: 24px auto; padding: 20px; }
    .hero-banner { background: linear-gradient(135deg, #00a6c9, #06b6d4); color: white; text-align: center; padding: 34px 20px; border-radius: 18px; box-shadow: 0 8px 20px rgba(0,0,0,0.12); margin-bottom: 18px; }
    .hero-banner h1 { margin: 0 0 6px 0; font-size: 30px; font-weight: 800; }
    .hero-banner p { margin: 0; font-size: 16px; opacity: 0.95; }
    .header { background: linear-gradient(135deg, #023047, #02475a); color: white; display: flex; justify-content: space-between; align-items: center; padding: 16px 22px; border-radius: 14px; box-shadow: 0 5px 12px rgba(0,0,0,0.08); margin-bottom: 22px; }
    .header h2 { margin: 0; font-size: 20px; }
    .logout-btn { background-color: rgba(255,255,255,0.12); color: white; border: 1px solid rgba(255,255,255,0.18); padding: 10px 16px; border-radius: 10px; cursor: pointer; font-weight: 700; }
    .portal-actions { display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 18px; margin-bottom: 22px; }
    .action-card { background: white; border-radius: 14px; padding: 20px; text-align: center; box-shadow: 0 6px 18px rgba(0,0,0,0.06); transition: all 0.22s ease; border: 2px solid transparent; }
    .action-card:hover { transform: translateY(-6px); box-shadow: 0 10px 28px rgba(0,0,0,0.12); border-color: #00a6c9; }
    .action-card .icon { width: 64px; height: 64px; margin: 0 auto 12px; display: block; }
    .action-card h3 { font-size: 18px; color: #023047; margin: 0 0 8px 0; font-weight: 800; }
    .action-card p { color: #666; font-size: 14px; margin: 0 0 14px 0; line-height: 1.5; }
    .action-card button { background: linear-gradient(135deg, #0077cc, #0099ff); color: white; border: none; padding: 10px 18px; border-radius: 10px; cursor: pointer; font-weight: 800; font-size: 14px; box-shadow: 0 6px 18px rgba(0,119,204,0.16); }
    .action-card button.secondary { background: linear-gradient(135deg, #06b6d4, #0288a7); }
    .noticias-section { background: white; border-radius: 14px; padding: 20px; margin-bottom: 18px; box-shadow: 0 5px 12px rgba(0,0,0,0.06); }
    .noticias-section h2 { color: #023047; margin-top: 0; margin-bottom: 12px; font-size: 20px; }
    .noticias-lista { max-height: 320px; overflow-y: auto; padding-right: 8px; }
    .noticia-item { background: linear-gradient(135deg, #f8f9fa, #ffffff); border-left: 4px solid #00a6c9; padding: 12px; margin-bottom: 12px; border-radius: 10px; transition: all 0.2s; cursor: pointer; }
    @media (max-width: 768px) {
      .wrap { padding: 12px; }
      .hero-banner h1 { font-size: 22px; }
      .portal-actions { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>
  <div class="wrap">
    <div class="hero-banner">
      <h1>Unidos contra el Ciberbullying</h1>
      <p>Este portal es tu espacio seguro para aprender, compartir y actuar</p>
    </div>

    <div class="header">
      <div>
        <h2>Mi Portal Estudiantil</h2>
        <p>Bienvenido, <strong><%= usuario %></strong></p>
      </div>
      <form action="<%= request.getContextPath() %>/logout" method="get" style="margin:0;">
        <button type="submit" class="logout-btn">Cerrar sesión</button>
      </form>
    </div>

    <div class="portal-actions">
      <div class="action-card">
        <img src="https://cdn-icons-png.flaticon.com/512/4149/4149670.png" alt="Reportar" class="icon">
        <h3>Reportar Ciberbullying</h3>
        <p>Envía una denuncia (puedes hacerlo anónimo). Cuanta más información proporciones, mejor podremos actuar.</p>
        <button type="button" onclick="location.href='<%= request.getContextPath() %>/reportar'">Reportar ahora</button>
      </div>

      <div class="action-card">
        <img src="https://cdn-icons-png.flaticon.com/512/1250/1250615.png" alt="Consultar" class="icon">
        <h3>Consultar estado de un caso</h3>
        <p>Introduce el ID que te dimos al reportar para ver el estado actual del caso.</p>
        <button type="button" class="secondary" 
        onclick="location.href='<%= request.getContextPath() %>/consultarestado.jsp'">
          Consultar estado
        </button>
      </div>

      <div class="action-card">
        <img src="https://cdn-icons-png.flaticon.com/512/2910/2910769.png" alt="Noticias" class="icon">
        <h3>Ver noticias</h3>
        <p>Mantente informado con las últimas publicaciones del portal y recursos disponibles.</p>
        <button type="button" onclick="location.href='<%= request.getContextPath() %>/noticias'">Ver noticias</button>
      </div>
    </div>

    <div class="noticias-section">
      <h2>Trabajamos para mantenerte informado!</h2>
      <div class="noticias-lista">
        <% if (noticias.isEmpty()) { %>
          <div style="text-align:center;color:#888;padding:30px;">📢 No hay noticias publicadas en este momento. ¡Mantente atento!</div>
        <% } else { %>
          <% for (Object obj : noticias) { %>
            <div class="noticia-item"><div class="noticia-contenido"><%= obj.toString() %></div></div>
          <% } %>
        <% } %>
      </div>
    </div>
  </div>
</body>
</html>
