<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Actualizar Reporte</title>
    <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root{--accent:#02a6c1;--bg:#eaf8fb;--card-dark-1:#053447;--radius:16px}
        *{box-sizing:border-box;margin:0;padding:0}
        body{
            font-family:'Baloo 2', sans-serif;
            background:linear-gradient(180deg,#e6fbff, var(--bg));
            min-height:100vh;
            padding:28px;
        }
        .container{max-width:800px;margin:0 auto}
        .card{
            background:white;
            border-radius:var(--radius);
            padding:35px;
            box-shadow:0 4px 16px rgba(2,40,60,0.08);
        }
        h1{color:var(--card-dark-1);margin-bottom:30px;font-size:2em}
        .info-box{
            background:#f7fafc;
            padding:20px;
            border-radius:12px;
            margin-bottom:25px;
            border-left:4px solid var(--accent);
        }
        .info-box p{margin:8px 0;color:#2d3748}
        .info-box strong{color:var(--accent)}
        .form-group{margin-bottom:25px}
        label{
            display:block;
            margin-bottom:8px;
            color:var(--card-dark-1);
            font-weight:700;
            font-size:1.05em;
        }
        select, textarea{
            width:100%;
            padding:12px;
            border:2px solid #e2e8f0;
            border-radius:10px;
            font-family:inherit;
            font-size:1em;
            transition:border-color 0.3s;
        }
        select:focus, textarea:focus{
            outline:none;
            border-color:var(--accent);
        }
        textarea{resize:vertical;min-height:150px}
        .btn{
            padding:14px 30px;
            border:none;
            border-radius:10px;
            font-weight:700;
            cursor:pointer;
            font-family:inherit;
            font-size:1.05em;
            transition:all 0.3s;
        }
        .btn-primary{
            background:linear-gradient(135deg,#0288a7,#06b6d4);
            color:white;
            width:100%;
        }
        .btn-primary:hover{transform:translateY(-2px);box-shadow:0 8px 20px rgba(2,136,167,0.3)}
        .btn-secondary{
            background:rgba(2,166,193,0.1);
            color:var(--accent);
            display:inline-block;
            margin-top:15px;
            text-decoration:none;
            text-align:center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h1>️ Actualizar Reporte</h1>
            
            <div class="info-box">
                <p><strong>Código:</strong> <%= request.getAttribute("codigoReporte") %></p>
                <p><strong>Estudiante:</strong> <%= request.getAttribute("estudianteNombre") %></p>
                <p><strong> Título:</strong> <%= request.getAttribute("titulo") %></p>
                <p><strong> Descripción:</strong><br><%= request.getAttribute("descripcion") %></p>
            </div>
            
            <form method="POST" action="<%= request.getContextPath() %>/actualizarReporte">
                <input type="hidden" name="id" value="<%= request.getAttribute("reporteId") %>">
                
                <div class="form-group">
                    <label for="estado">Estado del Reporte:</label>
                    <select id="estado" name="estado" required>
                        <option value="pendiente" <%= "pendiente".equals(request.getAttribute("estado")) ? "selected" : "" %>>
                            Pendiente
                        </option>
                        <option value="en_proceso" <%= "en_proceso".equals(request.getAttribute("estado")) ? "selected" : "" %>>
                             En Proceso
                        </option>
                        <option value="resuelto" <%= "resuelto".equals(request.getAttribute("estado")) ? "selected" : "" %>>
                            Resuelto
                        </option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="comentarios">Comentarios del Administrador:</label>
                    <textarea id="comentarios" name="comentarios_admin" 
                              placeholder="Escribe aquí los comentarios, acciones tomadas o resolución del caso..."><%= request.getAttribute("comentariosAdmin") != null ? request.getAttribute("comentariosAdmin") : "" %></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">
                    Guardar Cambios
                </button>
            </form>
            
            <a href="<%= request.getContextPath() %>/verReportes" class="btn btn-secondary">
                 Volver a reportes
            </a>
        </div>
    </div>
</body>
</html>