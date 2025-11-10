<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>Reportar Incidente</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Nunito', sans-serif;
      background-image: url('${pageContext.request.contextPath}/images/OIP.webp');
      background-size: 200px 200px;
      background-position: center;
      background-repeat: repeat;
      background-attachment: fixed;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      position: relative;
    }
    
    body::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.4);
      z-index: 0;
    }

    .container {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 25px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
      max-width: 550px;
      width: 100%;
      padding: 40px 35px;
      animation: slideIn 0.5s ease;
      position: relative;
      z-index: 1;
    }

    @keyframes slideIn {
      from {
        opacity: 0;
        transform: translateY(-30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    h1 {
      text-align: center;
      color: #667eea;
      font-size: 2.2em;
      margin-bottom: 10px;
      font-weight: 800;
    }

    .subtitle {
      text-align: center;
      color: #666;
      font-size: 1em;
      margin-bottom: 30px;
    }

    .success {
      background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
      color: white;
      padding: 20px;
      border-radius: 15px;
      margin-bottom: 20px;
      text-align: center;
      font-weight: 600;
      animation: bounceIn 0.6s ease;
    }

    @keyframes bounceIn {
      0% { transform: scale(0.8); opacity: 0; }
      50% { transform: scale(1.05); }
      100% { transform: scale(1); opacity: 1; }
    }

    .success strong {
      font-size: 1.3em;
      display: block;
      margin: 10px 0;
      letter-spacing: 1px;
    }

    .success a {
      color: white;
      text-decoration: underline;
      font-weight: 700;
    }

    .error {
      background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      color: white;
      padding: 15px;
      border-radius: 15px;
      margin-bottom: 20px;
      text-align: center;
      font-weight: 600;
    }

    label {
      display: block;
      margin-top: 18px;
      margin-bottom: 8px;
      color: #333;
      font-weight: 700;
      font-size: 1em;
    }

    input[type="date"],
    input[type="text"],
    select,
    textarea {
      width: 100%;
      padding: 12px 15px;
      border: 2px solid #e0e0e0;
      border-radius: 12px;
      font-size: 1em;
      font-family: 'Nunito', sans-serif;
      transition: all 0.3s ease;
      background: #f9f9f9;
    }

    input:focus,
    select:focus,
    textarea:focus {
      outline: none;
      border-color: #667eea;
      background: white;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    textarea {
      min-height: 120px;
      resize: vertical;
    }

    .checkbox-container {
      display: flex;
      align-items: center;
      margin-top: 20px;
      padding: 15px;
      background: #f0f4ff;
      border-radius: 12px;
    }

    .checkbox-container input[type="checkbox"] {
      width: 20px;
      height: 20px;
      margin-right: 10px;
      cursor: pointer;
    }

    .checkbox-container label {
      margin: 0;
      cursor: pointer;
      font-weight: 600;
      color: #667eea;
    }

    .actions {
      margin-top: 30px;
      text-align: center;
    }

    button {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      padding: 15px 50px;
      font-size: 1.1em;
      font-weight: 700;
      border-radius: 50px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-family: 'Nunito', sans-serif;
      box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
    }

    button:hover {
      transform: translateY(-3px);
      box-shadow: 0 15px 40px rgba(102, 126, 234, 0.6);
    }

    button:active {
      transform: translateY(-1px);
    }

    .emoji {
      font-size: 1.3em;
      margin-right: 5px;
    }

    @media (max-width: 600px) {
      .container {
        padding: 30px 20px;
      }

      h1 {
        font-size: 1.8em;
      }

      button {
        padding: 12px 40px;
        font-size: 1em;
      }
    }
  </style>
</head>
<body>
  <div class="container" role="main" aria-labelledby="report-title">
    <h1 id="report-title">📢 Reportar Incidente</h1>
    <p class="subtitle">Tu voz importa. Reporta de forma segura.</p>

    <%-- Mensaje de éxito --%>
    <% String radicadoParam = request.getParameter("radicado");
       if ("true".equals(request.getParameter("success")) && radicadoParam != null) { %>
      <div class="success" role="status">
        <span class="emoji">✅</span> ¡Reporte enviado correctamente!<br/>
        <strong><%= radicadoParam %></strong>
        Guarda este número para consultas futuras.<br/>
        <a href="<%= request.getContextPath() %>/consultarRadicado?radicado=<%= java.net.URLEncoder.encode(radicadoParam, "UTF-8") %>">
          🔍 Consultar este radicado
        </a>
      </div>
    <% } else if ("true".equals(request.getParameter("success"))) { %>
      <div class="success" role="status">
        <span class="emoji">✅</span> ¡Reporte enviado correctamente!
      </div>
    <% } %>

    <%-- Mensaje de error --%>
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
      <div class="error" role="alert">
        <span class="emoji">⚠️</span> <%= error %>
      </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/reportar" method="post" autocomplete="off">
      
      <label for="tipo">📋 Tipo de Incidente</label>
      <select id="tipo" name="tipo" required>
        <option value="">-- Selecciona una opción --</option>
        <option value="Bullying" <%= "Bullying".equals(request.getParameter("tipo")) ? "selected" : "" %>>Bullying</option>
        <option value="Ciberbullying" <%= "Ciberbullying".equals(request.getParameter("tipo")) ? "selected" : "" %>>Ciberbullying</option>
        <option value="Acoso" <%= "Acoso".equals(request.getParameter("tipo")) ? "selected" : "" %>>Acoso</option>
        <option value="Discriminación" <%= "Discriminación".equals(request.getParameter("tipo")) ? "selected" : "" %>>Discriminación</option>
        <option value="Otro" <%= "Otro".equals(request.getParameter("tipo")) ? "selected" : "" %>>Otro</option>
      </select>

      <label for="fecha">📅 Fecha del Incidente</label>
      <input id="fecha" name="fecha" type="date" value="<%= request.getParameter("fecha") != null ? request.getParameter("fecha") : "" %>" />

      <label for="lugar">📍 Lugar</label>
      <input id="lugar" name="lugar" type="text" placeholder="Ej: Salón 301, cafetería, baños..." value="<%= request.getParameter("lugar") != null ? request.getParameter("lugar") : "" %>" />

      <label for="descripcion">✍️ Descripción del Incidente</label>
      <textarea id="descripcion" name="descripcion" required placeholder="Cuéntanos qué pasó con el mayor detalle posible..."><%= request.getParameter("descripcion") != null ? request.getParameter("descripcion") : "" %></textarea>

      <div class="checkbox-container">
        <input type="checkbox" id="anonimo" name="anonimo" value="true" <%= "true".equals(request.getParameter("anonimo")) ? "checked" : "" %> />
        <label for="anonimo">🔒 Enviar de forma anónima</label>
      </div>

      <div class="actions">
        <button type="submit">🚀 Enviar Reporte</button>
      </div>
    </form>
  </div>
</body>
</html>>