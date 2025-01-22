<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String CId = (String) session.getAttribute("sid");
    String placeNames = request.getParameter("deleteP");

    // 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;

    //out.println("<p>CId: " + CId + "</p>");
    //out.println("<p>placeNames: " + placeNames + "</p>");

    try {
        // 데이터베이스 연결
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 해당 근무지로 설정된 모든 일정을 삭제합니다.
        String deleteEventsQuery = "DELETE FROM Calendar WHERE CId = ? AND CSchedule = ?";
        pstmt = conn.prepareStatement(deleteEventsQuery);
        pstmt.setString(1, CId);
        pstmt.setString(2, placeNames);
        pstmt.executeUpdate();

        // 해당 근무지를 삭제합니다.
        String deletePlaceQuery = "DELETE FROM CPlace WHERE CId = ? AND CName = ?";
        pstmt = conn.prepareStatement(deletePlaceQuery);
        pstmt.setString(1, CId);
        pstmt.setString(2, placeNames);
        pstmt.executeUpdate();

        // 삭제 성공 시 메시지 출력 또는 리다이렉션
        out.println("<script>");
        out.println("alert('근무지와 해당 일정이 성공적으로 삭제되었습니다.');");
        out.println("window.location.href = 'Calendar_boss.jsp';"); // 리다이렉션할 페이지로 변경
        out.println("</script>");
    } catch (Exception e) {
        out.println("<h2>오류 발생: " + e.getMessage() + "</h2>");
        e.printStackTrace(new java.io.PrintWriter(out)); // JspWriter를 PrintWriter로 변환하여 사용
    } finally {
        // 리소스 해제
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
