<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
</head>
<body>
<div class="popular_head">
    <span>오늘의 인기글 top3</span>
</div>
<div class="popular_body">
    <div class="popular">
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // MySQL 연결
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alzib", "multi", "abcd");
        
        // 당일날 올라온 게시글 중에서 조회수, 댓글 갯수가 가장 많은 게시글 찾기
        String sql = "SELECT sns.SId, sns.Title, sns.Content, sns.Sdate, sns.Viewcount, " +
                     "COUNT(comment.CId) AS CommentCount, COUNT(scrap.SCId) AS ScrapCount " +
                     "FROM sns " +
                     "LEFT JOIN comment ON sns.SId = comment.SId " +
                     "LEFT JOIN scrap ON sns.SId = scrap.SId " +
                     "WHERE DATE(sns.Sdate) = CURDATE() " +
                     "GROUP BY sns.SId " +
                     "ORDER BY Viewcount DESC, CommentCount DESC " +
                     "LIMIT 3";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            int SId = rs.getInt("SId");
            String Title = rs.getString("Title");
            String Content = rs.getString("Content");
            String Sdate = rs.getString("Sdate");
            int Viewcount = rs.getInt("Viewcount");
            int CommentCount = rs.getInt("CommentCount");
            int ScrapCount = rs.getInt("ScrapCount");

            // 인기글 출력
%>
            <a href="#">
                <table>
                    <tr>
                        <td><font color="gray" size="2">카테고리</font></td>
                    </tr>
                    <tr>
                        <td><h3><%= Title %></h3></td>
                    </tr>
                    <tr>
                        <td class="content"><%= Content %></td>
                    </tr>
                    <tr>
                        <td><font color="gray" size="2"><%= Sdate %> 조회수 <%= Viewcount %> 댓글 <%= CommentCount %> 스크랩 <%= ScrapCount %></font></td>
                    </tr>
                </table>
            </a>
<%
        }
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    } finally {
        // 연결 및 리소스 닫기
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
    </div>
</div>
</body>
</html>
