<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%
try {
	String Title = request.getParameter("Title");
    String applyId = request.getParameter("applyId");
    String PostNum = request.getParameter("PostNum");
	String RId = request.getParameter("RId");
	String BId = request.getParameter("BId");

    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    String applyQuery = "UPDATE apply SET state = 'ºÒÃ¤¿ë' WHERE applyId = ?";
    PreparedStatement applyPstmt = con.prepareStatement(applyQuery);
    applyPstmt.setString(1, applyId);
    applyPstmt.executeUpdate();
    applyPstmt.close();

    String selectEmployeeQuery = "SELECT * FROM employee WHERE RId = ?";
    PreparedStatement selectEmployeeStmt = con.prepareStatement(selectEmployeeQuery);
    selectEmployeeStmt.setString(1, RId);
    ResultSet employeeRs = selectEmployeeStmt.executeQuery();

    if (employeeRs.next()) {
        String deleteEmployeeQuery = "DELETE FROM employee WHERE RId = ?";
        PreparedStatement deleteEmployeeStmt = con.prepareStatement(deleteEmployeeQuery);
        deleteEmployeeStmt.setString(1, RId);
        deleteEmployeeStmt.executeUpdate();
        deleteEmployeeStmt.close();
    }

    response.sendRedirect("mypageBoss.jsp");
    
    employeeRs.close();
    selectEmployeeStmt.close();
    con.close();
} catch (Exception e) {
    out.println(e);
}
%>
