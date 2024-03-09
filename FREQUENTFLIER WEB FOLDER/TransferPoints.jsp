<%@page import="java.sql.*"%>
<%
// Get the source passenger id, destination passenger id, and number of points to transfer from the request parameters
int sourcePid = Integer.parseInt(request.getParameter("spid"));
int destPid = Integer.parseInt(request.getParameter("dpid"));
int pointsToTransfer = Integer.parseInt(request.getParameter("npoints"));

// JDBC connection details
String jdbcUrl = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521:vse18c.vsnet.gmu.edu";
String user = "username";
String password = "password";

// Create a JDBC connection
Connection conn = null;
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(jdbcUrl, user, password);

    // Deduct the points from the source passenger
    PreparedStatement stmt1 = conn.prepareStatement("UPDATE Passengers SET points = points - ? WHERE passid = ?");
    stmt1.setInt(1, pointsToTransfer);
    stmt1.setInt(2, sourcePid);
    int rowsUpdated1 = stmt1.executeUpdate();
    stmt1.close();

    // Add the points to the destination passenger
    PreparedStatement stmt2 = conn.prepareStatement("UPDATE Passengers SET points = points + ? WHERE passid = ?");
    stmt2.setInt(1, pointsToTransfer);
    stmt2.setInt(2, destPid);
    int rowsUpdated2 = stmt2.executeUpdate();
    stmt2.close();

    // Commit the transaction
    conn.commit();

    // Render a success message
    out.println("<p>Transfer successful!</p>");

} catch (Exception e) {
    // Rollback the transaction if an error occurs
    if (conn != null) {
        conn.rollback();
    }
    // Render an error message
    out.println("<p>Error transferring points: " + e.getMessage() + "</p>");
} finally {
    // Close the JDBC connection
    if (conn != null) {
        conn.close();
    }
}
%>

