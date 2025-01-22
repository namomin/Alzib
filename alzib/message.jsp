<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<title>message</title>
<style>
	@font-face {
		font-family: 'GmarketSansMedium';
		src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		font-weight: normal;
		font-style: normal;
	}

	* {
		padding: 0;
		margin: 0 auto;
	}

	a{
		text-decoration: none;
		color: black;
	}


	body{
		font-family: 'GmarketSansMedium', sans-serif;
		margin: 0;
		background-color: #f4f4f4;
	}

	.wrap{
		margin: 0;
	}
	
	.border_wrap{
		background: white;
		padding: 30px;
		border-radius: 10px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		text-align: center;
		width: 500px;
		margin-top: 20%;
	}
	
	span{
		font-size: 18px;
	}
	
	button{
		font-family: 'GmarketSansMedium', sans-serif;
		background-color: #689ADE;
		color: white;
		width: 100px;
		padding: 10px;
		border: none;
		cursor: pointer;
		display: inline-block;
		margin-top: 20px;
		font-weight: bold;	
		font-size: 16px;
		letter-spacing: 2px;
		box-shadow: 3px 3px 3px rgba(33, 86, 158, 0.5);
	}
	
	button:hover{
		background-color: #CADCF4;
	}
</style>
</head>

<body>
<%
	String PostNum = request.getParameter("PostNum");
	String Id = (String) session.getAttribute("sid");
%>
<div class="wrap">
	<div class="border_wrap">
		<span>사장님은 공고글에 지원하실 수 없습니다.</span>
		<br>
		<a href="postmapdetail.jsp?PostNum=<%=PostNum%>">
			<button>돌아가기</button>
		</a>
	</div>	
</div>
</body>
</html>
