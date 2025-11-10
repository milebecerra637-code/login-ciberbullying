<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Iniciar sesión — Colegios Libres de Ciberbullying</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">

  <!-- Fuente -->
  <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">

  <style>
    :root{
      --accent:#02a6c1;
      --accent-2:#06b6d4;
      --card-contrast:#ffffff;
      --radius:16px;
      --shadow:0 18px 50px rgba(2,40,60,0.14);
      --field-height:56px;
      --container-width:520px;
    }
    *{ box-sizing:border-box; }
    body {
      margin: 0;
      font-family: 'Baloo 2', system-ui, Arial, sans-serif;
      background: url('images/FrontCyber.jpg') no-repeat center center fixed;
      background-size: cover;
      min-height: 100vh;
      background-color: #0a4d5c;
    }
    .wrap {
      position: fixed;
      bottom: 40px;
      left: 40px;
      width:100%;
      max-width:calc(var(--container-width) + 48px);
      display:flex;
      gap:18px;
      flex-direction:column;
      backdrop-filter: blur(8px);
    }
    .hero {
      display:flex;
      gap:12px;
      align-items:center;
      background: rgba(5, 52, 71, 0.85);
      padding:14px 18px;
      border-radius:12px;
      margin-bottom:18px;
      max-width:var(--container-width);
      box-shadow:0 8px 24px rgba(0,0,0,0.4);
    }
    .badge {
      width:56px;
      height:56px;
      border-radius:12px;
      display:inline-flex;
      align-items:center;
      justify-content:center;
      background: linear-gradient(135deg,#0288a7,#06b6d4);
      color:#fff;
      font-weight:800;
      font-size:20px;
      box-shadow:0 8px 24px rgba(2,136,167,0.14);
    }
    .hero-text h1 { margin:0; font-size:26px; color:#fff; text-shadow:0 2px 6px rgba(0,0,0,0.5); }
    .hero-text p { margin:6px 0 0 0; color:#e0f7fa; font-size:14px; }
    .card {
      background: rgba(2,40,60,0.75);
      color: var(--card-contrast);
      border-radius:var(--radius);
      padding:28px;
      box-shadow:var(--shadow);
      width:100%;
      max-width:var(--container-width);
      text-align:left;
    }
    .card h2 { margin:0 0 8px 0; font-size:26px; color: #fff; font-weight:800; }
    .lead { margin:0 0 14px 0; color:rgba(255,255,255,0.87); font-size:15px; }
    label { display:block; font-size:14px; color:rgba(255,255,255,0.9); margin:8px 0 6px; }
    input[type="text"], input[type="password"] {
      width:100%;
      height:var(--field-height);
      padding:12px 14px;
      border-radius:12px;
      border: none;
      background: rgba(255,255,255,0.95);
      font-size:16px;
      outline:none;
      color:#022b33;
      box-shadow: inset 0 1px 0 rgba(0,0,0,0.03);
      font-family:inherit;
    }
    .btn {
      width:100%;
      display:inline-block;
      margin-top:14px;
      padding:14px;
      border-radius:12px;
      background: linear-gradient(90deg,var(--accent),var(--accent-2));
      color:#fff;
      border:none;
      font-weight:800;
      cursor:pointer;
      font-size:16px;
      font-family:inherit;
      box-shadow: 0 8px 20px rgba(2,136,167,0.18);
    }
    .secondary {
      display:block;
      text-align:center;
      margin-top:12px;
      color:#e0f7fa;
      text-decoration:none;
      font-weight:700;
    }
    .error-msg {
      color: #ff6b6b;
      font-weight: bold;
      margin-bottom: 12px;
    }
  </style>
</head>
<body>
  <div class="wrap">
    <div class="hero">
      <div class="badge">✓</div>
      <div class="hero-text">
        <h1>Colegios Libres de Ciberbullying</h1>
        <p>Accede a tu cuenta y ayuda a mantener un entorno seguro.</p>
      </div>
    </div>

    <div class="card">
      <h2>Inicia sesión</h2>
      <p class="lead">Introduce tus credenciales para continuar</p>

      <%-- Mostrar mensaje de error si existe --%>
      <% if(request.getAttribute("error") != null) { %>
        <div class="error-msg">
          <%= request.getAttribute("error") %>
        </div>
      <% } %>

      <form action="<%= request.getContextPath() %>/login" method="post" autocomplete="off">
        <label for="usuario">Usuario</label>
        <input id="usuario" name="usuario" type="text" placeholder="Tu usuario" required autofocus />

        <label for="contrasena">Contraseña</label>
        <input id="contrasena" name="contrasena" type="password" placeholder="Tu contraseña" required />

        <button class="btn" type="submit">Entrar</button>
      </form>

      <!-- <-- Cambiado: apuntar al servlet /registro en vez de /registro.jsp -->
      <a class="secondary" href="<%= request.getContextPath() %>/registro">¿No tienes cuenta? Regístrate</a>
    </div>
  </div>
</body>
</html>