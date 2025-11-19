<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>Iniciar sesión — Colegios Libres de Ciberbullying</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background: url('<%= request.getContextPath() %>/images/FrontCyber.jpg') no-repeat center center;
      background-size: cover;
      min-height: 100vh;
      display: flex;
      align-items: flex-end;
      justify-content: flex-start;
      padding: 40px;
      position: relative;
      overflow: hidden;
    }

    /* Header flotante */
    .header {
      position: absolute;
      top: 30px;
      left: 40px;
      color: white;
      max-width: 450px;
      z-index: 1;
    }

    .header .logo {
      width: 60px;
      height: 60px;
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 16px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 32px;
      margin-bottom: 20px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
    }

    .header h1 {
      font-size: 2.2em;
      font-weight: 700;
      margin-bottom: 12px;
      text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
      color: #2d3748;
      background: rgba(255, 255, 255, 0.9);
      padding: 10px 15px;
      border-radius: 12px;
      display: inline-block;
    }

    .header p {
      font-size: 1.1em;
      line-height: 1.6;
      color: #2d3748;
      background: rgba(255, 255, 255, 0.9);
      padding: 10px 15px;
      border-radius: 12px;
      display: inline-block;
    }

    /* Tarjeta de login */
    .login-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(20px);
      border-radius: 24px;
      padding: 35px 30px;
      width: 100%;
      max-width: 380px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
      animation: slideUp 0.6s ease;
      position: relative;
      z-index: 2;
    }

    @keyframes slideUp {
      from {
        opacity: 0;
        transform: translateY(40px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .login-card h2 {
      color: #2d3748;
      font-size: 1.8em;
      margin-bottom: 8px;
      font-weight: 700;
    }

    .login-card .subtitle {
      color: #718096;
      font-size: 0.95em;
      margin-bottom: 28px;
    }

    .error {
      background: linear-gradient(135deg, #fc5c7d, #6a82fb);
      color: white;
      padding: 12px 16px;
      border-radius: 12px;
      margin-bottom: 20px;
      text-align: center;
      font-weight: 600;
      font-size: 0.9em;
      animation: shake 0.5s ease;
    }

    @keyframes shake {
      0%, 100% { transform: translateX(0); }
      25% { transform: translateX(-10px); }
      75% { transform: translateX(10px); }
    }

    .success {
      background: linear-gradient(135deg, #11998e, #38ef7d);
      color: white;
      padding: 12px 16px;
      border-radius: 12px;
      margin-bottom: 20px;
      text-align: center;
      font-weight: 600;
      font-size: 0.9em;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      color: #4a5568;
      font-weight: 600;
      margin-bottom: 8px;
      font-size: 0.9em;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 14px 16px;
      border: 2px solid #e2e8f0;
      border-radius: 12px;
      font-size: 1em;
      font-family: 'Poppins', sans-serif;
      transition: all 0.3s ease;
      background: #f7fafc;
    }

    input:focus {
      outline: none;
      border-color: #667eea;
      background: white;
      box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
    }

    button {
      width: 100%;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      padding: 15px;
      font-size: 1.05em;
      font-weight: 700;
      border-radius: 12px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-family: 'Poppins', sans-serif;
      box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
      margin-top: 10px;
    }

    button:hover {
      transform: translateY(-2px);
      box-shadow: 0 15px 40px rgba(102, 126, 234, 0.6);
    }

    button:active {
      transform: translateY(0);
    }

    .register-link {
      text-align: center;
      margin-top: 20px;
      color: #718096;
      font-size: 0.9em;
    }

    .register-link a {
      color: #667eea;
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
    }

    .register-link a:hover {
      color: #764ba2;
      text-decoration: underline;
    }

    @media (max-width: 768px) {
      body {
        padding: 20px;
        align-items: center;
        justify-content: center;
      }

      body::before {
        width: 300px;
        height: 300px;
        right: 50%;
        top: 20%;
        transform: translateX(50%);
        opacity: 0.2;
      }

      .header {
        position: static;
        text-align: center;
        max-width: 100%;
        margin-bottom: 30px;
      }

      .header .logo {
        margin: 0 auto 20px;
      }

      .header h1 {
        font-size: 1.8em;
      }

      .header p {
        font-size: 1em;
      }

      .login-card {
        max-width: 100%;
      }
    }
  </style>
</head>
<body>
  

  <div class="header">
    <h1>Colegios Libres de Ciberbullying</h1>
    <p>Accede a tu cuenta y ayuda a mantener un entorno seguro.</p>
  </div>

  <!-- Tarjeta de Login -->
  <div class="login-card">
    <h2>Inicia sesión</h2>
    <p class="subtitle">Bienvenido de nuevo</p>

    <%-- mensaje de error --%>
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
      <div class="error">⚠️ <%= error %></div>
    <% } %>

    <%--  registro exitoso --%>
    <% if ("true".equals(request.getParameter("registered"))) { %>
      <div class="success">✅ ¡Registro exitoso! Ahora puedes iniciar sesión.</div>
    <% } %>

    <form action="<%= request.getContextPath() %>/login" method="post" autocomplete="off">
      
      <div class="form-group">
        <label for="usuario">Tu usuario</label>
        <input 
          type="text" 
          id="usuario" 
          name="usuario" 
          placeholder="Ingresa tu usuario" 
          required 
          autofocus
          value="<%= request.getParameter("usuario") != null ? request.getParameter("usuario") : "" %>"
        />
      </div>

      <div class="form-group">
        <label for="contrasena">Tu contraseña</label>
        <input 
          type="password" 
          id="contrasena" 
          name="contrasena" 
          placeholder="Ingresa tu contraseña" 
          required 
        />
      </div>

      <button type="submit">Entrar</button>

      <div class="register-link">
        ¿No tienes cuenta? <a href="<%= request.getContextPath() %>/registro">Regístrate aquí</a>
      </div>

    </form>
  </div>

</body>
</html>