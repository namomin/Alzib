<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>alzib</title>
<link href="index.css" rel="stylesheet" type="text/css">
<style>
		.main{
			height: 1000px;
		}

        #frame{
            width: 100%;
			height: 1000px;
            text-align: center;
			position: absolute;
        }
        iframe{
            width: 100%;
            height: 100%;
            border: none;
        }

		#member{
			text-align: right;
			font-size: 22px;
			margin-right: 20px;
			padding-top: 25px;
		}

</style>

<script>
    function search() {
        var keyword = document.getElementById("search_bar").value;
        window.frames["index"].location.href = "post_search.jsp?keyword=" + encodeURIComponent(keyword);
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
    if (session.getAttribute("sid") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<div class="wrap">
<div class="header_wrap">
<header>
	<div id="logo">
		<a href="index_boss.jsp"><img src="images/logo.png" alt="로고 이미지"></a>
	</div>
	
	<table align="center">
        <th>
			<input type="text" id="search_bar" placeholder="어떤 알바를 찾으세요? (ex. 카페, 편의점, 호프...)" onkeypress="onKeyPress(event)">&nbsp;
			<input type="button" id="search_button" onclick="search()">
		</th>

    </table>

	<div id="login">
		<div id="member">
			<font color="#0047A9"><b><%=myid%></b></font> 사장님 환영합니다!
		</div>

		<p><a href="logout.jsp">로그아웃</a></p>
	</div>

	<nav>
		<ul>
		<li> 
			<a href="recommend.jsp" target="index"><p>알바 추천</p></a>
		</li>
		<li> 
			<a href="post_list.jsp" target="index"><p>알바 검색</p></a>
			<ul>
				<li><a href="displayCoordinates.jsp" target="index">지도검색</a></li>
			</ul>
		</li>
		<li> 
			<a href="snsmain.jsp" target="index"><p>커뮤니티</p></a>
		</li>
		<li> 
			<a href="Calendar_boss.jsp" target="index"><p>편의 기능</p></a>
			<ul>
				<li><a href="Calendar_boss.jsp" target="index">근무자시간표</a></li>
				<li><a href="doc_contract.html" target="index">문서양식</a></li>
			</ul>
		</li>
		<li> 
			<a href="mypageBoss.jsp" target="index"><p>구인 관리</p></a>
		</li>
		</ul>
	</nav>
</header>	
</div>

<div class="main">
	<div id="frame">
		<iframe src="main.jsp" name="index" frameborder="0"  scrolling="auto"></iframe>
	</div>
</div>
	
<footer>
	<section class="footer">
		<p>(주) 알ZIB</p>
		<p>대표 : 웹모꼬지팀</p>
		<p>충청남도 천안시 서북구 성환읍 대학로 91 / 사업자등록번호 : 123-45-67890</p>
		<p>Ⓒ 알ZIB. All rights reserved.</p>  
  </section>
</footer>
	
</div>
</body>
</html>