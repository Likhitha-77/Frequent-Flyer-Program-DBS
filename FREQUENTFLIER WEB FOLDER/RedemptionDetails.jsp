<%@page import="java.sql.*" %>
<%
String awardid = request.getParameter("awardid");
String pid = request.getParameter("pid");

try {
    // Establish a connection to the database
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu","username","password");

    // Create a PreparedStatement to execute the SQL query
    String query = "SELECT description, points_needed, redemption_date, exchange_center_name FROM Awards, Redemption WHERE Awards.awardid=Redemption.awardid AND Awards.awardid=? AND Redemption.pid=?";
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setString(1, awardid);
    pstmt.setString(2, pid);

    // Execute the query and retrieve the results
    ResultSet rs = pstmt.executeQuery();
    if (rs.next()) {
        String description = rs.getString("description");
        int points_needed = rs.getInt("points_needed");
        Date redemption_date = rs.getDate("redemption_date");
        String exchange_center_name = rs.getString("exchange_center_name");

        // Output the results
        out.println("<h2>Award Description: " + description + "</h2>");
        out.println("<p>Points Needed: " + points_needed + "</p>");
        out.println("<p>Redemption Date: " + redemption_date + "</p>");
        out.println("<p>Exchange Center Name: " + exchange_center_name + "</p>");
    } else {
        out.println("<p>No redemption found for the specified award and passenger id.</p>");
    }

    // Clean up resources
    rs.close();
    pstmt.close();
    con.close();
} catch (Exception e) {
    out.println("<p>An error occurred: " + e.getMessage() + "</p>");
}
%>
