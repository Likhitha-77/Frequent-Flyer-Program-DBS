<%@ page import="java.sql.*" %>
<%
    String pid = request.getParameter("pid");
    String query = "SELECT DISTINCT award_id FROM Awards WHERE passid = " + pid;
    String result = "";

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu", "your_username", "your_password");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        while(rs.next()) {
            result += rs.getString("award_id") + "\n";
        }

        con.close();
    } catch(Exception e) {
        System.out.println(e);
    }
%>
<%= result %>
