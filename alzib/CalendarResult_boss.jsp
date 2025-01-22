<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
request.setCharacterEncoding("UTF-8");
// ���۵� ������ �ޱ�
String CId = (String) session.getAttribute("sid");
String cTime = request.getParameter("cTime");
String cSchedule = request.getParameter("cSchedule");
String selectedDate = request.getParameter("selectedDate");
String cTime1 = request.getParameter("cTime1");
String cTime2 = request.getParameter("cTime2");
String working = cTime1 + "��" + "~" + cTime2 + "��";


// �����ͺ��̽� ���� ����
String DB_URL = "jdbc:mysql://localhost:3306/alzib";
String DB_ID = "multi";
String DB_PASSWORD = "abcd";

Connection conn = null;
PreparedStatement pstmt = null;

// ���� ���
//out.println("CId: " + CId + "<br>");
//out.println("cTime: " + cTime + "<br>");
//out.println("cSchedule: " + cSchedule + "<br>");
//out.println("selectedDate: " + selectedDate + "<br>");

try {
    // �����ͺ��̽� ����
    conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

	// ������ ���� selectedDate�� ���� ���ڵ尡 �ִ��� Ȯ���ϰ� �ִٸ� ����
    String deleteQuery = "DELETE FROM Calendar WHERE CCalendar = ? and CSchedule = ?";
    pstmt = conn.prepareStatement(deleteQuery);
    pstmt.setString(1, selectedDate);
	pstmt.setString(2, cSchedule);
    pstmt.executeUpdate();
    
    // SQL ���� �����Ͽ� �����ͺ��̽��� ���� ����
    String query = "INSERT INTO Calendar (CId, CTime, CSchedule, CCalendar, working) VALUES (?, ?, ?, ?, ?)";
    pstmt = conn.prepareStatement(query);
    pstmt.setString(1, CId); // ���ǿ��� ����� ID ��������
    pstmt.setString(2, cTime);
    pstmt.setString(3, cSchedule);
    pstmt.setString(4, selectedDate);
	pstmt.setString(5, working);
    pstmt.executeUpdate();
    
    // ���� ���� �� �޽��� ���
    out.println("<script>");
    out.println("alert('������ ���������� ����Ǿ����ϴ�.');");
    out.println("window.location.href = 'Calendar_boss.jsp';");
    out.println("</script>");
} catch (Exception e) {
    out.println("<h2>���� �߻�: " + e.getMessage() + "</h2>");
    e.printStackTrace(new java.io.PrintWriter(out)); // JspWriter�� PrintWriter�� ��ȯ�Ͽ� ���
} finally {
    // ���ҽ� ����
    try {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
