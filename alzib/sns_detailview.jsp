<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>sns 게시글 상세보기</title>
<link href="sns_detailview.css" rel="stylesheet" type="text/css">
<style>
		.nav{
			text-align: left;
			margin-left: 0px;
			width: 20%;
			height: auto;
			border-radius: 10px;
			border: 1px solid #689ADE;
			padding: 15px;
			color: #689ADE;
			margin-bottom: 15px;
			margin-top: 0px;
		}

		.nav a{
			color: #689ADE;
			text-decoration: none;
		}

		.nav a:hover{
			color:#CADCF4;
		}
</style>
</head>
<body>
<div class="wrap">

	<div class="main">
	<%
	String myid = (String) session.getAttribute("sid");
	if (session.getAttribute("sid") == null) {
        response.sendRedirect("login.jsp");
    }
	try {
		String DB_URL="jdbc:mysql://localhost:3306/alzib";
		String DB_ID="multi";
		String DB_PASSWORD="abcd";
		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
		String SId = request.getParameter("SId");
		String jsql = "select * from sns where SId = ?";
		PreparedStatement pstmt = con.prepareStatement(jsql);
		pstmt.setString(1, SId);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			String Title = rs.getString("Title");
			String Content = rs.getString("Content");
			String Category = rs.getString("Category");
			String Sdate = rs.getString("Sdate");
			int Viewcount = rs.getInt("Viewcount");
			int heart = rs.getInt("heart");

			Viewcount++; // 조회수 증가
			heart++; // 좋아요수 증가(페이지 조회시 조회수처럼 증가)

			String updateSql = "UPDATE sns SET Viewcount = ?, heart = ? WHERE SId = ?";
			PreparedStatement updateStmt = con.prepareStatement(updateSql);
			updateStmt.setInt(1, Viewcount);
			updateStmt.setInt(2, heart);
			updateStmt.setString(3, SId);
			updateStmt.executeUpdate();

			// 카테고리 이름 설정
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
<div class="nav">
		<span><a href="main.jsp">홈</a> > <a href="snsmain.jsp">커뮤니티</a></span>
</div>
		<div class="back_button">
		<a href="snsmain.jsp"><input type="button" value="<" id="back"></a>
		</div>
		<div class="board_wrap">
			<div class="head_wrap">
				<table>
					<tr>
						<td><a href="sns_categoryview.jsp?Category=<%=Category%>"><font color="#0047A9"><%=Category_name%></font></a></td>
					</tr>
					<tr>
						<td><h2><%=Title%></h2></td>
					</tr>
					<tr>
						<td><font color="gray" size="2"><%=Sdate%> &nbsp 조회수&nbsp<%=Viewcount%></font></td>
					</tr>
				</table>
			</div>

			<div class="content_wrap">
				<table>
					<tr>
						<td><%=Content%></td>
					</tr>
					<tr>
						<td id="like">
    <form name="Scrap" action="sns_scrapResult.jsp" method="post">
        <input type="hidden" name="SId" value="<%=SId%>">
        <input type="submit" value="스크랩" id="scrap_button">
        <%-- Scrap 테이블에서 해당 SId 값을 가진 레코드의 수를 출력 --%>
        <%
    try {
        String checkSql = "SELECT COUNT(*) AS count FROM scrap WHERE SId = ?";
        PreparedStatement checkStmt = con.prepareStatement(checkSql);
        checkStmt.setString(1, SId);
        ResultSet checkResult = checkStmt.executeQuery();
        checkResult.next();
        int count = checkResult.getInt("count");

        // Scrap 테이블에서 해당 SId 값을 가진 레코드의 수를 출력
        out.println("<span style=\"font-size: 13px;\">" + count + "</span>");


        con.close();
    } catch (Exception e) {
        out.println(e);
    }
%>
    </form>
</td>

					</tr>
				</table>
			</div>
		</div>

	<div style="display: flex; justify-content: center; align-items: center; height: 100vh;">
	<!-- sns_comment.html 파일 불러오기-->
	<iframe src="sns_comment.jsp?SId=<%=SId%>" frameborder="0" scrolling="auto" width="700" height="900" style="display:block; margin:auto;"></iframe>
	</div>
	<%
		}
	} catch(Exception e) {
		out.println(e);
	}
	%>
	</div>

	
</div>
</body>
</html>
