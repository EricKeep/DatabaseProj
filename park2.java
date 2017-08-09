/* park2.java */
/* contains functions to modify animal attributes as well as
   info about what parks an animal lives in */

import java.io.*;
import java.sql.*;

class park2 {
    
    void print_menu(){
	System.out.println("     MODIFY ANIMAL\n");
	System.out.println("(1) Edit Animal Attributes");
	System.out.println("(2) Add parks animal lives in");
	System.out.println("(3) Remove parks animal lives in");
	System.out.println("(q) Quit\n");
    }

    // edits various attributes of an animal - not what parks it lives in
    void edit_attributes(Connection conn, String animal)
	throws SQLException, IOException{
	String query1 = "select * from animal where Species = '"
	    + animal + "'";
	Statement stmt = conn.createStatement();
	ResultSet rset1 = stmt.executeQuery(query1);
	System.out.println("");
	System.out.println("Species | Class | Weight | Height | Diet | Active During");
	while (rset1.next ()) {
	    String data = rset1.getString(1) + " | " +
		rset1.getString(2) + " | " +
		rset1.getBigDecimal(3).doubleValue() + " | " +
		rset1.getBigDecimal(4).doubleValue() + " | " +
		rset1.getString(5) + " | " +
		rset1.getString(6);
	    System.out.println(data);
	}
	System.out.println("");
	System.out.println("Please enter new attributes: ");
	String cls = readEntry("Class : ");
	String wht = readEntry("Weight(lbs) : ");
	String ht = readEntry("Height(in.) : ");
	String dt = readEntry("Diet : ");
	String actve = readEntry("Active during : ");
	String query2 = "update animal set Class = '" + cls
	    + "', Weight = " + wht
	    + ", Height = " + ht
	    + ", Diet = '" + dt
	    + "', Active = '" + actve
	    + "' where Species = '" + animal + "'";
	try {
	    stmt.executeUpdate(query2);
	} catch (SQLException e) {
	    System.out.println("Error modifying animal");
	    while (e != null) {
		System.out.println("Message    : " + e.getMessage());
		e = e.getNextException();
	    }
	    return;
	}
	System.out.println("Animal modified succesfully");
	stmt.close();
    }

    // add additonal parks an animal might live in
    void add_park(Connection conn, String animal)
	throws SQLException, IOException {
	Statement stmt = conn.createStatement();
	System.out.println("Parks this animal does not currently live in: ");
	String query =
	    "select distinct Park_name from park where Park_name not in" +
	    " (select distinct P_name from lives_in where A_species = '" +
	    animal + "')";
	ResultSet rset1 = stmt.executeQuery(query);
	System.out.println("");
	while (rset1.next ()) {
	    System.out.println(rset1.getString(1));
	}
	System.out.println("");
	stmt.close();
	
	String prk;
	PreparedStatement stmt2 = conn.prepareStatement(
		"insert into lives_in values (?, ?)" );
	System.out.println("Enter additional parks this animal lives in:\n");
	do {
	    prk = readEntry("Park (0 to stop): ");
	    if (prk.equals("0"))
		break;
	    try {
		stmt2.setString(1, prk);
		stmt2.setString(2, animal);
		stmt2.executeUpdate();
	    } catch (SQLException e) {
		System.out.println("Park could not be added - error!");
		while (e != null) {
		    System.out.println("Message   : " + e.getMessage());
		    e = e.getNextException();
		}
	    }
	    System.out.println("Successfully added");
	} while (true);
	stmt2.close();
    }

    // remove parks an animal might be listed in
    void remove_park(Connection conn, String animal)
	throws SQLException, IOException {
	Statement stmt = conn.createStatement();
	System.out.println("List of parks animal lives in: ");
	String query =
	    "select distinct P_name from lives_in where A_species = '" +
	    animal + "'";
	ResultSet rset1 = stmt.executeQuery(query);
	System.out.println("");
	while (rset1.next ()) {
	    System.out.println(rset1.getString(1));
	}
	System.out.println("");
	stmt.close();

	String prk;
	PreparedStatement stmt2 = conn.prepareStatement(
	       "delete lives_in where A_species = '" + animal + "' and P_name = ?");
	System.out.println("Enter parks to remove animal from: \n");
	do {
	    prk = readEntry("Park (0 to stop): ");
	    if (prk.equals("0"))
		break;
	    try {
		stmt2.setString(1, animal);
		stmt2.executeUpdate();
	    } catch (SQLException e) {
		System.out.println("Park could not be deleted - error!");
		while (e != null) {
		    System.out.println("Message   : " + e.getMessage());
		    e = e.getNextException();
		}
	    }
	    System.out.println("Successfully deleted");
	} while (true);
	stmt2.close();
    }

    //readEntry function - used to get input strings
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
