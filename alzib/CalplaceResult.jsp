<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>


<%
    request.setCharacterEncoding("UTF-8");
	// 전송된 데이터 받기
	String CId = (String) session.getAttribute("sid");
    String cname = request.getParameter("cname");
    int cpay = Integer.parseInt(request.getParameter("cpay"));
    String csalary = request.getParameter("csalary");
    String ccolor = request.getParameter("ccolor");

    // 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 데이터베이스 연결
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 이미 동일한 CId와 CName을 가진 레코드가 있는지 확인하고 있다면 삭제
        String deleteQuery = "DELETE FROM CPlace WHERE CId = ? AND CName = ?";
        pstmt = conn.prepareStatement(deleteQuery);
        pstmt.setString(1, CId);
        pstmt.setString(2, cname);
        pstmt.executeUpdate();

        // SQL 쿼리 실행하여 데이터베이스에 근무지 정보 저장
        String query = "INSERT INTO CPlace (CId, CName, CPay, CSalary, CColor) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, CId); 
        pstmt.setString(2, cname);
        pstmt.setInt(3, cpay);
        pstmt.setString(4, csalary);
        pstmt.setString(5, ccolor);
        pstmt.executeUpdate();
        
        // 저장 성공 시 메시지 출력 또는 리다이렉션
        out.println("<script>");
        out.println("alert('근무지 정보를 저장했습니다.');");
        out.println("window.location.href = 'Calendar_alba.jsp';"); // 리다이렉션할 페이지로 변경
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
