INSERT INTO artistas (nombre, fecha_nacimiento, codigo_postal) VALUES
    ('Pablo Picasso', '1881-10-25', '12345'),
    ('Vincent van Gogh', '1853-03-30', '12346'),
    ('Leonardo da Vinci', '1452-04-15', '654321'),
    ('Auguste Rodin', '1840-11-12', '654321'),
    ('Claude Monet', '1840-11-14', '54334'),
    ('Jackson Pollock', '1912-01-28', '872345'),
    ('Ansel Adams', '1902-02-20', '872337'),
    ('Frida Kahlo', '1907-07-06', '872385'),
    ('Damien Hirst', '1965-06-07', '654321'),
    ('Andy Warhol', '1928-08-06', '872385');

INSERT INTO estilos (artista, estilo) VALUES
    ('Pablo Picasso', 'pintura'),
    ('Vincent van Gogh', 'pintura'),
    ('Leonardo da Vinci', 'pintura'),
    ('Leonardo da Vinci', 'escultura'),
    ('Auguste Rodin', 'escultura'),
    ('Claude Monet', 'pintura'),
    ('Jackson Pollock', 'pintura'),
    ('Ansel Adams', 'fotografia'),
    ('Frida Kahlo', 'pintura'),
    ('Damien Hirst', 'escultura'),
    ('Andy Warhol', 'pintura');

INSERT INTO obras (titulo, creacion, precio, artista) VALUES
    ('Las Señoritas de Avignon', '1907-07-01', 100000000, 'Pablo Picasso'),
    ('Guernica', '1937-06-01', 200000000, 'Pablo Picasso'),
    ('La Mujer que Llora', '1937-10-26', 50000000, 'Pablo Picasso'),
    ('La Noche Estrellada', '1889-06-01', 100000000, 'Vincent van Gogh'),
    ('Girasoles', '1888-08-01', 80000000, 'Vincent van Gogh'),
    ('Lirios', '1889-05-01', 60000000, 'Vincent van Gogh'),
    ('Mona Lisa', '1506-01-01', 860000000, 'Leonardo da Vinci'),
    ('La Última Cena', '1498-01-01', 450000000, 'Leonardo da Vinci'),
    ('El Hombre de Vitruvio', '1490-01-01', 100000000, 'Leonardo da Vinci'),
    ('El Pensador', '1904-08-16', 15000000, 'Auguste Rodin'),
    ('El Beso', '1882-01-01', 10000000, 'Auguste Rodin'),
    ('Las Puertas del Infierno', '1880-01-01', 20000000, 'Auguste Rodin'),
    ('Nenúfares', '1916-01-01', 50000000, 'Claude Monet'),
    ('Impresión, Sol Naciente', '1872-11-13', 100000000, 'Claude Monet'),
    ('Mujer con Sombrilla', '1875-01-01', 40000000, 'Claude Monet'),
    ('Nº 5, 1948', '1948-01-01', 140000000, 'Jackson Pollock'),
    ('Postes Azules', '1952-01-01', 100000000, 'Jackson Pollock'),
    ('Convergencia', '1952-01-01', 30000000, 'Jackson Pollock'),
    ('Salida de la Luna, Hernández, Nuevo México', '1941-11-01', 600000, 'Ansel Adams'),
    ('Tormenta Invernal Despejando', '1944-11-01', 500000, 'Ansel Adams'),
    ('Álamos, Norte de Nuevo México', '1958-01-01', 400000, 'Ansel Adams'),
    ('Las Dos Fridas', '1939-01-01', 20000000, 'Frida Kahlo'),
    ('Autorretrato con Collar de Espinas y Colibrí', '1940-01-01', 10000000, 'Frida Kahlo'),
    ('La Columna Rota', '1944-01-01', 15000000, 'Frida Kahlo'),
    ('La Imposibilidad Física de la Muerte en la Mente de Alguien Vivo', '1991-01-01', 12000000, 'Damien Hirst'),
    ('Por el Amor de Dios', '27-06-01', 100000000, 'Damien Hirst'),
    ('Made e Hijo (Divididos)', '1993-01-01', 15000000, 'Damien Hirst'),
    ('Díptico de Marilyn', '1962-08-01', 80000000, 'Andy Warhol'),
    ('Latas de Sopa Campbell', '1962-07-09', 75000000, 'Andy Warhol'),
    ('Ocho Elvises', '1963-01-01', 100000000, 'Andy Warhol');

INSERT INTO temas (nombre, descripcion) VALUES
    ('cubismo', 'Estilo que utiliza formas geométricas para representar personas en múltiples perspectivas'),
    ('surrealismo', 'Estilo que expresa sueños y pensamientos subconcientes, generalmente bizarros o fantásticos'),
    ('post-impresionismo', 'Evolución del impresionismo con más émfasis en colores y formas'),
    ('renacimiento', 'Estilo enfocado en temas clásicos, humanismo y perspectivas realistas'),
    ('realismo', 'Arte que muestra aspectos de la vida cotidiana sin idealización'),
    ('impresionismo', 'Arte que captura la luz y movimiento con colores vibrantes'),
    ('expresionismo abstracto', 'Estilo que enfatiza la espontaneidad, formas abstractas y la intensidad emocional'),
    ('paisajes', 'Arte mostrando escenarios naturales como montañas, valles y bosques'),
    ('arte contemporaneo', 'Arte creado en los siglos 20 y 21 en diversos estilos y medios'),
    ('arte pop', 'Imagenes de la cultura popular, usando colores brillantes e imágenes comerciales'),
    ('retratos', 'Pintura o efigie de una persona');

INSERT INTO clasificacion (obra, tema) VALUES
    ('Las Señoritas de Avignon', 'cubismo'),
    ('Guernica', 'cubismo'),
    ('La Mujer que Llora', 'cubismo'),
    ('La Noche Estrellada', 'post-impresionismo'),
    ('Girasoles', 'post-impresionismo'),
    ('Lirios', 'post-impresionismo'),
    ('Mona Lisa', 'renacimiento'),
    ('La Última Cena', 'renacimiento'),
    ('El Hombre de Vitruvio', 'renacimiento'),
    ('El Pensador', 'realismo'),
    ('El Beso', 'realismo'),
    ('Las Puertas del Infierno', 'realismo'),
    ('Nenúfares', 'impresionismo'),
    ('Impresión, Sol Naciente', 'impresionismo'),
    ('Mujer con Sombrilla', 'impresionismo'),
    ('Nº 5, 1948', 'expresionismo abstracto'),
    ('Postes Azules', 'expresionismo abstracto'),
    ('Convergencia', 'expresionismo abstracto'),
    ('Salida de la Luna, Hernández, Nuevo México', 'paisajes'),
    ('Tormenta Invernal Despejando', 'paisajes'),
    ('Álamos, Norte de Nuevo México', 'paisajes'),
    ('Las Dos Fridas', 'surrealismo'),
    ('Las Dos Fridas', 'retratos'),
    ('Autorretrato con Collar de Espinas y Colibrí', 'surrealismo'),
    ('Autorretrato con Collar de Espinas y Colibrí', 'retratos'),
    ('La Columna Rota', 'surrealismo'),
    ('La Imposibilidad Física de la Muerte en la Mente de Alguien Vivo', 'arte contemporaneo'),
    ('Por el Amor de Dios', 'arte contemporaneo'),
    ('Made e Hijo (Divididos)', 'arte contemporaneo'),
    ('Made e Hijo (Divididos)', 'arte pop'),
    ('Díptico de Marilyn', 'arte pop'),
    ('Díptico de Marilyn', 'retratos'),
    ('Latas de Sopa Campbell', 'arte pop'),
    ('Ocho Elvises', 'arte pop');

INSERT INTO clientes (dni, nombre, localidad, calle, numero, codigo_postal, gasto) VALUES
    ('12345678J', 'Bill Gates', 'Washington', 'Fake Street', '1234', '123456', 20000000),
    ('12345687J', 'Jeffrey Bezos', 'Oklahoma', 'Real Street', '4321', '654321', 50000000),
    ('87654321A', 'Elon Musk', 'Sudáfrica', 'Some Street', '4321', '654321', 100000000),
    ('87654386C', 'Juan Pérez García', 'Granada', 'Carril del Picón', '11', '18004', 100);

INSERT INTO leGusta (cliente, tema) VALUES
    ('12345678J', 'cubismo'),
    ('12345678J', 'renacimiento'),
    ('12345687J', 'paisajes'),
    ('12345687J', 'arte pop'),
    ('87654321A', 'surrealismo'),
    ('87654321A', 'arte pop'),
    ('87654386C', 'expresionismo abstracto');

INSERT INTO leGustaArt (cliente, artista) VALUES
    ('12345678J', 'Pablo Picasso'),
    ('12345678J', 'Vincent van Gogh'),
    ('12345687J', 'Leonardo da Vinci'),
    ('12345687J', 'Auguste Rodin'),
    ('87654321A', 'Damien Hirst'),
    ('87654321A', 'Frida Kahlo'),
    ('87654386C', 'Leonardo da Vinci');
