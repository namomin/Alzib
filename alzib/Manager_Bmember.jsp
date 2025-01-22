<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>사장 회원 검색</title>
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
        window.location.href = "Manager_SRBmem.jsp?keyword=" + encodeURIComponent(keyword);
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

            String sql = "SELECT * FROM boss";
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
		<span>사장 회원 관리 &nbsp;<button><a href="memberinsert_boss.html">추가</a></button></span>
	</div>

	<div class="header_nav">
		<table>
			<tr>
				<td id="choice"><a href="Manager_Bmember.jsp"><h3>사장님</h3></a></td>
                <td><a href="Manager_Amember.jsp"><h3>알바생</h3></a></td>
            </tr>
        </table>

			<form method="get" action="Manager_SRBmem.jsp">

				<select name="field" id="field">
					<option value="BId">아이디</option>
					<option value="BName">이름</option>
					<option value="BPhone">전화번호</option>
					<option value="BEmail">이메일</option>
					<option value="BBusiness">사업자등록번호</option>
				</select>

				<input type="text" name="keyword" id="keyword" placeholder="아이디 또는 이름을 검색하세요." onkeypress="onKeyPress(event)">
				<input type="submit" value="검색">

			</form>
	</div>

	<div class="table_wrap">
		<table>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>사업자등록번호</th>
				<th>관리</th>
			</tr>
			
<%
            while (rs.next()) {
				String BId = rs.getString("BId");
				String BName = rs.getString("BName");
				String BPhone = rs.getString("BPhone");
				String BEmail = rs.getString("BEmail");
				String BBusiness = rs.getString("BBusiness");
%>
			<tr>
				<td><a href="#"><%=BId%></a></td>
				<td><%=BName%></td>
				<td><%=BPhone%></td>
				<td><%=BEmail%></td>
				<td><%=BBusiness%></td>
				<td><a href="Manager_Bmemdelete.jsp?BId=<%=BId%>"><button>삭제</button></a></td>
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
 <script>
    // 회원 클릭시
    var showListLinks = document.querySelectorAll('.show-list');
    var list = document.querySelector('.list');

    showListLinks.forEach(function(link) {
        link.addEventListener('click', function() {
            var rect = this.getBoundingClientRect();
            list.style.top = (window.pageYOffset + rect.bottom) + 'px';
            list.style.left = rect.left + 'px';
            list.style.display = 'block';
        });
    });

    // 닫기 버튼 클릭시
    var closeButtons = document.querySelectorAll('.close-list');
    closeButtons.forEach(function(button) {
        button.addEventListener('click', function() {
            list.style.display = 'none';
        });
    });

    document.querySelectorAll('.list li').forEach(function(item) {
        item.addEventListener('click', function() {
            var link = this.querySelector('a');
            if (link) {
                window.location.href = link.href;
            }
        });
    });
</script>
</body>
</html>
