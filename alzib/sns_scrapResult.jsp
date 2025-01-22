<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>

<%
    String userId = (String) session.getAttribute("sid");
    if (userId == null) {
        response.sendRedirect("login.html");
    }

    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String SId = request.getParameter("SId");

        // ���� ���̵�(userId)�� ���� �Խñ�(SId)�� ��ũ������ �ִ��� Ȯ��
        String checkSql = "SELECT COUNT(*) AS count FROM scrap WHERE SId = ? AND userId = ?";
        PreparedStatement checkStmt = con.prepareStatement(checkSql);
        checkStmt.setString(1, SId);
        checkStmt.setString(2, userId);
        ResultSet checkResult = checkStmt.executeQuery();
        checkResult.next();
        int count = checkResult.getInt("count");

        if (count > 0) {
            // ������ SId ���� userId�� �̹� �����ϸ� ��ũ�� �Ұ����� ���� �޽��� ǥ��
            out.println("�̹� ��ũ���� �Խñ��Դϴ�.");
        } else {
            // ������ SId ���� userId�� �������� ������ ��ũ�� ����
            String insertSql = "INSERT INTO scrap (SId, userId) VALUES (?, ?)";
            PreparedStatement pstmt = con.prepareStatement(insertSql);
            pstmt.setString(1, SId);
            pstmt.setString(2, userId);
            pstmt.executeUpdate();
            out.println("�Խñ��� ��ũ���Ǿ����ϴ�.");
        }

        con.close();

        // ��ũ���� �Խñ��� �󼼺��� �������� �̵�
        String redirectUrl = "sns_detailview.jsp?SId=" + SId;
        response.sendRedirect(redirectUrl);
    } catch (Exception e) {
        out.println(e);
    }
%>
