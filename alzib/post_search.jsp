<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    // PostNum 설정 
    String Id = (String) session.getAttribute("sid");
    String keyword = request.getParameter("keyword");
    
    // 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    // 데이터베이스 연결 변수
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 페이지네이션을 위한 변수
    int currentPage = 1; // 기본 페이지는 1
    int recordsPerPage = 10; // 페이지당 게시글 수
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    // 총 게시글 수
    int totalPosts = 0;
    int totalPages = 0;

    try {
        // 데이터베이스 연결
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL 쿼리 작성: 검색어에 따른 게시글 목록 조회
        String countQuery = "SELECT COUNT(*) AS count FROM Post WHERE BStore LIKE ? OR Title LIKE ?";
        pstmt = con.prepareStatement(countQuery);
        pstmt.setString(1, "%" + keyword + "%");
        pstmt.setString(2, "%" + keyword + "%");
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalPosts = rs.getInt("count");
        }

        // 총 페이지 수 계산
        totalPages = (int) Math.ceil((double) totalPosts / recordsPerPage);

        // SQL 쿼리 작성: 현재 페이지에 표시될 게시글 목록 조회
        int start = (currentPage - 1) * recordsPerPage;
        String query = "SELECT * FROM Post WHERE BStore LIKE ? OR Title LIKE ? ORDER BY PostNum DESC LIMIT ?, ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, "%" + keyword + "%");
        pstmt.setString(2, "%" + keyword + "%");
        pstmt.setInt(3, start);
        pstmt.setInt(4, recordsPerPage);
        rs = pstmt.executeQuery();
%>

<html>
<head>
    <title>검색 결과</title>
    <link href="post_list.css" rel="stylesheet" type="text/css">
    <meta charset="utf-8">
</head>
<body>
<div class="wrap">
    <div class="postlist">

    <div class="border_wrap">
    <div class="menubutton">
        <table id="list_header">
            <tr>
                <td id="list" align="left"> <font color="#689ADE">'<%=keyword%>'</font> 검색 결과</td>
                <td id="button" align="right"><a href="fillterSearch.jsp"><img src="images/menu.png" alt="필터검색"></a></td>
            </tr>
        </table>
    </div>
        <table>
            <tr>
                <th>기업/점포명</th>
                <th>공고제목</th>
                <th>근무시간</th>
                <th>급여</th>
            </tr>
            <% if (totalPosts == 0) { %>
                <tr>
                    <td colspan="4">찾으시는 결과물이 없습니다.</td>
                </tr>
<% } else { %>
<%
                    while (rs.next()) {
                        String PostNum = rs.getString("PostNum");
                        String BStore =rs.getString("BStore");
                        String Title = rs.getString("Title");
                        String Day = rs.getString("Day");
                        String Time = rs.getString("Time");
                        String Pay = rs.getString("Pay");
%>
        
            <tr>
                <td>
                <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=BStore%></a>
                </td>
                <td>
                    <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Title%></a>
                </td>
                <td>
                    <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Day%> / <%=Time%></a>
                </td>
                <td>
                    <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Pay%></a>
                </td>
            </tr>
        
<%
    }
}
%>
        </table>
    </div>  
    
    <div class="page">
    <%
        // 이전 페이지
        if (currentPage > 1) {
            int prevPage = currentPage - 1;
            out.println("<a href='?keyword=" + keyword + "&currentPage=" + prevPage + "'> < </a>");
        }

        // 페이지 번호 표시
        for (int i = 1; i <= totalPages; i++) {
            if (i == currentPage) {
                out.println("<span class='active'>" + i + "</span>");
            } else {
                out.println("<a href='?keyword=" + keyword + "&currentPage=" + i + "'>" + i + "</a>");
            }
			out.println("&nbsp;");
        }

        // 다음 페이지
        if (currentPage < totalPages) {
            int nextPage = currentPage + 1;
            out.println("<a href='?keyword=" + keyword + "&currentPage=" + nextPage + "'> > </a>");
        }
    %>

    </div>

</div>

</div>

</div>
</body>
</html>

<%
    } catch (SQLException e) {
        // SQL 오류 처리
        e.printStackTrace();
    } finally {
        // 연결 해제
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
