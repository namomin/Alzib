<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<html>
<head>
<script>
function showPopupAndGoBack() {
    alert('�̹� ��ä��� �̷¼��Դϴ�.');
    window.history.back();
}
</script>
</head>
<body>
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

    String selectStateQuery = "SELECT state FROM apply WHERE applyId = ?";
    PreparedStatement selectStateStmt = con.prepareStatement(selectStateQuery);
    selectStateStmt.setString(1, applyId);
    ResultSet stateRs = selectStateStmt.executeQuery();
    String state = "";
    if (stateRs.next()) {
        state = stateRs.getString("state");
    }

    if (state != null && state.equals("��ä��")) {
        // �̹� ���� ������ ��� �˾� ���� ���� �������� ���ư�
        out.println("<script>showPopupAndGoBack();</script>");
    } else {
        String applyUpdateQuery = "UPDATE apply SET state = '��ä��' WHERE applyId = ?";
        PreparedStatement applyUpdateStmt = con.prepareStatement(applyUpdateQuery);
        applyUpdateStmt.setString(1, applyId);
        applyUpdateStmt.executeUpdate();
        applyUpdateStmt.close();

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

        // ���� �������� �����̷�Ʈ
        response.sendRedirect("apply_resume.jsp?PostNum=" + PostNum + "&BId=" + BId + "&Title=" + URLEncoder.encode(Title, "UTF-8"));

        employeeRs.close();
        selectEmployeeStmt.close();
    }

    stateRs.close();
    selectStateStmt.close();
    con.close();
} catch (Exception e) {
    out.println(e);
}
%>
</body>
</html>
