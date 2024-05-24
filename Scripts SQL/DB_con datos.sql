CREATE DATABASE gestion_tareas;

USE gestion_tareas;

-- Tabla de Usuarios
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL
);

-- Insertar datos en la tabla de Usuarios
INSERT INTO Usuarios (nombre, correo_electronico, contraseña) VALUES
('Juan Pérez', 'juan.perez@gmail.com', 'contraseña1'),
('María López', 'maria.lopez@gmail.com', 'contraseña2');

-- Tabla de Proyectos
CREATE TABLE Proyectos (
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

-- Insertar datos en la tabla de Proyectos
INSERT INTO Proyectos (nombre, descripcion, id_usuario) VALUES
('Proyecto A', 'Descripción del Proyecto A', 1),
('Proyecto B', 'Descripción del Proyecto B', 2);

-- Tabla de Tareas
CREATE TABLE Tareas (
    id_tarea INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_vencimiento DATE,
    prioridad ENUM('Alta', 'Media', 'Baja') NOT NULL,
    estado ENUM('Pendiente', 'En Proceso', 'Completada') NOT NULL DEFAULT 'Pendiente',
    id_usuario_asignado INT,
    id_proyecto INT,
    FOREIGN KEY (id_usuario_asignado) REFERENCES Usuarios(id_usuario) ON DELETE SET NULL,
    FOREIGN KEY (id_proyecto) REFERENCES Proyectos(id_proyecto) ON DELETE CASCADE
);

-- Insertar datos en la tabla de Tareas
INSERT INTO Tareas (titulo, descripcion, fecha_vencimiento, prioridad, estado, id_usuario_asignado, id_proyecto) VALUES
('Tarea 1', 'Descripción de Tarea 1', '2024-06-01', 'Alta', 'Pendiente', 1, 1),
('Tarea 2', 'Descripción de Tarea 2', '2024-06-02', 'Media', 'En Proceso', 2, 2);

-- Tabla de Notificaciones
CREATE TABLE Notificaciones (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    mensaje TEXT NOT NULL,
    fecha_envio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario INT,
    id_tarea INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_tarea) REFERENCES Tareas(id_tarea) ON DELETE CASCADE
);

-- Insertar datos en la tabla de Notificaciones
INSERT INTO Notificaciones (mensaje, fecha_envio, id_usuario, id_tarea) VALUES
('Notificación de Tarea 1', '2024-05-24 10:00:00', 1, 1),
('Notificación de Tarea 2', '2024-05-24 11:00:00', 2, 2);