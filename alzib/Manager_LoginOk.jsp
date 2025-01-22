<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<%

    String MId = request.getParameter("MId");
    String MPW = request.getParameter("MPW");

    String DB_URL="jdbc:mysql://localhost:3306/alzib";
    String DB_ID="multi"; 
    String DB_PASSWORD="abcd";
    
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    // �α��� ���� ���θ� ������ ����
    boolean loginSuccess = false;
    
    try {
        // DB ���� ����
        
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL ���� ����
        String jsql = "SELECT * FROM manager WHERE MId = ? AND MPW = ?";
        pstmt = con.prepareStatement(jsql);
        pstmt.setString(1, MId);
        pstmt.setString(2, MPW);
        rs = pstmt.executeQuery();
        
        // ��� ó��
        if (rs.next()) {
            // �α��� ����
            // ���ǿ� ����� ���̵� ����
            session.setAttribute("sid", MId);
            loginSuccess = true;
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    
    } finally {
        // �ڿ� ����
        if (rs != null) {
            try { rs.close(); } catch (SQLException e) { /* ���� */ }
        }
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException e) { /* ���� */ }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { /* ���� */ }
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>������ �α���</title>
</head>
<body>
<%
    if (loginSuccess) { 
		response.sendRedirect("Manager_Main.jsp");
%>
<%
    } else {
%>
    <p>���̵� �Ǵ� ��й�ȣ�� Ʋ�Ƚ��ϴ�.</p>
    <button onclick="location.href='Manager_Login.html'">�α��� ȭ������ ���ư���</button>
<%
    }
%>
</body>
</html>
