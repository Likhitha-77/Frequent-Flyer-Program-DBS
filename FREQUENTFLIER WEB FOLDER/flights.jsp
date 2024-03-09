<%@page import="java.sql.*"%>
<%
    String pid = request.getParameter("pid");
    
    // create a connection to the database
    String url = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
    String username = "your_username";
    String password = "your_password";
    Connection conn = DriverManager.getConnection(url, username, password);
    
    // prepare the SQL statement to retrieve the flights for the given passenger
    String sql = "SELECT FLIGHTS.FID, FLIGHTS.MILES, FLIGHTS.DESTINATION " +
                 "FROM FLIGHTS, TICKETS " +
                 "WHERE FLIGHTS.FID = TICKETS.FID AND TICKETS.PID = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, pid);
    
    // execute the query and get the result set
    ResultSet rs = stmt.executeQuery();
%>
<html>
<head>
    <title>Flights for Passenger <%= pid %></title>
</head>
<body>
    <h1>Flights for Passenger <%= pid %></h1>
    <table border="1">
        <tr>
            <th>Flight ID</th>
            <th>Miles</th>
            <th>Destination</th>
        </tr>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getString("FID") %></td>
            <td><%= rs.getInt("MILES") %></td>
            <td><%= rs.getString("DESTINATION") %></td>
        </tr>
        <% } %>
    </table>
    <% 
        // close the result set, statement, and connection
        rs.close();
        stmt.close();
        conn.close();
    %>
</body>
</html>
