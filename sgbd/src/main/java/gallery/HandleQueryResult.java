package gallery;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface HandleQueryResult {
	void parse(ResultSet res) throws SQLException;
}
