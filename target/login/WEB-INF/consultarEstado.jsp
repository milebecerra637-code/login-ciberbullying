<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>Consultar Estado del Caso</title>
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
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .container {
      background: white;
      border-radius: 25px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
      max-width: 650px;
      width: 100%;
      padding: 40px 35px;
      animation: slideIn 0.5s ease;
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
      font-size: 2em;
      margin-bottom: 10px;
      font-weight: 800;
    }

    .subtitle {
      text-align: center;
      color: #666;
      margin-bottom: 30px;
      font-size: 1em;
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

    .success-box {
      background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
      color: white;
      padding: 25px;
      border-radius: 15px;
      margin-bottom: 20px;
    }

    .success-box h2 {
      margin-bottom: 15px;
      font-size: 1.5em;
    }

    .info-row {
      display: flex;
      margin-bottom: 12px;
      padding-bottom: 12px;
      border-bottom: 1px solid rgba(255,255,255,0.2);
    }

    .info-row:last-child {
      border-bottom: none;
    }

    .info-label {
      font-weight: 700;
      min-width: 140px;
    }

    .info-value {
      flex: 1;
    }

    .status-badge {
      display: inline-block;
      padding: 8px 18px;
      border-radius: 20px;
      font-weight: 700;
      font-size: 0.95em;
      background: rgba(255,255,255,0.3);
    }

    .status-pendiente { background: #ffc107; color: #000; }
    .status-proceso { background: #2196F3; color: #fff; }
    .status-revisado { background: #9C27B0; color: #fff; }
    .status-citacion { background: #FF5722; color: #fff; }
    .status-conciliacion { background: #00BCD4; color: #fff; }
    .status-cerrado { background: #4CAF50; color: #fff; }

    label {
      display: block;
      margin-bottom: 8px;
      color: #333;
      font-weight: 700;
      font-size: 1em;
    }

    input[type="text"] {
      width: 100%;
      padding: 15px;
      border: 2px solid #e0e0e0;
      border-radius: 12px;
      font-size: 1.1em;
      font-family: 'Nunito', sans-serif;
      transition: all 0.3s ease;
      background: #f9f9f9;
      text-align: center;
      letter-spacing: 2px;
      font-weight: 600;
    }

    input:focus {
      outline: none;
      border-color: #667eea;
      background: white;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    .actions {
      margin-top: 25px;
      display: flex;
      gap: 12px;
      justify-content: center;
      flex-wrap: wrap;
    }

    button, .btn {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      padding: 15px 40px;
      font-size: 1.1em;
      font-weight: 700;
      border-radius: 50px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-family: 'Nunito', sans-serif;
      box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
      text-decoration: none;
      display: inline-block;
    }

    button:hover, .btn:hover {
      transform: translateY(-3px);
      box-shadow: 0 15px 40px rgba(102, 126, 234, 0.6);
    }

    .btn-secondary {
      background: linear-gradient(135deg, #858585 0%, #5a5a5a 100%);
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    }

    .btn-secondary:hover {
      box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
    }

    @media (max-width: 600px) {
      .container {
        padding: 30px 20px;
      }

      h1 {
        font-size: 1.6em;
      }

      .actions {
        flex-direction: column;
      }

      button, .btn {
        width: 100%;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>🔍 Consultar Estado</h1>
    <p class="subtitle">Ingresa tu número de radicado para ver el estado de tu caso</p>

    <%-- Mostrar error si existe --%>
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
      <div class="error">⚠️ <%= error %></div>
    <% } %>

    <%-- Mostrar resultados si existen --%>
    <% String radicado = (String) request.getAttribute("radicado");
       if (radicado != null) { 
          String estado = (String) request.getAttribute("estado");
          String estadoClass = "";
          
          // Determinar clase CSS según el estado
          if ("Pendiente".equalsIgnoreCase(estado)) {
              estadoClass = "status-pendiente";
          } else if ("En Proceso".equalsIgnoreCase(estado)) {
              estadoClass = "status-proceso";
          } else if ("Revisado".equalsIgnoreCase(estado)) {
              estadoClass = "status-revisado";
          } else if ("Citación de las Partes".equalsIgnoreCase(estado)) {
              estadoClass = "status-citacion";
          } else if ("Conciliación".equalsIgnoreCase(estado)) {
              estadoClass = "status-conciliacion";
          } else if ("Cerrado".equalsIgnoreCase(estado)) {
              estadoClass = "status-cerrado";
          }
    %>
      <div class="success-box">
        <h2>📋 Información del Caso</h2>
        
        <div class="info-row">
          <span class="info-label">Radicado:</span>
          <span class="info-value"><strong><%= radicado %></strong></span>
        </div>

        <div class="info-row">
          <span class="info-label">Tipo:</span>
          <span class="info-value"><%= request.getAttribute("tipo") %></span>
        </div>

        <div class="info-row">
          <span class="info-label">Estado:</span>
          <span class="info-value">
            <span class="status-badge <%= estadoClass %>"><%= estado %></span>
          </span>
        </div>

        <% 
          java.sql.Date fecha = (java.sql.Date) request.getAttribute("fecha");
          if (fecha != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        %>
        <div class="info-row">
          <span class="info-label">Fecha del Incidente:</span>
          <span class="info-value"><%= sdf.format(fecha) %></span>
        </div>
        <% } %>

        <% 
          String lugar = (String) request.getAttribute("lugar");
          if (lugar != null && !lugar.trim().isEmpty()) {
        %>
        <div class="info-row">
          <span class="info-label">Lugar:</span>
          <span class="info-value"><%= lugar %></span>
        </div>
        <% } %>

        <div class="info-row">
          <span class="info-label">Descripción:</span>
          <span class="info-value"><%= request.getAttribute("descripcion") %></span>
        </div>

        <% 
          java.sql.Timestamp creado = (java.sql.Timestamp) request.getAttribute("creado");
          if (creado != null) {
            SimpleDateFormat sdfTime = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        %>
        <div class="info-row">
          <span class="info-label">Fecha de Reporte:</span>
          <span class="info-value"><%= sdfTime.format(creado) %></span>
        </div>
        <% } %>
      </div>

      <div class="actions">
        <a href="<%= request.getContextPath() %>/consultarEstado" class="btn-secondary btn">🔄 Consultar Otro</a>
        <a href="<%= request.getContextPath() %>/homeEstudiante" class="btn">🏠 Volver al Inicio</a>
      </div>

    <% } else { %>
      <%-- Formulario de consulta --%>
      <form action="<%= request.getContextPath() %>/consultarEstado" method="post">
        <label for="radicado">📄 Número de Radicado</label>
        <input 
          type="text" 
          id="radicado" 
          name="radicado" 
          placeholder="Ej: R20251110120000000001" 
          required 
          maxlength="64"
          value="<%= request.getParameter("radicado") != null ? request.getParameter("radicado") : "" %>"
        />

        <div class="actions">
          <button type="submit">🔍 Consultar Estado</button>
          <a href="<%= request.getContextPath() %>/homeEstudiante" class="btn-secondary btn">⬅️ Volver</a>
        </div>
      </form>
    <% } %>
  </div>
</body>
</html>