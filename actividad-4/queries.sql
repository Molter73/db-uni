-- Las queries implementadas contienen algunas expresiones específicas de
-- SQLite, si se desean ejecutar en otro motor, modificaciones pueden ser
-- necesarias.
-------------------------------------------------------------------------------
-- Punto 1                                                                   --
-------------------------------------------------------------------------------
-- 1)
SELECT * FROM TAREA WHERE date('now') > fecha-fin AND estado != 'acabada';

-- 2)
SELECT DISTINCT nombre, direccion FROM EMPLEADO
    INNER JOIN ASIGNACION ON ASIGNACION.dni = EMPLEADO.dni
    INNER JOIN EVENTO ON EVENTO.titulo = ASIGNACION.titulo
    WHERE date('now') BETWEEN EVENTO.fecha-inicio AND EVENTO.fecha-fin AND
        time('now') BETWEEN EVENTO.hora-inicio AND EVENTO.hora-fin;

-- 3)
SELECT DISTINCT nombre FROM EMPLEADO
    INNER JOIN ASIGNACION ON ASIGNACION.dni = EMPLEADO.dni
    WHERE ASIGNACION.titulo = 'GESIST';

-- 4)
SELECT DISTINCT * FROM EMPLEADO
    WHERE dni IN (
        SELECT dni FROM ASIGNACION
            INNER JOIN TAREA ON TAREA.titulo = ASIGNACION.titulo
            WHERE TAREA.titulo = 'GESIST'
    ) AND dni NOT IN (
        SELECT dni FROM ASIGNACION
            INNER JOIN EVENTO ON EVENTO.titulo = ASIGNACION.titulo
            WHERE TAREA.titulo = 'GESIST'
    );

-- 5)
SELECT ASIGNACION.titulo, COUNT(DISTINCT dni) FROM ASIGNACION
    INNER JOIN TAREA ON ASIGNACION.titulo = TAREA.titulo
    GROUP BY ASIGNACION.titulo;

-- 6)
SELECT titulo FROM ASIGNACION
    GROUP BY titulo ORDER BY SUM(estimacion-horas) DESC LIMIT 1;

-- 7)
INSERT INTO ASIGNACION(titulo, dni, estimacion-horas) VALUES
    ('PR-09 PRUEBASE DE CAJA NEGRA', '12345678J', 80);

-- 8)
UPDATE EMPLEADO SET salario = salario * 1.1
    WHERE dni IN (
        SELECT dni FROM EMPLEADO
            WHERE salario < AVG(salario)
            GROUP BY titulo HAVING titulo = 'jefe'
    );

-------------------------------------------------------------------------------
-- Punto 2                                                                   --
-------------------------------------------------------------------------------
-- 1)
SELECT DISTINCT nombre FROM PERSONAJES
    WHERE puntuacion > 1000 AND nombre LIKE '%man%';

-- 2)
SELECT VIDEOJUEGOS.nombre, COUNT(DISTINCT PERSONAJES.personaje) FROM USOS
    INNER JOIN VIDEOJUEGOS ON VIDEOJUEGOS.videojuego = USOS.videojuego
    INNER JOIN PERSONAJES ON PERSONAJES.personaje = USOS.personaje
    GROUP BY VIDEOJUEGOS.videojuego ORDER BY VIDEOJUEGOS.nombre ASC;

-- 3)
UPDATE PERSONAJES SET puntuacion = puntuacion * 1.1
    WHERE personaje NOT IN (
        SELECT personaje FROM USOS WHERE cuota < 100
    );

-------------------------------------------------------------------------------
-- Punto 3                                                                   --
-------------------------------------------------------------------------------
-- 1)
SELECT USUARIO.DNI, NOMBRE FROM USUARIO
    INNER JOIN LEE ON LEE.DNI = USUARIO.DNI
    INNER JOIN PRESTADO_POR ON PRESTADO_POR.ISBN = LEE.ISBN
    WHERE PRESTADO_POR.IDBIBLIO IN (
        SELECT IDBIBLIO FROM BIBLIOTECA WHERE INVERSION > 6000
    ) AND LEE.ISBN = (
        SELECT ISBN FROM LIBRO WHERE TITULO = 'Viaje al centro de la tierra'
    );

-- 2)
SELECT *, COUNT(LIBRO.ISBN) AS read_books FROM USUARIO
    INNER JOIN LEE ON LEE.DNI = USUARIO.DNI
    INNER JOIN PRESTADO_POR ON PRESTADO_POR.ISBN = LEE.ISBN
    INNER JOIN BIBLIOTECA ON BIBLIOTECA.IDBIBLIO = PRESTADO_POR.IDBIBLIO
    INNER JOIN LIBRO ON LIBRO.ISBN = LEE.ISBN
    WHERE BIBLIOTECA.DISTRITO = 'Dulce Chacón' AND
        LIBRO.EDITORIAL = 'Thomson'
    GROUP BY USUARIO.DNI HAVING read_books = (
        SELECT COUNT(ISBN) FROM LIBRO WHERE EDITORIAL = 'Thomson'
    );

-- 3)
SELECT NOMBRE FROM USUARIO
    INNER JOIN LEE ON LEE.DNI = USUARIO.DNI
    WHERE LEE.IDBIBLIO IN (
        SELECT IDBIBLIO FROM BIBLIOTECA WHERE INVERSION > (
            SELECT INVERSION FROM BIBLIOTECA WHERE DISTRITO = 'Miguel de Cervantes'
        )
    );

-- 4)
SELECT DISTINCT EDITORIAL FROM LIBRO
    INNER JOIN PRESTADO_POR ON PRESTADO_POR.ISBN = LIBRO.ISBN
    WHERE PRESTADO_POR.IDBIBLIO IN (
        SELECT IDBIBLIO FROM BIBLIOTECA
        WHERE DISTRITO = 'oeste'
        GROUP BY IDBIBLIO HAVING AVG(INVERSION) < 12000
    );

-- 5)
SELECT DISTINCT NOMBRE FROM USUARIO
    INNER JOIN LEE ON LEE.DNI = USUARIO.DNI
    INNER JOIN PRESTADO_POR ON PRESTADO_POR.ISBN = LEE.ISBN
    WHERE PRESTADO_POR.IDBIBLIO IN (
        SELECT BIBLIOTECA.IDBIBLIO FROM BIBLIOTECA
            INNER JOIN PRESTADO_POR ON PRESTADO_POR.IDBIBLIO = BIBLIOTECA.IDBIBLIO
            WHERE DISTRITO = 'norte'
            GROUP BY BIBLIOTECA.IDBIBLIO HAVING
                COUNT(PRESTADO_POR.ISBN) > (
                    SELECT COUNT(PRESTADO_POR.ISBN) FROM PRESTADO_POR
                        INNER JOIN BIBLIOTECA ON BIBLIOTECA.IDBIBLIO = PRESTADO_POR.IDBIBLIO
                        INNER JOIN LEE ON LEE.ISBN = PRESTADO_POR.ISBN
                        WHERE LEE.DNI = (
                            SELECT DNI FROM USUARIO WHERE NOMBRE = 'Cala'
                        )
                )
    );

-- 6)
ALTER TABLE PRESTADO_POR ADD FECHA date;

-- 7)
SELECT * FROM USUARIO
    INNER JOIN LEE ON LEE.DNI = USUARIO.DNI
    INNER JOIN PRESTADO_POR ON PRESTADO_POR.ISBN = LEE.ISBN
    WHERE PRESTADO_POR.IDBIBLIO = (
        SELECT IDBIBLIO FROM BIBLIOTECA
        WHERE INVERSION = (
            SELECT MAX(INVERSION) FROM BIBLIOTECA
        )
    );

