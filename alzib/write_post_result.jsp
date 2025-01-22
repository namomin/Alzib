<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*, java.nio.file.*, java.util.*, java.sql.*, javax.servlet.http.*" %>
<%
// 게시글 작성 결과 처리
String title = request.getParameter("title");
String content = request.getParameter("content");
String imageFileName = request.getParameter("imageFileName");

// DB 연결 정보
String DB_URL = "jdbc:mysql://localhost:3306/alzib";
String DB_ID = "multi";
String DB_PASSWORD = "abcd";

// DB 연결 및 게시글 저장
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
    
    // 게시글 삽입 SQL 문
    String sql = "INSERT INTO sns (SWId, Title, Content, Category, Imagename, Sdate, Viewcount, heart) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, (String) session.getAttribute("sid")); // SWId
    pstmt.setString(2, title); // Title
    pstmt.setString(3, content); // Content
    pstmt.setString(4, "free"); // Category - 예시로 "free"로 설정
    pstmt.setString(5, imageFileName); // Imagename
    pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis())); // Sdate
    pstmt.setInt(7, 0); // Viewcount 초기값 0
    pstmt.setInt(8, 0); // Heart 초기값 0
    
    pstmt.executeUpdate();
    
    // DB 연결 종료
    pstmt.close();
    con.close();
    
    // DB에 저장 완료 후, 세션 변수 삭제
    session.removeAttribute("imageFileName");
    
    // 게시판 메인 페이지로 이동
    response.sendRedirect("sns_main.jsp");
} catch (Exception e) {
    out.println("DB 오류: " + e.getMessage());
}
%>
