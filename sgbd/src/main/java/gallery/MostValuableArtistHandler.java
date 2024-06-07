package gallery;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MostValuableArtistHandler implements HandleQueryResult {
	String artista;

	@Override
	public void parse(ResultSet res) throws SQLException {
		res.next();
		artista = res.getString("artista");
	}

	@Override
	public String toString() {
		return "Artista con mayor valor: " + artista;
	}
}
