<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>


<%
    request.setCharacterEncoding("UTF-8");
	// ���۵� ������ �ޱ�
	String CId = (String) session.getAttribute("sid");
    String cname = request.getParameter("cname");
    int cpay = Integer.parseInt(request.getParameter("cpay"));
    String csalary = request.getParameter("csalary");
    String ccolor = request.getParameter("ccolor");

    // �����ͺ��̽� ���� ����
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // �����ͺ��̽� ����
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // �̹� ������ CId�� CName�� ���� ���ڵ尡 �ִ��� Ȯ���ϰ� �ִٸ� ����
        String deleteQuery = "DELETE FROM CPlace WHERE CId = ? AND CName = ?";
        pstmt = conn.prepareStatement(deleteQuery);
        pstmt.setString(1, CId);
        pstmt.setString(2, cname);
        pstmt.executeUpdate();

        // SQL ���� �����Ͽ� �����ͺ��̽��� �ٹ��� ���� ����
        String query = "INSERT INTO CPlace (CId, CName, CPay, CSalary, CColor) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, CId); 
        pstmt.setString(2, cname);
        pstmt.setInt(3, cpay);
        pstmt.setString(4, csalary);
        pstmt.setString(5, ccolor);
        pstmt.executeUpdate();
        
        // ���� ���� �� �޽��� ��� �Ǵ� �����̷���
        out.println("<script>");
		out.println("alert('�ٹ��� ������ �����߽��ϴ�.');");
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
