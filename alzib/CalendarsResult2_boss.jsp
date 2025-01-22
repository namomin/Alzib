<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    
    String CId = (String) session.getAttribute("sid");
    String cTime = request.getParameter("bulkCTime");
    String cSchedule = request.getParameter("bulkCSchedule");
    String DaysString = request.getParameter("Days");
	String cTimea1 = request.getParameter("cTimea1");
	String cTimea2 = request.getParameter("cTimea2");
	String working = cTimea1 + "��" + "~" + cTimea2 + "��";

    // ���ȣ '['�� ']'�� �����ϰ� �� ��¥�� ','�� �������� �и��Ͽ� �迭�� ����ϴ�.
	String[] daysArray = DaysString.split(",");


    // DB ���� ����
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    // Connection�� PreparedStatement �ʱ�ȭ
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // �����ͺ��̽� ����
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        
        // Days�� �ִ� �� ��¥�� �и��Ͽ� DB�� ����
        for (String date : daysArray) {
            // ���ʿ� �ִ� Ȭ����ǥ�� �����Ͽ� DB�� ������ ��¥ ������ ����ϴ�.
            String formattedDate = date.trim();

			// ������ ���� ��¥�� �������� ���� ���ڵ尡 �ִ��� Ȯ���ϰ� �ִٸ� ����
			String deleteQuery = "DELETE FROM Calendar WHERE CCalendar = ? and CSchedule = ?";
			pstmt = conn.prepareStatement(deleteQuery);
			pstmt.setString(1, formattedDate);
			pstmt.setString(2, cSchedule);
			pstmt.executeUpdate();

            // SQL ���� �����Ͽ� �����ͺ��̽��� ���� ����
            String query = "INSERT INTO Calendar (CId, CTime, CSchedule, CCalendar, working) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, CId); // ���ǿ��� ����� ID ��������
            pstmt.setString(2, cTime);
            pstmt.setString(3, cSchedule);
            pstmt.setString(4, formattedDate);
			pstmt.setString(5, working);
            pstmt.executeUpdate();
        }
        
        // ���� ���� �� caltest4.jsp�� �̵�
        response.sendRedirect("Calendar_boss.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
        // ���� �� ���� �޽��� ���
        out.println("������ �����ϴ� ���� ������ �߻��߽��ϴ�: " + e.getMessage());
    } finally {
        // �ڿ� ����
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
