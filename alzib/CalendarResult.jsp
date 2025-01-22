<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
request.setCharacterEncoding("UTF-8");
// 전송된 데이터 받기
String CId = (String) session.getAttribute("sid");
String cTime = request.getParameter("cTime");
String cSchedule = request.getParameter("cSchedule");
String selectedDate = request.getParameter("selectedDate");

// 데이터베이스 연결 정보
String DB_URL = "jdbc:mysql://localhost:3306/alzib";
String DB_ID = "multi";
String DB_PASSWORD = "abcd";

Connection conn = null;
PreparedStatement pstmt = null;

// 변수 출력
//out.println("CId: " + CId + "<br>");
//out.println("cTime: " + cTime + "<br>");
//out.println("cSchedule: " + cSchedule + "<br>");
//out.println("selectedDate: " + selectedDate + "<br>");

try {
    // 데이터베이스 연결
    conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

	// 기존에 같은 selectedDate를 가진 레코드가 있는지 확인하고 있다면 삭제
    String deleteQuery = "DELETE FROM Calendar WHERE CCalendar = ? and CSchedule = ?";
    pstmt = conn.prepareStatement(deleteQuery);
    pstmt.setString(1, selectedDate);
	pstmt.setString(2, cSchedule);
    pstmt.executeUpdate();
    
    // SQL 쿼리 실행하여 데이터베이스에 일정 저장
    String query = "INSERT INTO Calendar (CId, CTime, CSchedule, CCalendar) VALUES (?, ?, ?, ?)";
    pstmt = conn.prepareStatement(query);
    pstmt.setString(1, CId); // 세션에서 사용자 ID 가져오기
    pstmt.setString(2, cTime);
    pstmt.setString(3, cSchedule);
    pstmt.setString(4, selectedDate);
    pstmt.executeUpdate();
    
    // 저장 성공 시 메시지 출력
    out.println("<script>");
    out.println("alert('일정이 성공적으로 저장되었습니다.');");
    out.println("window.location.href = 'Calendar_alba.jsp';");
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
