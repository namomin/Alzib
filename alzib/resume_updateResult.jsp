<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%
	int RId = request.getParameter("RId");
    String AId = request.getParameter("AId");
    String RTitle = request.getParameter("RTitle");

    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // �̷¼� ���� ������Ʈ ���� �ۼ�
        String query = "UPDATE resume SET RTitle = ?, ... WHERE RId = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, RTitle);
        // ������ ������ �������� ������ ���ε�

        pstmt.setString(20, RId); // RId�� ������ �Ķ����

        // ���� ����
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            out.println("�̷¼� ������ �Ϸ�Ǿ����ϴ�.");
            // �̵��� �������� redirect
            response.sendRedirect("������ �Ϸ�� ������.jsp");
        } else {
            out.println("�̷¼� ������ �����߽��ϴ�.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // �ڿ� ����
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
