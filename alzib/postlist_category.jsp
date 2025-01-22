<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String category = request.getParameter("category"); // 전달받은 카테고리 값 가져오기

    String Id = (String) session.getAttribute("sid");

    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int currentPage = 1;
    int recordsPerPage = 10;
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    int totalPosts = 0;
    int totalPages = 0;

    try {
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String countQuery = "SELECT COUNT(*) AS count FROM Post WHERE Category = ?";
        pstmt = con.prepareStatement(countQuery);
        pstmt.setString(1, category); // 카테고리 값 설정
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalPosts = rs.getInt("count");
        }

        totalPages = (int) Math.ceil((double) totalPosts / recordsPerPage);

        int start = (currentPage - 1) * recordsPerPage;
        String query = "SELECT * FROM Post WHERE Category = ? ORDER BY PostNum DESC LIMIT ?, ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, category); // 카테고리 값 설정
        pstmt.setInt(2, start);
        pstmt.setInt(3, recordsPerPage);
        rs = pstmt.executeQuery();
%>

<html>
<head>
    <meta charset="UTF-8">
    <title><%= category %> 공고목록</title>
    <link href="post_list.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="wrap">
    <div class="postlist">

	<div class="border_wrap">
	<div class="menubutton">
		<table id="list_header">
			<tr>
				<td id="list" align="left"><%= category %> 공고목록</td>
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
%>
		</table>
	</div>	

	<div class="page">
	<%
                    int prevPage = currentPage > 1 ? currentPage - 1 : 1;
                    out.println("<a href='?category=" + category + "&currentPage=" + prevPage + "'> < </a>");

                    for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) {
                            out.println("<span class='active'>" + i + "</span>");
                        } else {
                            out.println("<a href='?category=" + category + "&currentPage=" + i + "'>" + i + "</a>");
                        }
                    }

                    int nextPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                    out.println("<a href='?category=" + category + "&currentPage=" + nextPage + "'> > </a>");
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
