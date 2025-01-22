<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
    request.setCharacterEncoding("utf-8");
    // PostNum 설정 
    String Id = (String) session.getAttribute("sid");
	String category = request.getParameter("Category");
	String type = request.getParameter("Type");
	String sex = request.getParameter("Sex");
    String age = request.getParameter("Age");
	String period = request.getParameter("Period");
	String day = "";
    String time = request.getParameter("Time1") + "~" + request.getParameter("Time2");
	String Selector = request.getParameter("Selector");
        if (Selector.equals("요일 지정")) {
            for (int i = 1; i <= 7; i++) {
                String dayCheckbox = request.getParameter("day" + i);
                if (dayCheckbox != null) {
                    day += dayCheckbox + ",";
                }
            }
            if (!day.isEmpty()) {
                day = day.substring(0, day.length() - 1); // 마지막 점 제거
            }
        } else if (Selector.equals("요일 협의")) {
            day = "요일 협의";
        }
    
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

        // SQL 쿼리 작성: 총 게시글 수 조회
        String countQuery = "SELECT COUNT(*) AS count FROM Post";
        pstmt = con.prepareStatement(countQuery);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalPosts = rs.getInt("count");
        }

        // 총 페이지 수 계산
        totalPages = (int) Math.ceil((double) totalPosts / recordsPerPage);

        // SQL 쿼리 작성: 현재 페이지에 표시될 게시글 목록 조회
        int start = (currentPage - 1) * recordsPerPage;
		String query = "SELECT * FROM post WHERE Category=? AND Time=? AND Day=? AND Period=? AND Sex=? AND Age=? AND Type=? ORDER BY PostNum DESC LIMIT ?, ?";
		pstmt = con.prepareStatement(query);
		pstmt.setString(1, category);
		pstmt.setString(2, time);
		pstmt.setString(3, day);
		pstmt.setString(4, period);
		pstmt.setString(5, sex);
		pstmt.setString(6, age);
		pstmt.setString(7, type);
		pstmt.setInt(8, start);
		pstmt.setInt(9, recordsPerPage);
		rs = pstmt.executeQuery();

%>

<html>
<head>
    <meta charset="UTF-8">
    <title>공고 목록</title>
    <link href="post_list.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="wrap">
   <div class="postlist">

	<div class="border_wrap">
	<div class="menubutton">
		<table id="list_header">
			<tr>
				<td id="list" align="left">필터 결과</td>
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
<!--
	<div class="page">
	<%
                    // 이전 페이지
                    int prevPage = currentPage > 1 ? currentPage - 1 : 1;
                    out.println("<a href='?currentPage=" + prevPage + "'> < </a>");

                    // 페이지 번호 표시
                    for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) {
                            out.println("<span class='active'>" + i + "</span>");
                        } else {
                            out.println("<a href='?currentPage=" + i + "'>" + i + "</a>");
                        }
                    }

                    // 다음 페이지
                    int nextPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                    out.println("<a href='?currentPage=" + nextPage + "'> > </a>");
                %>

	</div>
	-->
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
