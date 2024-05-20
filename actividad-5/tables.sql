-- Ejercicio 1
CREATE DATABASE IF NOT EXISTS FROMLOITTE;
USE FROMLOITTE;

-- No creo que esta sea la forma correcta de hacerlo, pero TAREA, EVENTO y
-- ASIGNACION necesitan titulo para relacionarse entre ellas. Esta es la
-- única forma que se me ocurre de no tener duplicados y permitir que se
-- creen tareas y eventos sin una asignación directa.
CREATE TABLE IF NOT EXISTS TITULO (
    titulo VARCHAR(255) NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS EVENTO (
    titulo VARCHAR(255) NOT NULL PRIMARY KEY,
    descripcion VARCHAR(255),
    categoria VARCHAR(255) NOT NULL,
    fecha_inic DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    hora_inic TIME NOT NULL,
    hora_fin TIME NOT NULL,
    recordar VARCHAR(4) CHECK (recordar IN (
        '5m', '10m', '15m', '30m',
        '1h', '2h', '6h', '12h',
        '1d', '2d', '7d', '30d'
    )),
    proyecto VARCHAR(255) NOT NULL,
    FOREIGN KEY(titulo)
        REFERENCES TITULO(titulo)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS TAREA (
    titulo VARCHAR(255) NOT NULL PRIMARY KEY,
    descripcion VARCHAR(255),
    categoria VARCHAR(255) NOT NULL,
    fecha_inic DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(16) DEFAULT 'en proceso' CHECK (
        estado IN ('en proceso', 'acabada', 'cancelada')
    ),
    proyecto VARCHAR(255) NOT NULL,
    FOREIGN KEY(titulo)
        REFERENCES TITULO(titulo)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS EMPLEADO (
    dni VARCHAR(12) NOT NULL PRIMARY KEY,
    nombre VARCHAR(128),
    direccion VARCHAR(255),
    cargo VARCHAR(64),
    salario INT
);

CREATE TABLE IF NOT EXISTS ASIGNACION (
    titulo VARCHAR(255) NOT NULL,
    dni VARCHAR(12) NOT NULL,
    estimacion_horas INT,
    FOREIGN KEY(dni)
        REFERENCES EMPLEADO(dni)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(titulo)
        REFERENCES TITULO(titulo)
        ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(titulo, dni)
);

-- Modo de uso:
--  SELECT * FROM usuarios_view WHERE usuarios_view.dni = '12345678J';
CREATE OR REPLACE VIEW usuarios_view AS
    SELECT titulo FROM ASIGNACION
    ORDER BY dni;

-- Ejercicio 2
CREATE DATABASE IF NOT EXISTS CARS;
USE CARS;

CREATE TABLE IF NOT EXISTS ADMINISTRATIVO(
    dni_administrativo VARCHAR(12) NOT NULL PRIMARY KEY,
    nombre VARCHAR(128) NOT NULL,
    departamento VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS TURNOS (
    dni_administrativo VARCHAR(12) NOT NULL,
    turno TIME NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (dni_administrativo)
        REFERENCES ADMINISTRATIVO(dni_administrativo)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS VENDEDORES (
    dni_vendedor VARCHAR(12) NOT NULL PRIMARY KEY,
    nombre VARCHAR(128) NOT NULL,
    salario_base INT NOT NULL,
    comision FLOAT NOT NULL,
    limite_ventas INT
);

CREATE TABLE IF NOT EXISTS MECANICO (
    dni_mecanico VARCHAR(12) NOT NULL PRIMARY KEY,
    nombre VARCHAR(128) NOT NULL,
    especialidad VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS COCHES (
    matricula VARCHAR(8) NOT NULL PRIMARY KEY,
    modelo VARCHAR(4) CHECK (modelo in('207', '308', '407', '1007', '3008')),
    precio_coste INT NOT NULL,
    dni_vendedor VARCHAR(12) NOT NULL,
    precio_venta INT NOT NULL,
    mes_venta VARCHAR(32) CHECK (mes_venta IN (
        'enero', 'febrero', 'marzo',
        'abril', 'mayo', 'junio',
        'julio', 'agosto', 'septiembre',
        'octubre', 'noviembre', 'diciembre'
    )),
    FOREIGN KEY (dni_vendedor)
        REFERENCES VENDEDORES(dni_vendedor)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS REPARACIONES(
    dni_mecanico VARCHAR(12) NOT NULL PRIMARY KEY,
    fecha DATE NOT NULL,
    matricula VARCHAR(8) NOT NULL,
    FOREIGN KEY(matricula)
        REFERENCES COCHES(matricula)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE OR REPLACE VIEW salario_neto AS
    SELECT salario_base + comision * SUM(precio_venta - precio_coste) FROM VENDEDORES
        INNER JOIN COCHES ON COCHES.dni_vendedor = VENDEDORES.dni_vendedor
        WHERE mes_venta = 'diciembre'
        GROUP BY VENDEDORES.dni_vendedor;
