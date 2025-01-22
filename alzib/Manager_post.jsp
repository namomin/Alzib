<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>공고 관리 페이지</title>
<link href="Manager_CSS.css" rel="stylesheet" type="text/css">

<style>
	form{
		margin-top: 3px;
		margin-bottom: 3px;
	}
	
	select{
		font-family: 'GmarketSansMedium', sans-serif;
		border: 2px solid #689ADE;
		border-radius: 2px;
		padding: 9px;
	}

	form input[type="submit"] {
		background-color: transparent;
		background-image: url("images/search_icon.png");
		background-repeat: no-repeat;
		width: 40px;
		height: 40px;
		border: none;
		cursor: pointer;
		text-indent: -9999px;
		vertical-align: middle;
		margin-left: 3px;
		margin-top: 10px;
	}
</style>

<script>
    function search() {
        var keyword = document.getElementById("searchbar").value;
        window.location.href = "Manager_SRpost.jsp?keyword=" + encodeURIComponent(keyword);
    }

    function onKeyPress(event) {
        if (event.keyCode === 13) { // 엔터검색
            search();
        }
    }
</script>
</head>
<body>
<%
		String myid = (String) session.getAttribute("sid");

		if (myid == null) {
			response.sendRedirect("Manager_Login.html");
		}

        String DB_URL = "jdbc:mysql://localhost:3306/alzib";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

            String sql = "SELECT * FROM post ORDER BY PostNum DESC";
            pstmt = conn.prepareStatement(sql);

            rs = pstmt.executeQuery();
%>
<div class="wrap">
	<header>
		<a href="Manager_Main.jsp" id="logo"><img src="images/logo.png" alt="로고"></a>
		<span>
			<font color="#0047A9"><b><%=myid%></b></font> 관리자님 &nbsp; <a href="logout.jsp" id="logout">로그아웃</a>
		</span>
	</header>

	<nav>
		<table>
			<tr>
				<td><a href="Manager_Bmember.jsp">회원관리</a></td>
				<td><a href="Manager_sns.jsp">커뮤니티</a></td>
				<td><a href="Manager_post.jsp">구인/구직</a></td>
			</tr>
		</table>
	</nav>
	
	<div class="header_title">
		<span>공고 관리</span>
	</div>

	<div class="header_nav">
		<table>
			<tr>
				<td id="choice"><a href="Manager_post.jsp"><h3>공고</h3></a></td>
                <td><a href="Manager_resume.jsp"><h3>이력서</h3></a></td>
            </tr>
        </table>

			<form method="get" action="Manager_SRpost.jsp">

				<select name="field" id="field">
					<option value="BId">작성자</option>
					<option value="PostNum">공고 번호</option>
					<option value="Title">제목</option>
				</select>

				<input type="text" name="keyword" id="keyword" placeholder="댓글 정보를 검색하세요." onkeypress="onKeyPress(event)">
				<input type="submit" value="검색">

			</form>
	</div>

	<div class="table_wrap">
		<table>
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>관리</th>
				</tr>
				
<%
	while (rs.next()) {
		String PostNum = rs.getString("PostNum");
		String BId = rs.getString("BId");
		String Title = rs.getString("Title");
%>				
				<tr>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=PostNum%></a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=BId%></a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Title%></a></td>
					<td><a href="Manager_postdelete.jsp?PostNum=<%=PostNum%>"><button>삭제</button></a></td>
				</tr>
<%
	}
%>	
		</table>
	</div>
</div>
<%
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
 %>
</body>
</html>
