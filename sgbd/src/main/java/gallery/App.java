package gallery;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class App {
	HashMap<String, HandleQueryResult> queries = new HashMap<>();
	Properties props;

	App() throws FileNotFoundException, IOException, SQLException {
		queries.put(Constants.MOST_PROFITABLE_TOPIC, new MostProfitableTopicHandler());
		queries.put(Constants.PAINTER_AND_SCULPTOR, new PainterAndSculptorHandler());
		queries.put(Constants.MOST_VALUABLE_ARTIST, new MostValuableArtistHandler());
		queries.put(Constants.CLASSIC_PORTRAITS, new ClassicPortraitsHandler());
		queries.put(Constants.CLIENTS_NEAR_UNLIKED_ARTISTS, new ClientsNearUnlikedArtistsHandler());

		props = getConfiguration();

	}

	static private Properties getConfiguration() throws FileNotFoundException, IOException {
		String rootPath = Thread.currentThread().getContextClassLoader().getResource("").getPath();
		String propsPath = rootPath + "app.properties";

		Properties props = new Properties();
		props.load(new FileInputStream(propsPath));

		return props;
	}

	private Connection getDbConnection() throws SQLException {
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		return DriverManager.getConnection(
				props.getProperty("db_url"),
				props.getProperty("db_user"),
				props.getProperty("db_pass"));
	}

	private void runQueries(Connection con) throws SQLException {
		System.out.println(Constants.QUERY_SEPARATOR);
		for (Map.Entry<String, HandleQueryResult> query : queries.entrySet()) {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(query.getKey());

			HandleQueryResult handler = query.getValue();
			handler.parse(res);
			System.out.println(handler.toString());
			System.out.println(Constants.QUERY_SEPARATOR);

			stmt.close();
			res.close();
		}
	}

	public static void main(String[] args) throws SQLException, IOException {
		App app = new App();

		try (Connection con = app.getDbConnection()) {
			app.runQueries(con);
		}
	}
}
