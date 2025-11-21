<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>Portal Estudiante — Colegios Libres de Ciberbullying</title>
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
      background: linear-gradient(135deg, rgba(102, 126, 234, 0.85) 0%, rgba(118, 75, 162, 0.85) 100%),
                  url('<%= request.getContextPath() %>/images/OIP.webp');
      background-size: auto, 200px 200px;
      background-repeat: no-repeat, repeat;
      min-height: 100vh;
      padding: 40px;
      position: relative;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      background: rgba(255, 255, 255, 0.75);
      backdrop-filter: blur(15px);
      border-radius: 24px;
      padding: 40px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
      animation: fadeIn 0.5s ease;
      position: relative;
      z-index: 1;
      border: 1px solid rgba(255, 255, 255, 0.3);
    }

    @keyframes fadeIn {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    h1 {
      color: #667eea;
      font-size: 2.5em;
      margin-bottom: 10px;
    }

    .welcome {
      color: #718096;
      font-size: 1.2em;
      margin-bottom: 30px;
    }

    .info-card {
      background: rgba(247, 250, 252, 0.9);
      padding: 20px;
      border-radius: 12px;
      margin-bottom: 20px;
      border-left: 4px solid #667eea;
    }

    .info-card h3 {
      color: #2d3748;
      margin-bottom: 15px;
      font-size: 1.3em;
    }

    .info-card p {
      margin: 10px 0;
      font-size: 1.1em;
      color: #4a5568;
    }

    .info-card strong {
      color: #667eea;
      font-weight: 600;
    }

    .logout-btn {
      background: linear-gradient(135deg, #fc5c7d, #6a82fb);
      color: white;
      padding: 15px 35px;
      border: none;
      border-radius: 12px;
      font-size: 1.1em;
      font-weight: 700;
      cursor: pointer;
      text-decoration: none;
      display: inline-block;
      margin-top: 20px;
      transition: all 0.3s ease;
      box-shadow: 0 10px 30px rgba(252, 92, 125, 0.4);
    }

    .logout-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 15px 40px rgba(252, 92, 125, 0.6);
    }

    .success-message {
      background: linear-gradient(135deg, #11998e, #38ef7d);
      color: white;
      padding: 20px;
      border-radius: 12px;
      margin-bottom: 30px;
      font-size: 1.2em;
      text-align: center;
      font-weight: 600;
      box-shadow: 0 10px 30px rgba(17, 153, 142, 0.3);
    }

    .menu-card {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 25px;
      border-radius: 12px;
      margin-bottom: 20px;
      cursor: pointer;
      transition: transform 0.3s ease;
      text-decoration: none;
      display: block;
    }

    .menu-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 40px rgba(102, 126, 234, 0.6);
    }

    .menu-card h3 {
      margin-bottom: 10px;
      font-size: 1.4em;
    }

    .menu-card p {
      margin: 0;
      opacity: 0.9;
    }

    .menu-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      margin-top: 30px;
    }

    @media (max-width: 768px) {
      body {
        padding: 20px;
        background-size: auto, 150px 150px;
      }

      .container {
        padding: 25px;
      }

      h1 {
        font-size: 2em;
      }

      .menu-grid {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="success-message">
      ✅ ¡Has iniciado sesión correctamente!
    </div>

    <h1> Portal del Estudiante</h1>
    <p class="welcome">Bienvenido a tu panel de control</p>

    <div class="info-card">
      <p><strong>👤 Usuario:</strong> <%= session.getAttribute("usuario") %></p>
      <p><strong>🎭 Rol:</strong> <%= session.getAttribute("rol") %></p>
    </div>

    <div class="menu-grid">
      <a href="<%= request.getContextPath() %>/reportar" class="menu-card">
        <h3>📝 Crear Reporte</h3>
        <p>Reporta un caso de ciberbullying</p>
      </a>

      <a href="<%= request.getContextPath() %>/misReportes" class="menu-card">
        <h3> Ultimas noticias!</h3>
        <p>Mantente informado </p>
      </a>

      <a href="<%= request.getContextPath() %>/consultarEstado" class="menu-card">
        <h3> Estado de mis casos Reportados</h3>
        <p>Consulta aqui tu caso</p>
      </a>
    </div>

    <a href="<%= request.getContextPath() %>/logout" class="logout-btn">🚪 Cerrar sesión</a>
  </div>
</body>
</html>