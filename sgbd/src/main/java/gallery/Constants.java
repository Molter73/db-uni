package gallery;

public class Constants {
	public static final String MOST_PROFITABLE_TOPIC = "SELECT temas.nombre FROM temas " +
			"INNER JOIN leGusta ON leGusta.tema = temas.nombre " +
			"INNER JOIN clientes ON leGusta.cliente = clientes.dni " +
			"GROUP BY temas.nombre " +
			"ORDER BY SUM(clientes.gasto) DESC LIMIT 1;";

	public static final String PAINTER_AND_SCULPTOR = "SELECT DISTINCT artista FROM estilos e " +
			"WHERE EXISTS (SELECT * FROM estilos WHERE artista=e.artista AND estilo='escultura') " +
			"AND EXISTS (SELECT * FROM estilos WHERE artista=e.artista AND estilo='pintura') " +
			"AND NOT EXISTS (SELECT * FROM estilos WHERE artista=e.artista AND estilo='fotografia');";

	public static final String MOST_VALUABLE_ARTIST = "SELECT artista FROM obras " +
			"GROUP BY artista ORDER BY SUM(precio) DESC LIMIT 1;";

	public static final String CLASSIC_PORTRAITS = "SELECT * FROM obras " +
			"INNER JOIN clasificacion ON clasificacion.obra = obras.titulo " +
			"WHERE creacion < '2000-01-01' AND clasificacion.tema = 'retratos';";

	public static final String CLIENTS_NEAR_UNLIKED_ARTISTS = "SELECT * FROM clientes c " +
			"INNER JOIN artistas art ON art.codigo_postal = c.codigo_postal " +
			"WHERE art.nombre NOT IN (SELECT artista FROM leGustaArt WHERE cliente = c.dni) "+
			"ORDER BY c.codigo_postal, c.nombre;";

	public static final String QUERY_SEPARATOR = "################################################################";
}
