<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>알바 회원 검색 결과</title>
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
      window.location.href = "Manager_SRAmem.jsp?keyword=" + encodeURIComponent(keyword);
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

        String sql = "SELECT * FROM alba WHERE " + field + " LIKE ?";
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
        <span>알바 회원 관리 &nbsp;<button><a href="memberinsert_alba.html">추가</a></button></span>
    </div>
    
    <div class="header_nav">
        <table>
            <tr>
                <td><a href="Manager_Bmember.jsp"><h3>사장님</h3></a></td>
                <td id="choice"><a href="Manager_Amember.jsp"><h3>알바생</h3></a></td>
            </tr>
        </table>

		<form method="get" action="Manager_SRAmem.jsp">

				<select name="field" id="field">
					<option value="AId">아이디</option>
					<option value="AName">이름</option>
					<option value="APhone">전화번호</option>
					<option value="AEmail">이메일</option>
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
            <th>아이디</th>
            <th>이름</th>
            <th>전화번호</th>
            <th>이메일</th>
            <th>관리</th>
        </tr>

        <%
        if (rs.next()) {
            rs.beforeFirst();
            while (rs.next()) {
                String AId = rs.getString("AId");
                String AName = rs.getString("AName");
                String APhone = rs.getString("APhone");
                String AEmail = rs.getString("AEmail");
        %>
        <tr>
            <td><%=AId%></td>
            <td><%=AName%></td>
            <td><%=APhone%></td>
            <td><%=AEmail%></td>
            <td><a href="Manager_Amemdelete.jsp?AId=<%=AId%>"><button>삭제</button></a></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5">검색결과가 존재하지 않습니다.</td>
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
