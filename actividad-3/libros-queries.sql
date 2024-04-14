-- Cantidad de libros
SELECT COUNT(ISBN) FROM Books;

-- Cantidad de usuarios en spain, case insensitive.
SELECT COUNT(*) FROM Users WHERE Location LIKE '%spain%';

-- Libro más vendido (más ratings).
SELECT ISBN, Title FROM Books
    WHERE ISBN = (
        SELECT ISBN FROM Ratings GROUP BY ISBN
        ORDER BY COUNT(ISBN) DESC LIMIT 1
    ) LIMIT 1;

-- Libro más valorado por jóvenes (menores de 20 años)
--   La siguiente query asume que "más valorado" es el que tenga el
--   promedio de valoración más alto.
SELECT Books.ISBN, Title, AVG(Rating) book_rating FROM Books
    INNER JOIN Ratings ON Books.ISBN = Ratings.ISBN
    INNER JOIN Users ON Ratings.UserID = Users.UserID
    GROUP BY Books.ISBN HAVING Users.Age <= 20
    ORDER BY book_rating DESC LIMIT 1;
--   La siguiente query asume que "más valorado" es el que
--   tenga mayor cantidad de valoraciones.
SELECT Books.ISBN, Title, COUNT(Books.ISBN) FROM Books
    INNER JOIN Ratings ON Books.ISBN = Ratings.ISBN
    INNER JOIN Users ON Ratings.UserID = Users.UserID
    GROUP BY Books.ISBN HAVING Users.Age <= 20
    ORDER BY COUNT(Books.ISBN) DESC LIMIT 10;
--   En las 2 queries anteriores se podría utilizar subqueries, pero Ratings
--   puede contener ISBNs que no están en Books, por lo que un JOIN es
--   necesario para mitigar esta condición.

-- Top 5 libros vendidos en España
SELECT ISBN, Title FROM Books
    WHERE ISBN IN (
        SELECT ISBN FROM Ratings
        INNER JOIN Users ON Ratings.UserID = Users.UserID
        GROUP BY ISBN HAVING Location LIKE '%spain%'
        ORDER BY COUNT(ISBN) DESC LIMIT 5
    );
--   La siguiente query produce el mismo resultado que la anterior
--   pero permite ordenar la lista final, a costa de tener 2 joins
SELECT Books.ISBN, Title, COUNT(Books.ISBN) sales_count FROM Books
    INNER JOIN Ratings ON Books.ISBN = Ratings.ISBN
    INNER JOIN Users ON Ratings.UserID = Users.UserID
    GROUP BY Ratings.ISBN HAVING Location LIKE '%spain%'
    ORDER BY sales_count DESC LIMIT 5;
--   Otra alternativa si no nos interesa el ISBN es
--   aprovechar el VIEW librouser
SELECT Title, COUNT(Title) sales FROM librouser
    GROUP BY Title HAVING Location LIKE '%spain%'
    ORDER BY sales DESC LIMIT 5;
--   Las cuentas de las 2 últimas queries dan números distintos,
--   asumo que algunas entradas tendrán mal cargado el ISBN para el título.

-- Top 5 libros mejor calificados
SELECT Books.ISBN, Title, AVG(Rating) calificacion, COUNT(Ratings.ISBN) FROM Books
    INNER JOIN Ratings ON Books.ISBN = Ratings.ISBN
    GROUP BY Ratings.ISBN ORDER BY calificacion DESC LIMIT 5;
--   La query anterior muestra que los libros mejor calificados son
--   aquellos que tienen una única reseña con 10, se puede mejorar
--   el resultado si se pide que al menos se tengan algunas reseñas
SELECT Books.ISBN, Title, AVG(Rating) calificacion, COUNT(Ratings.ISBN) cantidad_resenas
    FROM Books INNER JOIN Ratings ON Books.ISBN = Ratings.ISBN
    GROUP BY Ratings.ISBN HAVING cantidad_resenas >= 10
    ORDER BY calificacion DESC LIMIT 5;

-- Libro más leído por jóvenes (menores de 20) de España
SELECT Author, COUNT(Author) sales FROM Books
    INNER JOIN Ratings ON Books.ISBN = Ratings.ISBN
    INNER JOIN Users ON Ratings.UserID = Users.UserID
    GROUP BY Author HAVING Users.Age <= 20
    ORDER BY sales DESC LIMIT 1;

-- Libros sin ventas
SELECT ISBN, Title FROM Books WHERE ISBN NOT IN (
    SELECT ISBN FROM Ratings
);

-- Usuario sin compras
SELECT UserID FROM Users WHERE UserID NOT IN (
    SELECT UserID FROM Ratings
);

-- Autor con mejor valoración
SELECT Author, AVG(Rating) calificacion, COUNT(Author) FROM Books
    INNER JOIN Ratings ON Books.ISBN = Ratings.ISBN
    GROUP BY Author ORDER BY calificacion DESC LIMIT 1;
--   De forma similar a la anterior query de mejor calificación,
--   los mejores son aquellos autores con una única reseña de 10.
--   Agregamos un pequeño filtro por cantidad de reseñas para conseguir
--   un resultado un poco más interesante.
SELECT Author, AVG(Rating) calificacion, COUNT(Author) cantidad_resenas FROM Books
    INNER JOIN Ratings ON Books.ISBN = Ratings.ISBN
    GROUP BY Author HAVING cantidad_resenas >= 20
    ORDER BY calificacion DESC LIMIT 1;
