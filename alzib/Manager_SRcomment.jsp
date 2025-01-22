<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>댓글 검색 결과</title>
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
      window.location.href = "Manager_SRcomment.jsp?keyword=" + encodeURIComponent(keyword);
    }

    function onKeyPress(event) {
      if (event.keyCode === 13) { //엔터검색
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

    String field = request.getParameter("field");
    String keyword = request.getParameter("keyword");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String sql = "SELECT * FROM comment WHERE " + field + " LIKE ? ORDER BY Cdate DESC";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + keyword + "%");

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
        <span>댓글 관리</span>
    </div>
    
    <div class="header_nav">
        <table>
            <tr>
				<td><a href="Manager_sns.jsp"><h3>게시글</h3></a></td>
                <td id="choice"><a href="Manager_comment.jsp"><h3>댓글</h3></a></td>
            </tr>
        </table>

		<form method="get" action="Manager_SRcomment.jsp">

				<select name="field" id="field">
					<option value="CWId">작성자 아이디</option>
					<option value="CId">댓글번호</option>
					<option value="SId">게시글 번호</option>
					<option value="CText">댓글</option>
					<option value="Cdate">작성일</option>
				</select>

				<input type="text" name="keyword" id="keyword" placeholder="아이디 또는 이름을 검색하세요." onkeypress="onKeyPress(event)">
				<input type="submit" value="검색">

			</form>
	</div>
	
	<div style="width: 70%; padding-bottom: 10px;">
        "<font color="#0047A9"><b> <%=keyword%> </b></font>" 검색 결과
    </div>
<div class="table_wrap">
    <table>
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>게시글 번호</th>
				<th>댓글</th>
				<th>작성일</th>
				<th>관리</th>
			</tr>

        <%
        if (rs.next()) {
            rs.beforeFirst();
            while (rs.next()) {
                String CId = rs.getString("CId");
				String CWId = rs.getString("CWId");
				String SId = rs.getString("SId");
				String CText = rs.getString("CText");
				String Cdate = rs.getString("Cdate");
        %>
        <tr>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=CId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=CWId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=SId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=CText%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=Cdate%></a></td>
					<td><a href="Manager_comdelete.jsp?CId=<%=CId%>"><button>삭제</button></a></td>
				</tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6">검색결과가 존재하지 않습니다.</td>
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
