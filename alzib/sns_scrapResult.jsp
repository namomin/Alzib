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

        // 동일 아이디(userId)로 동일 게시글(SId)을 스크랩한적 있는지 확인
        String checkSql = "SELECT COUNT(*) AS count FROM scrap WHERE SId = ? AND userId = ?";
        PreparedStatement checkStmt = con.prepareStatement(checkSql);
        checkStmt.setString(1, SId);
        checkStmt.setString(2, userId);
        ResultSet checkResult = checkStmt.executeQuery();
        checkResult.next();
        int count = checkResult.getInt("count");

        if (count > 0) {
            // 동일한 SId 값과 userId가 이미 존재하면 스크랩 불가능한 오류 메시지 표시
            out.println("이미 스크랩한 게시글입니다.");
        } else {
            // 동일한 SId 값과 userId가 존재하지 않으면 스크랩 수행
            String insertSql = "INSERT INTO scrap (SId, userId) VALUES (?, ?)";
            PreparedStatement pstmt = con.prepareStatement(insertSql);
            pstmt.setString(1, SId);
            pstmt.setString(2, userId);
            pstmt.executeUpdate();
            out.println("게시글이 스크랩되었습니다.");
        }

        con.close();

        // 스크랩된 게시글의 상세보기 페이지로 이동
        String redirectUrl = "sns_detailview.jsp?SId=" + SId;
        response.sendRedirect(redirectUrl);
    } catch (Exception e) {
        out.println(e);
    }
%>
