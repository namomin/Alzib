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
	String working = cTimea1 + "시" + "~" + cTimea2 + "시";

    // 대괄호 '['와 ']'를 제거하고 각 날짜를 ','를 기준으로 분리하여 배열로 만듭니다.
	String[] daysArray = DaysString.split(",");


    // DB 접속 정보
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    // Connection과 PreparedStatement 초기화
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 데이터베이스 연결
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        
        // Days에 있는 각 날짜를 분리하여 DB에 저장
        for (String date : daysArray) {
            // 양쪽에 있는 홑따옴표를 제거하여 DB에 저장할 날짜 형식을 만듭니다.
            String formattedDate = date.trim();

			// 기존에 같은 날짜와 스케줄을 가진 레코드가 있는지 확인하고 있다면 삭제
			String deleteQuery = "DELETE FROM Calendar WHERE CCalendar = ? and CSchedule = ?";
			pstmt = conn.prepareStatement(deleteQuery);
			pstmt.setString(1, formattedDate);
			pstmt.setString(2, cSchedule);
			pstmt.executeUpdate();

            // SQL 쿼리 실행하여 데이터베이스에 일정 저장
            String query = "INSERT INTO Calendar (CId, CTime, CSchedule, CCalendar, working) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, CId); // 세션에서 사용자 ID 가져오기
            pstmt.setString(2, cTime);
            pstmt.setString(3, cSchedule);
            pstmt.setString(4, formattedDate);
			pstmt.setString(5, working);
            pstmt.executeUpdate();
        }
        
        // 저장 성공 시 caltest4.jsp로 이동
        response.sendRedirect("Calendar_boss.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
        // 실패 시 에러 메시지 출력
        out.println("일정을 저장하는 도중 오류가 발생했습니다: " + e.getMessage());
    } finally {
        // 자원 해제
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
