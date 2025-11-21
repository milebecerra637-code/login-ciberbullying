<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String usuario = (String) session.getAttribute("usuario");
  String rol = (String) session.getAttribute("rol");
  if (usuario == null || !"ADMIN".equalsIgnoreCase(rol)) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
  }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Panel Administrador — Colegios libres de Ciberbullying</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
  <style>
    :root{
      --accent:#02a6c1;
      --accent-2:#06b6d4;
      --bg:#eaf8fb;
      --card-dark-1:#053447;
      --card-dark-2:#02475a;
      --card-contrast:#ffffff;
      --muted:#bcd6dd;
      --radius:16px;
      --shadow:0 18px 50px rgba(2,40,60,0.14);
      --container-width:920px;
    }
    *{box-sizing:border-box}
    body{
      margin:0;
      font-family:'Baloo 2', system-ui, Arial, sans-serif;
      background: linear-gradient(180deg,#e6fbff 0%, var(--bg) 100%);
      min-height:100vh;
      padding:28px;
      -webkit-font-smoothing:antialiased;
    }

    .wrap {
      width:100%;
      max-width:var(--container-width);
      margin:0 auto;
    }

    .header {
      background: linear-gradient(180deg, var(--card-dark-1), var(--card-dark-2));
      color: var(--card-contrast);
      border-radius:var(--radius);
      padding:24px 28px;
      box-shadow:var(--shadow);
      margin-bottom:24px;
      display:flex;
      justify-content:space-between;
      align-items:center;
    }
    .header h1 { margin:0; font-size:28px; color:#fff; font-weight:800; }
    .header p { margin:6px 0 0 0; color:rgba(255,255,255,0.85); font-size:15px; }
    .logout-btn {
      background: rgba(255,255,255,0.15);
      color:#fff;
      border:1px solid rgba(255,255,255,0.2);
      padding:10px 20px;
      border-radius:10px;
      cursor:pointer;
      font-weight:700;
      font-size:14px;
      font-family:inherit;
    }
    .logout-btn:hover { background: rgba(255,255,255,0.25); }

    .grid {
      display:grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap:18px;
      margin-bottom:24px;
    }

    .card {
      background: linear-gradient(180deg, #fff, #f8fcfd);
      border-radius:var(--radius);
      padding:24px;
      box-shadow:0 4px 16px rgba(2,40,60,0.08);
      border:1px solid rgba(2,166,193,0.1);
      transition: transform 0.2s, box-shadow 0.2s;
    }
    .card:hover {
      transform: translateY(-4px);
      box-shadow:0 8px 24px rgba(2,166,193,0.15);
    }
    .card-icon {
      width:48px;
      height:48px;
      border-radius:12px;
      display:flex;
      align-items:center;
      justify-content:center;
      background: linear-gradient(135deg,#0288a7,#06b6d4);
      color:#fff;
      font-size:24px;
      margin-bottom:16px;
    }
    .card h3 { margin:0 0 8px 0; font-size:20px; color:#042a3b; }
    .card p { margin:0; color:#6b8894; font-size:14px; line-height:1.5; }
    .card-link {
      display:inline-block;
      margin-top:12px;
      color:var(--accent);
      font-weight:700;
      text-decoration:none;
      font-size:14px;
    }
    .card-link:hover { text-decoration:underline; }

    .welcome-card {
      background: linear-gradient(135deg, rgba(2,136,167,0.06), rgba(6,182,212,0.02));
      border-radius:var(--radius);
      padding:24px;
      margin-bottom:24px;
      border-left:4px solid var(--accent);
    }
    .welcome-card h2 { margin:0 0 8px 0; color:#042a3b; font-size:22px; }
    .welcome-card p { margin:0; color:#6b8894; font-size:15px; }
  </style>
</head>
<body>
  <div class="wrap">
    <div class="header">
      <div>
        <h1>🛡️ Panel Administrador</h1>
        <p>Bienvenido, <strong><%= usuario %></strong> (Administrador)</p>
      </div>
      <form action="<%= request.getContextPath() %>/logout" method="get" style="margin:0;">
        <button type="submit" class="logout-btn">Cerrar sesión</button>
      </form>
    </div>

    <div class="welcome-card">
      <h2>Gestión del Sistema</h2>
      <p>Desde aquí puedes administrar usuarios, monitorear reportes de ciberbullying y gestionar el contenido del sistema.</p>
    </div>

    <div class="grid">
      <!-- USUARIOS - ACTUALIZADO -->
      <div class="card">
        <div class="card-icon">👥</div>
        <h3>Gestionar Usuarios</h3>
        <p>Administra estudiantes, profesores y moderadores del sistema.</p>
        <a href="<%= request.getContextPath() %>/verUsuarios" class="card-link">Ver usuarios →</a>
      </div>

      <!-- REPORTES - ACTUALIZADO -->
      <div class="card">
        <div class="card-icon">📊</div>
        <h3>Reportes</h3>
        <p>Revisa y gestiona los reportes de ciberbullying enviados por la comunidad.</p>
        <a href="<%= request.getContextPath() %>/verReportes" class="card-link">Ver reportes →</a>
      </div>

      <div class="card">
        <div class="card-icon">📈</div>
        <h3>Estadísticas</h3>
        <p>Visualiza métricas y estadísticas del sistema en tiempo real.</p>
        <a href="#" class="card-link">Ver estadísticas →</a>
      </div>

      <div class="card">
        <div class="card-icon">⚙️</div>
        <h3>Configuración</h3>
        <p>Ajusta parámetros del sistema, notificaciones y permisos.</p>
        <a href="#" class="card-link">Configurar →</a>
      </div>

      <!-- NOTICIAS - YA ACTUALIZADO -->
      <div class="card">
        <div class="card-icon">📰</div>
        <h3>Gestionar Noticias</h3>
        <p>Publica, edita y elimina noticias para la comunidad estudiantil.</p>
        <a href="<%= request.getContextPath() %>/gestionarNoticias" class="card-link">Gestionar noticias →</a>
      </div>

      <div class="card">
        <div class="card-icon">🔔</div>
        <h3>Notificaciones</h3>
        <p>Envía alertas y comunicados importantes a la comunidad escolar.</p>
        <a href="#" class="card-link">Enviar notificación →</a>
      </div>
    </div>
  </div>
</body>
</html>