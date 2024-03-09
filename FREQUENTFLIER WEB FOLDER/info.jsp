<%@ page import="java.sql.*" %>
<%
String pid = request.getParameter("pid");
String name = "";
int points = 0;

// Connect to the database
String url = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521:vse18c";
String user = "Savula7";
String password = "oofengim";
Connection conn = DriverManager.getConnection(url, user, password);

// Execute a query to retrieve the passenger name and points
String query = "SELECT pname, points FROM Passengers WHERE passid = ?";
PreparedStatement stmt = conn.prepareStatement(query);
stmt.setString(1, pid);
ResultSet rs = stmt.executeQuery();
if (rs.next()) {
    name = rs.getString("pname");
    points = rs.getInt("points");
}

// Close the database connection
rs.close();
stmt.close();
conn.close();
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Passenger Info</title>
</head>
<body>
	<h1>Passenger Info</h1>
	<p>Name: <%= name %></p>
	<p>Points: <%= points %></p>
</body>
</html>
