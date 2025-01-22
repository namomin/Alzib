<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
try {
    String EId = request.getParameter("EId");
    String AName = request.getParameter("AName");

    String DB_URL="jdbc:mysql://localhost:3306/alzib";
    String DB_ID="multi";
    String DB_PASSWORD="abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    // ���� ��¥�� �������� ���� �ڹ��� Calendar Ŭ���� ���
    Calendar cal = Calendar.getInstance();
    java.sql.Date currentDate = new java.sql.Date(cal.getTimeInMillis());

    // retiredate ������Ʈ ����
    String updateRetireDateQuery = "UPDATE employee SET retiredate = ? WHERE EId = ?";
    PreparedStatement updateRetireDateStmt = con.prepareStatement(updateRetireDateQuery);
    updateRetireDateStmt.setDate(1, currentDate);
    updateRetireDateStmt.setString(2, EId);
    updateRetireDateStmt.executeUpdate();

    // state ������Ʈ ����
    String updateStateQuery = "UPDATE employee SET state = '���' WHERE EId = ?";
    PreparedStatement updateStateStmt = con.prepareStatement(updateStateQuery);
    updateStateStmt.setString(1, EId);
    updateStateStmt.executeUpdate();

    con.close();

    // mypage.jsp�� �����̷�Ʈ
    response.sendRedirect("mypageBoss.jsp");

} catch (Exception e) {
    out.println(e);
}
%>
