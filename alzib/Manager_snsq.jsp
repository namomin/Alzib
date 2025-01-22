<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>게시글 관리 페이지</title>
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

	.category{
		background-color: skyblue;
		width: 70%;
		
	}

	.category table{
		text-align: left;
		float: left;
	}

	.category td{
		padding: 10px;
		font-size: 18px;
	}

	.category td a{
		text-decoration: none;
		color: #0047A9;
		transition: color 0.3s, font-size 0.3s;
		transition: letter-spacing 0.3s ease;
	}

	.category td a:hover{
		cursor: pointer;
		padding: 10px;
		border: none;
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		background-color: #689ADE;
		color: white;
		outline: none;
		letter-spacing: 3px;
	}

	#present_category{
		padding: 10px;
		border: none;
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		background-color: #689ADE;
		color: white;
		outline: none;
	}
</style>

<script>
    function search() {
        var keyword = document.getElementById("searchbar").value;
        window.location.href = "Manager_SRsns.jsp?keyword=" + encodeURIComponent(keyword) + "&Category=" + encodeURIComponent(Category);
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

		   String Category = request.getParameter("Category");
           String sql = "SELECT * FROM sns WHERE Category = ? ORDER BY Sdate DESC";
            pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Category);

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
		<span>게시글 관리</span>
	</div>

	<div class="header_nav">
		<table>
			<tr>
				<td id="choice"><a href="Manager_sns.jsp"><h3>게시글</h3></a></td>
                <td><a href="Manager_comment.jsp"><h3>댓글</h3></a></td>
            </tr>
        </table>

			<form method="get" action="Manager_SRsns.jsp">

				<input type="hidden" name="Category" value="<%= Category %>">

				<select name="field" id="field">
					<option value="SWId">작성자 아이디</option>
					<option value="SId">게시글 번호</option>
					<option value="Title">제목</option>
					<option value="Sdate">작성일</option>
				</select>

				<input type="text" name="keyword" id="keyword" placeholder="댓글 정보를 검색하세요." onkeypress="onKeyPress(event)">
				<input type="submit" value="검색">

			</form>
	</div>

	<div class="category">
		<table>
			<tr>
				<td><a href="Manager_sns.jsp">모든글</a></td>
				<td><a href="Manager_snsinformation.jsp?Category=information">알바꿀팁</a></td>
				<td><a href="Manager_snsfree.jsp?Category=free">자유</a></td>
				<td><a href="Manager_snscomplain.jsp?Category=complain">하소연</a></td>
				<td id="present_category"><a href="Manager_snsq.jsp?Category=q"><font color="white">질문</font></a></td>
				<td><a href="Manager_snsafter.jsp?Category=after">후기</a></td>
			</tr>
		</table>
	</div>

	<div class="table_wrap">
		<table>
			<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>작성일</th>
					<th>관리</th>
				</tr>
<%
	while (rs.next()) {
		String SId = rs.getString("SId");
		String SWId = rs.getString("SWId");
		String Title = rs.getString("Title");
		String Sdate = rs.getString("Sdate");

		String Category_name;

        if (Category.equals("free"))
            Category_name = "자유게시판";
        else if (Category.equals("information"))
            Category_name = "알바꿀팁게시판";
        else if (Category.equals("complain"))
            Category_name = "하소연게시판";
        else if (Category.equals("q"))
            Category_name = "질문게시판";
        else 
            Category_name = "후기게시판";
%>	
			<tr>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=SId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=SWId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=Category_name%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=Title%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=Sdate%></a></td>
					<td><a href="Manager_snsdelete.jsp?SId=<%=SId%>"><button>삭제</button></a></td>
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
