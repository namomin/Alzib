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

        // 이력서 정보 업데이트 쿼리 작성
        String query = "UPDATE resume SET RTitle = ?, ... WHERE RId = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, RTitle);
        // 나머지 수정된 정보들을 쿼리에 바인딩

        pstmt.setString(20, RId); // RId는 마지막 파라미터

        // 쿼리 실행
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            out.println("이력서 수정이 완료되었습니다.");
            // 이동할 페이지로 redirect
            response.sendRedirect("수정이 완료된 페이지.jsp");
        } else {
            out.println("이력서 수정에 실패했습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 자원 해제
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
