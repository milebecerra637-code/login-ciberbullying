<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Publicar Noticia</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        h1 {
            color: #667eea;
            margin-bottom: 30px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #2d3748;
            font-weight: 600;
        }
        input[type="text"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        textarea {
            resize: vertical;
            min-height: 200px;
        }
        .btn-submit {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: transform 0.3s;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102,126,234,0.4);
        }
        .btn-back {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        .btn-back:hover {
            text-decoration: underline;
        }
        .error {
            background: #fed7d7;
            color: #c53030;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #c53030;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📰 Publicar Nueva Noticia</h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error">
                ⚠️ <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form method="POST" action="<%= request.getContextPath() %>/publicarNoticia">
            <div class="form-group">
                <label for="titulo">📌 Título de la Noticia:</label>
                <input type="text" id="titulo" name="titulo" 
                       placeholder="Ej: Nuevo protocolo contra el ciberbullying" 
                       required maxlength="200">
            </div>
            
            <div class="form-group">
                <label for="contenido">📝 Contenido:</label>
                <textarea id="contenido" name="contenido" 
                          placeholder="Escribe aquí el contenido completo de la noticia..." 
                          required></textarea>
            </div>
            
            <button type="submit" class="btn-submit">
                ✅ Publicar Noticia
            </button>
        </form>
        
        <a href="<%= request.getContextPath() %>/homeAdmin" class="btn-back">
            ← Volver al panel
        </a>
    </div>
</body>
</html>