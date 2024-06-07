package gallery;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MostProfitableTopicHandler implements HandleQueryResult {
	String nombre;

	@Override
	public void parse(ResultSet res) throws SQLException {
		res.next();
		nombre = res.getString("nombre");
	}

	@Override
	public String toString() {
		return "Tema más rentable: " + nombre;
	}
}
