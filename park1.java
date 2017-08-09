/* park1.java
 * requires park2.java
 * contains various functions that query the associated sql database
 */

 // imports necessary java packages
import java.io.*;
import java.sql.*;

class park1 {

	//print menu function
    void print_menu(){
	System.out.println("      PARK SERVICE PROGRAM\n");
	System.out.println("(1) Add Animal");
	System.out.println("(2) Delete Animal");
	System.out.println("(3) Modify Animal info");
	System.out.println("(4) Display list of animals"); 
	System.out.println("(5) Fishing Report");
	System.out.println("(6) Plant Report");
	System.out.println("(q) Quit\n");
    }

    // adds an animal to the animal table, also keeping track
    // of parks it lives in under lives_in
    void add_animal(Connection conn) throws SQLException, IOException {
	    
		// Creates a statement for executing queries
		Statement stmt = conn.createStatement();
		
		// builds a query using several prompts
	    String spec = readEntry("Species Name: ");
	    String cls = readEntry("Class of Species : ");
	    String wht = readEntry("Average Weight(lbs) : ");
	    String ht = readEntry("Average Height(in.) : ");
	    String dt = readEntry("Diet (Herbivore, Carnivore, etc.) : ");
	    String actve = readEntry("Active during (Day, Night): ");
	    String query = "insert into animal values (" +
		"'" + spec + "', " +
		"'" + cls + "', " +
		wht + ", " +
		ht + ", " +
		"'" + dt + "', " +
		"'" + actve + "'"
		+ ")";
	    try {
		int nrows = stmt.executeUpdate(query);
	    } catch (SQLException e) {
		System.out.println("Error Adding Animal Entry");
		while (e != null) {
		    System.out.println("Message    : " + e.getMessage());
		    e = e.getNextException();
		}
		return;
	    }

	    System.out.println("Added Animal Entry");

	    String query2 = "select distinct Park_name from park";
		
		// result sets are used to display results of queries by parsing through them
	    ResultSet rset1 = stmt.executeQuery(query2);
	    System.out.println("");
	    while (rset1.next ()) {
		System.out.println(rset1.getString(1));
	    }
	    System.out.println("");
	    
	    String prk;
		
		// uses a prepared statement to add multiple tuples to the tables
	    PreparedStatement stmt2 = conn.prepareStatement(
		    "insert into lives_in values (?, ?)" );
	    System.out.println("Enter parks this animal lives in:\n");
	    do {
		prk = readEntry("Park (0 to stop): ");
		if (prk.equals("0"))
		    break;
		try {
		    stmt2.setString(1, prk);
		    stmt2.setString(2, spec);
		    stmt2.executeUpdate();
		} catch (SQLException e) {
		    System.out.println("Park could not be added - error!");
		    while (e != null) {
			System.out.println("Message   : " + e.getMessage());
			e = e.getNextException();
		    }
		}
		System.out.println("Successfully added");
	    } while (true); // loop terminates when a 0 is read
	    stmt2.close();
    }

    // deletes an animal from the animal table, as well as from lives_in
    void delete_animal(Connection conn) throws SQLException, IOException {
	Statement stmt = conn.createStatement();
	String query1 = "select distinct Species from animal";
	ResultSet rset1 = stmt.executeQuery(query1);
	System.out.println("");
	while(rset1.next() ){
	    System.out.println(rset1.getString(1));
	}
	System.out.println("");

	String spec = readEntry("Enter animal to delete:  ");

	String del_query1 = "delete lives_in where A_species = '" + spec + "'";
	String del_query2 = "delete animal where Species = '" + spec + "'";

	conn.setAutoCommit(false);
	int nrows;
	try {
	    nrows = stmt.executeUpdate(del_query1);
	    nrows = stmt.executeUpdate(del_query2);
	} catch (SQLException e) {
	    System.out.println("Error deleting animal");
	    while (e != null) {
		System.out.println("Message    : " + e.getMessage());
		e = e.getNextException();
	    }
	    conn.rollback();
	    return;
	}
	System.out.println("Deleted animal");
	conn.commit();
	conn.setAutoCommit(true);
	stmt.close();
    }

    // calls park2 to edit animal attributes or parks that an animal might live in
    void modify_animal(Connection conn) throws SQLException, IOException {
	Statement stmt = conn.createStatement();
	String query1 = "select distinct Species from animal";
	ResultSet rset1 = stmt.executeQuery(query1);
	System.out.println("");
	while(rset1.next() ){
	    System.out.println(rset1.getString(1));
	}
	System.out.println("");
	stmt.close();
	
	String anim = readEntry("Select Animal to modify: ");
	park2 pk2 = new park2();
	boolean done = false;
	char ch, ch1;

	do {
	    pk2.print_menu();
	    System.out.print("Type in your option:");
	    System.out.flush();
	    ch = (char) System.in.read();
	    ch1 = (char) System.in.read();
	    switch (ch) {
	    case '1':
		pk2.edit_attributes(conn, anim);
		break;
	    case '2':
		pk2.add_park(conn, anim);
		break;
	    case '3':
		pk2.remove_park(conn, anim);
		break;
	    case 'q':
		done = true;
		break;
	    default:
		System.out.println("Type in option again");
	    }
	} while (!done);	
    }

    // displays the animal table
    void display_animals(Connection conn) throws SQLException {
	Statement stmt = conn.createStatement();
	String query = "select * from animal";
	ResultSet rset1 = stmt.executeQuery(query);
	System.out.println("");
	System.out.println("Species | Class | Weight | Height | Diet | Active During");
	while(rset1.next ()){
	    String data = rset1.getString(1) + " | " +
		rset1.getString(2) + " | " +
		rset1.getBigDecimal(3).doubleValue() + " | " +
		rset1.getBigDecimal(4).doubleValue() + " | " +
		rset1.getString(5) + " | " +
		rset1.getString(6);
	    System.out.println(data);
	}
	System.out.println("");
	stmt.close();
    }

    // generates a report of different parks where you can find fish, as well as
    // landmarks you might be able to fish from
    void fishing_report(Connection conn) throws SQLException {
	Statement stmt = conn.createStatement();
	String query = "select distinct P_name, A_species from lives_in, animal where "
	    + "A_species = Species and Class = 'Fish' order by P_name";
	ResultSet rset1 = stmt.executeQuery(query);
	System.out.println("");
	System.out.println("Parks that contain fish: ");
	while(rset1.next ()){
	    System.out.println(rset1.getString(1) + " | " + rset1.getString(2));
	}
	System.out.println("");
	
	String query2 = "select distinct Park_name, Name from landmark, lives_in, animal where "
	    + "(Type = 'River' or Type = 'Lake' or Type = 'Waterfall')"
	    + "and Park_name = P_name and A_species = Species and Class = 'Fish' order by Park_name";
	ResultSet rset2 = stmt.executeQuery(query2);
	System.out.println("");
	System.out.println("Here are some places you might try fishing for them (ask if it's legal to fish there first!): ");
	while(rset2.next ()){
	    System.out.println(rset2.getString(1) + " | " + rset2.getString(2));
	}
	System.out.println("");
	stmt.close();
    }

    // gives a list of plants from rainforests and taigas
    void plant_report(Connection conn) throws SQLException {
	Statement stmt = conn.createStatement();
	String query = "select distinct Park_name, Biome, Species, Class from plant, grows_in, park where "
	    + "Biome = 'Rainforest' and Park_name = P_name and P_species = Species order by Park_name";
	ResultSet rset1 = stmt.executeQuery(query);
	System.out.println("");
	System.out.println("Plants that grow in Rainforests: ");
	while(rset1.next ()){
	    String data = rset1.getString(1) + " | " +
		rset1.getString(2) + " | " +
		rset1.getString(3) + " | " +
		rset1.getString(4);
	    System.out.println(data);
	}

	String query2 = "select distinct Park_name, Biome, Species, Class from plant, grows_in, park where "
	    + "Biome = 'Taiga' and Park_name = P_name and P_species = Species order by Park_name";
	ResultSet rset2 = stmt.executeQuery(query2);
	System.out.println("");
	System.out.println("Plants that grow in Taigas: ");
 	while(rset2.next ()){
	    String data = rset2.getString(1) + " | " +
		rset2.getString(2) + " | " +
		rset2.getString(3) + " | " +
		rset2.getString(4);
	    System.out.println(data);
	}
	stmt.close();
    }
    //readEntry function - used to read input string
    static String readEntry(String prompt) {
	try {
	    StringBuffer buffer = new StringBuffer();
	    System.out.print(prompt);
	    System.out.flush();
	    int c = System.in.read();
	    while (c != '\n' && c != -1) {
		buffer.append((char)c);
		c = System.in.read();
	    }
	    return buffer.toString().trim();
	} catch (IOException e) {
	    return "";
	}
    }
}
