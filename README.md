# Descripción del Proyecto (Necesidad)

Desarrollar una aplicación de gestión de tareas que permita a los usuarios crear, editar, eliminar y visualizar tareas. La aplicación debe proporcionar funcionalidades de gestión de proyectos, asignación de tareas a diferentes usuarios, seguimiento del progreso de las tareas, y notificaciones de vencimiento. 

## Requerimientos Funcionales

1. **Registro y Autenticación de Usuarios**
   - RF1.1: Los usuarios deben poder registrarse proporcionando nombre, correo electrónico y contraseña.
   - RF1.2: Los usuarios deben poder iniciar sesión utilizando su correo electrónico y contraseña.
   - RF1.3: Los usuarios deben poder restablecer su contraseña si la olvidan.

2. **Gestión de Tareas**
   - RF2.1: Los usuarios deben poder crear nuevas tareas con título, descripción, fecha de vencimiento y prioridad.
   - RF2.2: Los usuarios deben poder editar los detalles de una tarea existente.
   - RF2.3: Los usuarios deben poder eliminar tareas.
   - RF2.4: Los usuarios deben poder ver una lista de todas sus tareas.
   - RF2.5: Los usuarios deben poder marcar tareas como completadas.

3. **Gestión de Proyectos**
   - RF3.1: Los usuarios deben poder crear proyectos con nombre y descripción.
   - RF3.2: Los usuarios deben poder asignar tareas a proyectos.
   - RF3.3: Los usuarios deben poder ver una lista de todas las tareas de un proyecto.

4. **Asignación de Tareas**
   - RF4.1: Los usuarios deben poder asignar tareas a otros usuarios registrados en la aplicación.
   - RF4.2: Los usuarios deben recibir notificaciones cuando se les asigna una nueva tarea.

5. **Seguimiento del Progreso**
   - RF5.1: Los usuarios deben poder ver el estado de las tareas (Pendiente, En Proceso, Completada).
   - RF5.2: Los usuarios deben poder actualizar el estado de una tarea.

6. **Notificaciones**
   - RF6.1: Los usuarios deben recibir notificaciones de tareas próximas a vencer.
   - RF6.2: Los usuarios deben recibir notificaciones de tareas vencidas.

## Requerimientos No Funcionales

1. **Seguridad**
   - RNF1.1: La información de los usuarios debe estar cifrada.
   - RNF1.2: La aplicación debe cumplir con los estándares de seguridad OWASP.

2. **Escalabilidad**
   - RNF2.1: La aplicación debe poder manejar hasta 10,000 usuarios concurrentes.
   - RNF2.2: La base de datos debe poder escalar para manejar un gran volumen de datos de tareas y proyectos.

3. **Usabilidad**
   - RNF3.1: La interfaz de usuario debe ser intuitiva y fácil de usar.
   - RNF3.2: La aplicación debe ser accesible desde dispositivos móviles y de escritorio.

4. **Performance**
   - RNF4.1: Las operaciones de carga de tareas y proyectos deben completarse en menos de 2 segundos.
   - RNF4.2: El sistema debe ser capaz de enviar notificaciones en tiempo real.

## Modelo de Datos

### Entidades y Relaciones

1. **Usuarios**
   - id_usuario (PK)
   - nombre
   - correo_electronico
   - contraseña

2. **Proyectos**
   - id_proyecto (PK)
   - nombre
   - descripcion
   - id_usuario (FK) 

3. **Tareas**
   - id_tarea (PK)
   - titulo
   - descripcion
   - fecha_vencimiento
   - prioridad
   - estado
   - id_usuario_asignado (FK)
   - id_proyecto (FK)

4. **Notificaciones**
   - id_notificacion (PK)
   - mensaje
   - fecha_envio
   - id_usuario (FK)
   - id_tarea (FK)

### Diagrama de Entidad-Relación (ERD)

![Diagrama-Entidad-Relación](/Imágenes/Diagramas/ERD.png)
### Diagrama de Clases

![Diagrama de Clases](/Imágenes/Diagramas/clases.png)
### Diagrama de Casos de Uso

![Diagrama de Casos de Uso](/Imágenes/Diagramas/casos%20de%20uso.png)
### Diagrama de Secuencia

![Diagrama de Secuencia](/Imágenes/Diagramas/secuencia.png)
# Gestión de Tareas - Tablas y Script SQL

## Tabla de Usuarios

| Campo             | Tipo         | Descripción                             |
|-------------------|--------------|-----------------------------------------|
| id_usuario        | INT          | Clave primaria, auto-incremental        |
| nombre            | VARCHAR(100) | Nombre del usuario                      |
| correo_electronico| VARCHAR(100) | Correo electrónico único del usuario    |
| contraseña        | VARCHAR(255) | Contraseña del usuario                  |

## Tabla de Proyectos

| Campo        | Tipo         | Descripción                               |
|--------------|--------------|-------------------------------------------|
| id_proyecto  | INT          | Clave primaria, auto-incremental          |
| nombre       | VARCHAR(100) | Nombre del proyecto                       |
| descripcion  | TEXT         | Descripción del proyecto                  |
| id_usuario   | INT          | Clave foránea, referencia a `Usuarios`    |

## Tabla de Tareas

| Campo               | Tipo         | Descripción                               |
|---------------------|--------------|-------------------------------------------|
| id_tarea            | INT          | Clave primaria, auto-incremental          |
| titulo              | VARCHAR(100) | Título de la tarea                        |
| descripcion         | TEXT         | Descripción de la tarea                   |
| fecha_vencimiento   | DATE         | Fecha de vencimiento de la tarea          |
| prioridad           | ENUM         | Prioridad de la tarea (Alta, Media, Baja) |
| estado              | ENUM         | Estado de la tarea (Pendiente, En Proceso, Completada) |
| id_usuario_asignado | INT          | Clave foránea, referencia a `Usuarios`    |
| id_proyecto         | INT          | Clave foránea, referencia a `Proyectos`   |

## Tabla de Notificaciones

| Campo        | Tipo         | Descripción                               |
|--------------|--------------|-------------------------------------------|
| id_notificacion | INT       | Clave primaria, auto-incremental          |
| mensaje      | TEXT         | Mensaje de la notificación                |
| fecha_envio  | DATETIME     | Fecha y hora de envío de la notificación  |
| id_usuario   | INT          | Clave foránea, referencia a `Usuarios`    |
| id_tarea     | INT          | Clave foránea, referencia a `Tareas`      |

## Script SQL

```sql
CREATE DATABASE gestion_tareas;

USE gestion_tareas;

-- Tabla de Usuarios
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL
);

-- Tabla de Proyectos
CREATE TABLE Proyectos (
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

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

```
# Gestión de Tareas - Tablas y Script SQL (Datos de Prueba)

### Tabla de Usuarios

| id_usuario | nombre     | correo_electronico   | contraseña  |
|------------|------------|----------------------|-------------|
| 1          | Juan Pérez | juan.perez@gmail.com | contraseña1 |
| 2          | María López| maria.lopez@gmail.com| contraseña2 |

### Tabla de Proyectos

| id_proyecto | nombre     | descripcion           | id_usuario |
|-------------|------------|-----------------------|------------|
| 1           | Proyecto A | Descripción del Proyecto A | 1 |
| 2           | Proyecto B | Descripción del Proyecto B | 2 |

### Tabla de Tareas

| id_tarea | titulo  | descripcion       | fecha_vencimiento | prioridad | estado      | id_usuario_asignado | id_proyecto |
|----------|---------|-------------------|-------------------|-----------|-------------|----------------------|-------------|
| 1        | Tarea 1 | Descripción de Tarea 1 | 2024-06-01        | Alta      | Pendiente   | 1                    | 1           |
| 2        | Tarea 2 | Descripción de Tarea 2 | 2024-06-02        | Media     | En Proceso | 2                    | 2           |

### Tabla de Notificaciones

| id_notificacion | mensaje                | fecha_envio        | id_usuario | id_tarea |
|-----------------|------------------------|--------------------|------------|----------|
| 1               | Notificación de Tarea 1| 2024-05-24 10:00:00| 1          | 1        |
| 2               | Notificación de Tarea 2| 2024-05-24 11:00:00| 2          | 2        |

```sql
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

```
# Modelo Vista Mockup

![Vista1](/Imágenes/Vistas//mockup.png)

# Ver Planificación

[Clic para acceder al Trello](https://trello.com/b/oXeUlYA5/proyecto-final)