<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>

<%
String AId = (String) session.getAttribute("sid");

if (AId == null) {
    response.sendRedirect("login.html");
}

String PostNum = request.getParameter("PostNum"); 
String BId = request.getParameter("BId");

String DB_URL = "jdbc:mysql://localhost:3306/alzib";
String DB_ID = "multi";
String DB_PASSWORD = "abcd";
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    // resume ���̺��� AName ��ȸ
    String resumeQuery = "SELECT AName FROM resume WHERE RId = ?";
    pstmt = con.prepareStatement(resumeQuery);
    pstmt.setString(1, request.getParameter("RId"));
    rs = pstmt.executeQuery();
    String AName = "";
    if (rs.next()) {
        AName = rs.getString("AName");
    }

    String checkQuery = "SELECT * FROM apply WHERE PostNum = ? AND AId = ?";
    pstmt = con.prepareStatement(checkQuery);
    pstmt.setString(1, PostNum);
    pstmt.setString(2, AId);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        // ������ ���� PostNum�̶� AId�� �̹� ������ ��� ������ �� ���ٴ� �޼��� ����
        out.println("<script>");
        out.println("alert('�̹� ������ �����Դϴ�.');");
        out.println("history.back();"); // ���� ��������
        out.println("</script>");
    } else {
        String query = "INSERT INTO apply (PostNum, RId, BId, AId, AName) VALUES (?, ?, ?, ?, ?)";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, PostNum);
        pstmt.setString(2, request.getParameter("RId"));
        pstmt.setString(3, BId);
        pstmt.setString(4, AId);
        pstmt.setString(5, AName); // AName �߰�
        int result = pstmt.executeUpdate();

        response.sendRedirect("mypageAlba.jsp");
    }

} catch (Exception e) {
    out.println(e);
} finally {
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
