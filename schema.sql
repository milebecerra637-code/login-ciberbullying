-- Schema PostgreSQL para Render

CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    nombre_usuario VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    apellido VARCHAR(100),
    edad INTEGER,
    curso VARCHAR(100),
    rol VARCHAR(20) DEFAULT 'ESTUDIANTE',
    CONSTRAINT chk_rol CHECK (rol IN ('ADMIN', 'ESTUDIANTE'))
);

CREATE TABLE IF NOT EXISTS reportes (
    id SERIAL PRIMARY KEY,
    radicado VARCHAR(64) UNIQUE,
    tipo VARCHAR(64) NOT NULL,
    fecha DATE,
    lugar VARCHAR(255),
    descripcion TEXT NOT NULL,
    anonimo BOOLEAN NOT NULL DEFAULT FALSE,
    usuario VARCHAR(100),
    estado VARCHAR(32) NOT NULL DEFAULT 'Pendiente',
    creado TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_estado CHECK (estado IN (
        'Pendiente', 
        'En Proceso', 
        'Revisado', 
        'Citacion de las Partes', 
        'Conciliacion', 
        'Cerrado'
    )),
    CONSTRAINT chk_tipo CHECK (tipo IN (
        'Bullying',
        'Ciberbullying',
        'Acoso',
        'Discriminacion',
        'Otro'
    ))
);

CREATE TABLE IF NOT EXISTS noticias (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    autor VARCHAR(100) NOT NULL,
    importante BOOLEAN DEFAULT FALSE,
    activa BOOLEAN DEFAULT TRUE,
    CONSTRAINT chk_titulo_no_vacio CHECK (LENGTH(TRIM(titulo)) > 0),
    CONSTRAINT chk_contenido_no_vacio CHECK (LENGTH(TRIM(contenido)) > 0)
);

CREATE INDEX IF NOT EXISTS idx_fecha_publicacion ON noticias(fecha_publicacion DESC);
CREATE INDEX IF NOT EXISTS idx_importante ON noticias(importante);
CREATE INDEX IF NOT EXISTS idx_activa ON noticias(activa);
CREATE INDEX IF NOT EXISTS idx_reportes_estado ON reportes(estado);
CREATE INDEX IF NOT EXISTS idx_reportes_fecha ON reportes(creado DESC);
CREATE INDEX IF NOT EXISTS idx_reportes_radicado ON reportes(radicado);

INSERT INTO usuarios (nombre_usuario, contrasena, rol) 
VALUES ('admin', 'admin123', 'ADMIN')
ON CONFLICT (nombre_usuario) DO NOTHING;

INSERT INTO usuarios (nombre, nombre_usuario, contrasena, apellido, edad, curso, rol) 
VALUES 
    ('Sara', 'Sarita Rojas', 'sara123', 'Rojas', 13, 'Octavo', 'ESTUDIANTE'),
    ('Paula', 'Paula3345', 'paula123', 'Rojas', 15, 'Decimo', 'ESTUDIANTE'),
    ('Aslan', 'Aslanc', 'aslan123', 'Corredor', 14, 'Octavo', 'ESTUDIANTE'),
    ('Juan', 'Juansexto', 'juan123', 'Corredor', 14, 'Sexto', 'ESTUDIANTE')
ON CONFLICT (nombre_usuario) DO NOTHING;

SELECT 'Usuarios creados' as tabla, COUNT(*) as total FROM usuarios;