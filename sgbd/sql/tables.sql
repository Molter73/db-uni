CREATE TABLE IF NOT EXISTS artistas (
    nombre VARCHAR(255) NOT NULL PRIMARY KEY,
    fecha_nacimiento DATE NOT NULL,
    codigo_postal VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS estilos (
    estilo VARCHAR(64) CHECK (estilo IN ('escultura', 'pintura', 'fotografia')),
    artista VARCHAR(255) NOT NULL,
    FOREIGN KEY(artista)
        REFERENCES artistas(nombre)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS obras (
    titulo VARCHAR(255) NOT NULL PRIMARY KEY,
    creacion DATE NOT NULL,
    precio BIGINT NOT NULL,
    artista VARCHAR(255) NOT NULL,
    FOREIGN KEY(artista)
        REFERENCES artistas(nombre)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS temas (
    nombre VARCHAR(255) NOT NULL PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS clasificacion (
    obra VARCHAR(255) NOT NULL,
    tema VARCHAR(255) NOT NULL,
    FOREIGN KEY(obra)
        REFERENCES obras(titulo)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(tema)
        REFERENCES temas(nombre)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS clientes (
    dni VARCHAR(12) NOT NULL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    localidad VARCHAR(255) NOT NULL,
    calle VARCHAR(255) NOT NULL,
    numero INTEGER NOT NULL,
    codigo_postal VARCHAR(255) NOT NULL,
    gasto INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS leGusta (
    cliente VARCHAR(12) NOT NULL,
    tema VARCHAR(255) NOT NULL,
    FOREIGN KEY(cliente)
        REFERENCES clientes(dni)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(tema)
        REFERENCES temas(nombre)
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS leGustaArt (
    cliente VARCHAR(12) NOT NULL,
    artista VARCHAR(255) NOT NULL,
    FOREIGN KEY(cliente)
        REFERENCES clientes(dni)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(artista)
        REFERENCES artistas(nombre)
        ON UPDATE CASCADE ON DELETE CASCADE
);
