/**********************************************************/
/*   Park Service Application                             */
/*   By Eric Keep                                         */
/*   requires park1.java AND park2.java                   */
/*   please run parkservice.sql in sqlplus before running */
/*   This java program uses sql to display and modify     */
/*   data for a collection of parks                       */
/**********************************************************/

import java.io.*;
import java.sql.*;

class parkservice {

    public static void main (String args[])
	throws SQLException, IOException {

	park1 pk = new park1();
	boolean done;
	char ch, ch1;
	byte num = 0;

	try {
	    Class.forName ("oracle.jdbc.driver.OracleDriver");
	} catch (ClassNotFoundException e) {
	    System.out.println ("Could not load the driver");
	    return;
	}
	String user, pass;
	user = readEntry("userid  : ");
	pass = readEntry("password: ");

	// The following line was modified by Prof. Marling to work on prime

	Connection conn = DriverManager.getConnection
	    ("jdbc:oracle:thin:@deuce.cs.ohiou.edu:1521:class", user, pass);

	done = false;
	do {
	    pk.print_menu();
	    System.out.print("Type in your option: ");
	    System.out.flush();
	    ch = (char) System.in.read();
	    ch1 = (char) System.in.read();
	    switch (ch) {
	    case '1' :
		pk.add_animal(conn);
		break;
	    case '2' :
		pk.delete_animal(conn);
		break;
	    case '3' :
		pk.modify_animal(conn);
		break;
	    case '4' :
		pk.display_animals(conn);
		break;
	    case '5':
		pk.fishing_report(conn);
		break;
	    case '6':
		pk.plant_report(conn);
		break;
	    case 'q' :
		done = true;
		break;
	    default: System.out.println("Type in option again");
	    }
	} while (!done);
	
	// close the connection when finished
	conn.close();
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
