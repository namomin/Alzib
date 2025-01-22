<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String Id = (String) session.getAttribute("sid");

    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int currentPage = 1; // 기본 페이지는 1
    int recordsPerPage = 10; // 페이지당 게시글 수
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    int totalPosts = 0;
    int totalPages = 0;

    try {
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String countQuery = "SELECT COUNT(*) AS count FROM Post";
        pstmt = con.prepareStatement(countQuery);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalPosts = rs.getInt("count");
        }

        totalPages = (int) Math.ceil((double) totalPosts / recordsPerPage);

        int start = (currentPage - 1) * recordsPerPage;
        String query = "SELECT * FROM Post ORDER BY PostNum DESC LIMIT ?, ?";
        pstmt = con.prepareStatement(query);
        pstmt.setInt(1, start);
        pstmt.setInt(2, recordsPerPage);
        rs = pstmt.executeQuery();
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>공고목록</title>
    <link href="post_list.css" rel="stylesheet" type="text/css">
    <style>
        .nav {
            margin-left: 15%;
            width: 20%;
            border-radius: 10px;
            border: 1px solid #689ADE;
            padding: 15px;
            color: #689ADE;
        }

        a {
            color: #689ADE;
            text-decoration: none;
        }

        a:hover {
            color: #CADCF4;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="nav">
        <span><a href="main.jsp">홈</a> > <a href="post_list.jsp">알바 검색</a></span>
    </div>
    <div class="postlist">

    <div class="border_wrap">
    <div class="menubutton">
        <table id="list_header">
            <tr>
                <td id="list" align="left">최신 공고</td>
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

<%
                    while (rs.next()) {
                        String PostNum = rs.getString("PostNum");
                        String BStore = rs.getString("BStore");
                        String Title = rs.getString("Title");
                        String Day = rs.getString("Day");
                        String Time = rs.getString("Time");
                        String Pay = rs.getString("Pay");
%>

            <tr>
                <td align="left">
                <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=BStore%></a>
                </td>
                <td align="left">
                    <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Title%></a>
                </td>
                <td align="left">
                    <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Day%> / <%=Time%></a>
                </td>
                <td align="right">
                    <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Pay%></a>
                </td>
            </tr>

<%
    }
%>
        </table>
    </div>  

    <div class="page">
    <%
        // 이전 페이지 (currentPage가 1일 경우 '<' 기호를 보이지 않음)
        if (currentPage > 1) {
            int prevPage = currentPage - 1;
            out.println("<a href='?currentPage=" + prevPage + "'> < </a>" + "&nbsp;");
        }

        // 페이지 번호 표시
        for (int i = 1; i <= totalPages; i++) {
            if (i == currentPage) {
                out.println("<span class='active'>" + i + "</span>");
            } else {
                out.println("<a href='?currentPage=" + i + "'>" + i + "</a>");
            }
            out.println("&nbsp;");
        }

        // 다음 페이지 (currentPage가 totalPages일 경우 '>' 기호를 보이지 않음)
        if (currentPage < totalPages) {
            int nextPage = currentPage + 1;
            out.println("<a href='?currentPage=" + nextPage + "'> > </a>");
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
%>
