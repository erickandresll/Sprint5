-- Creación de base de datos.

CREATE DATABASE soporte_en_que_puedo_ayudarte;

USE soporte_en_que_puedo_ayudarte;

-- Creación de usuarios con todo los privilegios.
CREATE USER 'erickandresll'@'localhost' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON *.* TO 'erickandresll'@'localhost';
FLUSH PRIVILEGES;


-- Se crea tabla usuarios (clientes)
CREATE TABLE Usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  apellido VARCHAR(255) NOT NULL,
  edad INT NOT NULL,
  email VARCHAR(255) NOT NULL,
  num_utilizacion INT DEFAULT 1
);

-- Tabla de operarios. 
CREATE TABLE Operarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  apellido VARCHAR(255) NOT NULL,
  edad INT NOT NULL,
  email VARCHAR(255) NOT NULL,
  num_soportes INT DEFAULT 1
);

-- Se reconoce quien es el operario y el usuario con las FOREIGN KEY. 
CREATE TABLE Soporte (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  id_operario INT,
  fecha DATE,
  evaluacion INT,
  FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
  FOREIGN KEY (id_operario) REFERENCES Operarios(id)
);


-- Se agregan datos para la tabla usuarios. 
INSERT INTO Usuarios (nombre, apellido, edad, email, num_utilizacion)
VALUES
  ('Juan', 'Pérez', 25, 'juan@example.com', 3),
  ('María', 'López', 30, 'maria@example.com', 1),
  ('Carlos', 'García', 35, 'carlos@example.com', 2),
  ('Laura', 'Gómez', 28, 'laura@example.com', 1),
  ('Pedro', 'Rodríguez', 22, 'pedro@example.com', 4);


-- Se agregar datos para la tabla operarios.
INSERT INTO Operarios (nombre, apellido, edad, email, num_soportes)
VALUES
  ('Alejandro', 'Sánchez', 30, 'alejandro@example.com', 2),
  ('Ana', 'Torres', 28, 'ana@example.com', 3),
  ('José', 'Hernández', 32, 'jose@example.com', 1),
  ('Marta', 'Díaz', 27, 'marta@example.com', 2),
  ('Andrés', 'López', 25, 'andres@example.com', 5);


-- Se generan 10 operaciones de soporte que se han realizado. 
INSERT INTO Soporte (id_usuario, id_operario, fecha, evaluacion)
VALUES
  (1, 2, '2023-05-01', 6),
  (2, 4, '2023-05-02', 5),
  (3, 1, '2023-05-03', 7),
  (4, 5, '2023-05-04', 4),
  (5, 3, '2023-05-05', 6),
  (1, 4, '2023-05-06', 7),
  (3, 2, '2023-05-07', 6),
  (2, 5, '2023-05-08', 3),
  (4, 1, '2023-05-09', 5),
  (5, 3, '2023-05-10', 7);

-- Seleccione las 3 operaciones con mejor evaluación.
SELECT * FROM Soporte
ORDER BY evaluacion DESC
LIMIT 3;

-- Seleccione las 3 operaciones con menos evaluación.
SELECT * FROM Soporte
ORDER BY evaluacion
LIMIT 3;

-- Seleccione al operario que más soportes ha realizado.
SELECT Operarios.*, COUNT(Soporte.id_operario) AS num_soportes_realizados
FROM Operarios
JOIN Soporte ON Operarios.id = Soporte.id_operario
GROUP BY Operarios.id
ORDER BY num_soportes_realizados DESC
LIMIT 1;

-- Seleccione al cliente que menos veces ha utilizado la aplicación.
SELECT Usuarios.*, MIN(num_utilizacion) AS min_utilizacion
FROM Usuarios;

-- Agregue 10 años a los tres primeros usuarios registrados.
UPDATE Usuarios
SET edad = edad + 10
WHERE id IN (1, 2, 3);

-- Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email.
ALTER TABLE Usuarios
CHANGE COLUMN `correo electrónico` email VARCHAR(255);

ALTER TABLE Operarios
CHANGE COLUMN `correo electrónico` email VARCHAR(255);

ALTER TABLE Soporte
CHANGE COLUMN `correo electrónico` email VARCHAR(255);

-- Seleccione solo los operarios mayores de 20 años.
SELECT * FROM Operarios
WHERE edad > 20;