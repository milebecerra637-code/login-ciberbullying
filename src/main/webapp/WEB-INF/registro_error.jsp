<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error en el Registro</title>
    <style>
        body {
            background: #ffe0e0;
            font-family: Arial, sans-serif;
        }
        .container {
            width: 400px;
            margin: 80px auto;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            text-align: center;
        }
        h2 { color: #dc3545; }
        a {
            display: inline-block;
            margin-top: 15px;
            color: white;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
        }
        a:hover { background-color: #0056b3; }
    </style>
</head>
<body>
<div class="container">
    <h2>❌ Error en el Registro</h2>
    <p>Ocurrió un problema al registrar el usuario. Verifica los datos e inténtalo nuevamente.</p>
    <a href="registro.jsp">Volver al formulario</a>
</div>
</body>
</html>
