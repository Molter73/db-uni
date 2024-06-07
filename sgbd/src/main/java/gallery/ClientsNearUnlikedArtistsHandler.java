package gallery;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

class ClientNearArtist {
	String client;
	String artist;

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}
}

public class ClientsNearUnlikedArtistsHandler implements HandleQueryResult {
	ArrayList<ClientNearArtist> clients = new ArrayList<>();

	@Override
	public void parse(ResultSet res) throws SQLException {
		while (res.next()) {
			ClientNearArtist client = new ClientNearArtist();
			client.setClient(res.getString("c.nombre"));
			client.setArtist(res.getString("art.nombre"));

			clients.add(client);
		}
	}

	@Override
	public String toString() {
		String out = "Clientes que viven cerca de artista que no les gustan:";

		for (ClientNearArtist client : clients) {
			out += "\n\t" + client.getClient() + " | " + client.getArtist();
		}

		return out;
	}
}
