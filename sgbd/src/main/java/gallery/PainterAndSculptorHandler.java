package gallery;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PainterAndSculptorHandler implements HandleQueryResult {
	ArrayList<String> artistas = new ArrayList<>();

	@Override
	public void parse(ResultSet res) throws SQLException {
		while (res.next()) {
			artistas.add(res.getString("artista"));
		}
	}

	@Override
	public String toString() {
		String out = "Artistas que son pintores y escultores:\n";
		for (String artista : artistas) {
			out += "\t" + artista;
		}

		return out;
	}
}
