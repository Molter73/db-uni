package gallery;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

class ClassicPortrait {
	String titulo;
	LocalDate creacion;

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public LocalDate getCreacion() {
		return creacion;
	}

	public void setCreacion(LocalDate creacion) {
		this.creacion = creacion;
	}
}

public class ClassicPortraitsHandler implements HandleQueryResult {
	ArrayList<ClassicPortrait> portraits = new ArrayList<>();

	@Override
	public void parse(ResultSet res) throws SQLException {
		while (res.next()) {
			ClassicPortrait portrait = new ClassicPortrait();
			portrait.setTitulo(res.getString("titulo"));
			portrait.setCreacion(res.getDate("creacion").toLocalDate());

			portraits.add(portrait);
		}
	}

	@Override
	public String toString() {
		String out = "Retratos previos al 2000:";
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/YYYY");

		for (ClassicPortrait portrait : portraits) {
			String date = formatter.format(portrait.getCreacion());
			out += "\n\t" + portrait.getTitulo() + " - " + date;
		}

		return out;
	}
}
