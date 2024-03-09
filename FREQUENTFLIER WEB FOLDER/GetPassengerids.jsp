<%@ page import="java.sql.*" %>
<%
// Retrieve the current passenger id from the request parameters
String currentPid = request.getParameter("pid");

// Declare variables for database connection
Connection con = null;
Statement stmt = null;
ResultSet rs = null;

try {
    // Register the Oracle JDBC driver
    Class.forName("oracle.jdbc.driver.OracleDriver");

    // Create a connection to the database
    String url = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
    String username = "your_username";
    String password = "your_password";
    con = DriverManager.getConnection(url, username, password);

    // Execute the SQL query to retrieve passenger ids
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT passid FROM Passengers WHERE passid <> '" + currentPid + "'");

    // Output the passenger ids as a comma-separated list
    StringBuilder sb = new StringBuilder();
    while (rs.next()) {
        sb.append(rs.getString("passid")).append(",");
    }
    if (sb.length() > 0) {
        sb.setLength(sb.length() - 1); // remove the last comma
    }
    out.println(sb.toString());
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    // Close the database resources
    if (rs != null) {
        rs.close();
    }
    if (stmt != null) {
        stmt.close();
    }
    if (con != null) {
        con.close();
    }
}
%>
