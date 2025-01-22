<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<%
    String myid = (String) session.getAttribute("sid");
    if (myid == null) {
        response.sendRedirect("login.jsp");
    } else {
        String PostNum = request.getParameter("PostNum");
        String Id = (String) session.getAttribute("sid");

        String DB_URL = "jdbc:mysql://localhost:3306/alzib";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
            String query = "SELECT * FROM Post WHERE PostNum = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, PostNum);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String BId = rs.getString("BId");
                String bossQuery = "SELECT * FROM boss WHERE BId = ?";
                PreparedStatement bossStmt = con.prepareStatement(bossQuery);
                bossStmt.setString(1, Id);
                ResultSet bossRs = bossStmt.executeQuery();

                if (bossRs.next()) {
%>
	<% response.sendRedirect("message.jsp?PostNum=" + PostNum);%>

<%
                } else {
%>
	<% response.sendRedirect("apply_resumechoice.jsp?PostNum=" + PostNum + "&BId=" + BId); %>	
<%
                }
            } else {
                out.println("게시글을 찾을 수 없습니다.");
            }

        } catch (SQLException e) {
            out.println("데이터베이스 오류 발생: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
