<%@ page import="java.sql.*" %>
<%
  // Get the flight id parameter from the request
  String flightId = request.getParameter("flightid");

  // Set up a connection to the database
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;
  String dbUrl = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521:vse18c";
  String dbUser = "username";
  String dbPass = "password";

  try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

    // Retrieve flight details based on the flight id parameter
    stmt = conn.createStatement();
    String query = "SELECT dept_datetime, arrival_datetime, miles, trip_id, trip_miles FROM Flights JOIN TripFlights ON Flights.flight_id = TripFlights.flight_id WHERE Flights.flight_id = '" + flightId + "'";
    rs = stmt.executeQuery(query);

    // Print out the flight details in a table
    out.println("<html><head><title>Flight Details</title></head><body><h2>Flight Details</h2><table border='1'><tr><th>Dept Date/Time</th><th>Arrival Date/Time</th><th>Miles</th><th>Trip ID</th><th>Trip Miles</th></tr>");
    while (rs.next()) {
      out.println("<tr><td>" + rs.getString("dept_datetime") + "</td><td>" + rs.getString("arrival_datetime") + "</td><td>" + rs.getInt("miles") + "</td><td>" + rs.getString("trip_id") + "</td><td>" + rs.getInt("trip_miles") + "</td></tr>");
    }
    out.println("</table></body></html>");
  } catch (ClassNotFoundException e) {
    out.println("Class not found: " + e.getMessage());
  } catch (SQLException e) {
    out.println("SQL exception: " + e.getMessage());
  } finally {
    // Clean up resources
    try {
      if (rs != null) rs.close();
      if (stmt != null) stmt.close();
      if (conn != null) conn.close();
    } catch (SQLException e) {
      out.println("SQL exception during cleanup: " + e.getMessage());
    }
  }
%>
