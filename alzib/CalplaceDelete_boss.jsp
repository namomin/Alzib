<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String CId = (String) session.getAttribute("sid");
    String placeNames = request.getParameter("deleteP");

    // �����ͺ��̽� ���� ����
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;

    //out.println("<p>CId: " + CId + "</p>");
    //out.println("<p>placeNames: " + placeNames + "</p>");

    try {
        // �����ͺ��̽� ����
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // �ش� �ٹ����� ������ ��� ������ �����մϴ�.
        String deleteEventsQuery = "DELETE FROM Calendar WHERE CId = ? AND CSchedule = ?";
        pstmt = conn.prepareStatement(deleteEventsQuery);
        pstmt.setString(1, CId);
        pstmt.setString(2, placeNames);
        pstmt.executeUpdate();

        // �ش� �ٹ����� �����մϴ�.
        String deletePlaceQuery = "DELETE FROM CPlace WHERE CId = ? AND CName = ?";
        pstmt = conn.prepareStatement(deletePlaceQuery);
        pstmt.setString(1, CId);
        pstmt.setString(2, placeNames);
        pstmt.executeUpdate();

        // ���� ���� �� �޽��� ��� �Ǵ� �����̷���
        out.println("<script>");
        out.println("alert('�ٹ����� �ش� ������ ���������� �����Ǿ����ϴ�.');");
        out.println("window.location.href = 'Calendar_boss.jsp';"); // �����̷����� �������� ����
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
