<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String usuario = (String) session.getAttribute("usuario");
  if (usuario == null) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
  }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Denuncia enviada</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
  <style>
    body{ font-family:'Baloo 2',sans-serif; margin:0; background:#f4fbfd; min-height:100vh; display:flex; align-items:center; justify-content:center; padding:24px; }
    .box{ background:#fff; padding:26px; border-radius:12px; box-shadow:0 10px 30px rgba(10,20,40,0.06); max-width:720px; width:100%; text-align:center; }
    h1{ margin:0 0 8px; color:#023047; }
    p{ color:#444; }
    .caseid{ margin:18px 0; padding:12px; background:linear-gradient(90deg,#06b6d4,#0288a7); color:#fff; display:inline-block; border-radius:8px; font-weight:800; letter-spacing:1px; }
    .actions{ margin-top:18px; display:flex; gap:10px; justify-content:center; }
    .btn{ padding:10px 16px; border-radius:10px; border:none; font-weight:700; cursor:pointer; }
    .btn.primary{ background:#023047; color:#fff; }
    .btn.secondary{ background:transparent; color:#023047; border:2px solid #e6f6fb; }
  </style>
</head>
<body>
  <div class="box">
    <h1>Denuncia recibida</h1>
    <p>Gracias por reportar. Hemos asignado un ID a tu caso para que puedas consultarlo más tarde.</p>

    <div class="caseid"><%= request.getAttribute("caseId") %></div>

    <p style="margin-top:10px;color:#6b7280;">Guarda este código para consultar el estado del caso.</p>

    <div class="actions">
      <form action="<%= request.getContextPath() %>/consultar" method="get" style="margin:0;">
        <button type="submit" class="btn primary">Consultar estado</button>
      </form>
      <a href="<%= request.getContextPath() %>/homeEstudiante" class="btn secondary">Volver al portal</a>
    </div>
  </div>
</body>
</html>