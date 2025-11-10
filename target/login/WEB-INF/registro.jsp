<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Registro - Crear cuenta</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <style>
    :root{
      --bg:#f5f7fb;
      --card:#ffffff;
      --accent:#2b7be3;
      --muted:#6b7280;
      --radius:12px;
      --shadow: 0 8px 30px rgba(41,51,73,0.08);
      --field-height:54px;
    }
    *{box-sizing:border-box}
    body{
      margin:0;
      font-family:Inter, system-ui, Arial, sans-serif;
      background: linear-gradient(180deg, #eef4ff 0%, var(--bg) 100%);
      color:#222;
      min-height:100vh;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:40px 16px;
    }
    .page { width:100%; max-width:980px; display:grid; grid-template-columns: 1fr 420px; gap:32px; align-items:center; }
    .hero { padding:28px; }
    .hero h1{ margin:0 0 12px 0; font-size:28px; color:#0f1724; }
    .hero p{ margin:0; color:var(--muted); line-height:1.5; }
    .card { background:var(--card); border-radius:var(--radius); padding:28px; box-shadow:var(--shadow); }
    .card h2{ margin:0 0 12px 0; font-size:20px; }
    form .row { display:flex; gap:12px; }
    label { display:block; font-size:13px; color:var(--muted); margin-bottom:6px; }
    input[type="text"], input[type="password"], input[type="number"], select {
      width:100%; height:var(--field-height); padding:12px 14px; font-size:15px; border:1px solid #e6e9ef; border-radius:10px; background:#fff; outline:none; transition: box-shadow .12s, border-color .12s;
    }
    input:focus, select:focus { box-shadow:0 6px 18px rgba(43,123,227,0.10); border-color:var(--accent); }
    .actions { margin-top:18px; display:flex; gap:12px; align-items:center; }
    .btn { display:inline-block; background:var(--accent); color:#fff; padding:12px 18px; border-radius:10px; text-decoration:none; border:none; cursor:pointer; font-weight:600; font-size:15px; }
    .btn.secondary { background:transparent; color:var(--accent); border:1px solid rgba(43,123,227,0.12); }
    .small { font-size:13px; color:var(--muted); margin-top:10px; }
    .error { color:#b91c1c; font-weight:700; margin-bottom:12px; background:#fff2f0; padding:10px; border-radius:8px; }
    @media (max-width:900px){ .page{ grid-template-columns: 1fr; max-width:560px; } .hero{ order:2 } }
    .field { margin-bottom:14px; }
  </style>
</head>
<body>
  <div class="page" role="main" aria-labelledby="reg-title">
    <div class="hero" aria-hidden="false">
      <h1 id="reg-title">Crea tu cuenta</h1>
      <p>Únete hoy y ayuda a mantener un entorno seguro.</p>
    </div>

    <div class="card" role="region" aria-labelledby="form-title">
      <h2 id="form-title">Formulario de registro</h2>

      <%-- Mostrar errores enviados por el servlet --%>
      <%
         String error = (String) request.getAttribute("error");
         if (error != null) {
      %>
        <div class="error" role="alert"><%= error %></div>
      <% } %>

      <%-- Formulario: envía a /registro (RegistroServlet) --%>
      <form action="<%= request.getContextPath() %>/registro" method="post" autocomplete="off" novalidate>
        <div class="row">
          <div style="flex:1">
            <div class="field">
              <label for="nombre">Nombre</label>
              <input id="nombre" name="nombre" type="text" placeholder="Tu nombre"
                     value="<%= request.getParameter("nombre") != null ? request.getParameter("nombre") : "" %>" />
            </div>
          </div>
          <div style="flex:1">
            <div class="field">
              <label for="apellido">Apellido</label>
              <input id="apellido" name="apellido" type="text" placeholder="Tu apellido"
                     value="<%= request.getParameter("apellido") != null ? request.getParameter("apellido") : "" %>" />
            </div>
          </div>
        </div>

        <div class="row">
          <div style="flex:1">
            <div class="field">
              <label for="edad">Edad</label>
              <input id="edad" name="edad" type="number" min="1" max="120" placeholder="Ej. 30"
                     value="<%= request.getParameter("edad") != null ? request.getParameter("edad") : "" %>" />
            </div>
          </div>
          <div style="flex:1">
            <div class="field">
              <label for="curso">Curso</label>
              <input id="curso" name="curso" type="text" placeholder="Curso (opcional)"
                     value="<%= request.getParameter("curso") != null ? request.getParameter("curso") : "" %>" />
            </div>
          </div>
        </div>

        <div class="field">
          <label for="usuario">Nombre de usuario</label>
          <input id="usuario" name="usuario" type="text" placeholder="usuario123"
                 value="<%= request.getParameter("usuario") != null ? request.getParameter("usuario") : "" %>" required />
        </div>

        <div class="field">
          <label for="contrasena">Contraseña</label>
          <input id="contrasena" name="contrasena" type="password" placeholder="Contraseña segura" required />
        </div>

        <div class="actions">
          <button class="btn" type="submit">Crear cuenta</button>
          <a class="btn secondary" href="<%= request.getContextPath() %>/login">Volver al login</a>
        </div>

        <div class="small">Al registrarte aceptas nuestros <a href="#" style="color:var(--accent)">Términos y Privacidad</a>.</div>
      </form>
    </div>
  </div>
</body>
</html>