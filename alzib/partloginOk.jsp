<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String aId = request.getParameter("aId");
    String aPasswd = request.getParameter("aPasswd");

    String DB_URL="jdbc:mysql://localhost:3306/alzib";
    String DB_ID="multi"; 
    String DB_PASSWORD="abcd";
    
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    // 로그인 성공 여부를 저장할 변수
    boolean loginSuccess = false;
    
    try {
        // DB 연결 설정
        
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL 쿼리 실행
        String jsql = "SELECT * FROM alba WHERE aId = ? AND aPasswd = ?";
        pstmt = con.prepareStatement(jsql);
        pstmt.setString(1, aId);
        pstmt.setString(2, aPasswd);
        rs = pstmt.executeQuery();
        
        // 결과 처리
        if (rs.next()) {
            // 로그인 성공
            // 세션에 사용자 아이디 저장
            session.setAttribute("sid", aId);
            loginSuccess = true;
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    
    } finally {
        // 자원 해제
        if (rs != null) {
            try { rs.close(); } catch (SQLException e) { /* 무시 */ }
        }
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException e) { /* 무시 */ }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { /* 무시 */ }
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>알바생 로그인</title>
</head>
<body>
<%
    if (loginSuccess) {
		response.sendRedirect("index_alba.jsp"); 
%>
<%
    } else {
%>
    <p>아이디 또는 비밀번호가 틀렸습니다.</p>
    <button onclick="location.href='partlogin.html'">로그인 화면으로 돌아가기</button>
<%
    }
%>
</body>
</html>
