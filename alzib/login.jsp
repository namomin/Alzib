<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>로그인</title>
	<style>
		@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
        body {
            font-family: 'GmarketSansMedium', sans-serif;
            background: #f1f1f1;
            margin: 0;
            padding: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        form {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }

        input[type="button"] {
			font-family: 'GmarketSansMedium', sans-serif;
            background-color: #689ADE;
			color: white;
			width: 200px;
			padding: 10px;
			border: none;
			cursor: pointer;
			display: inline-block;
			margin-top: 10px;
			font-weight: bold;	
			font-size: 19px;
			box-shadow: 5px 5px 5px rgba(33, 86, 158, 0.5);
        }

        input[type="button"]:hover {
            background-color: #CADCF4;
        }

        p {
            color: #555;
            font-size: 14px;
        }

        a {
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body onLoad="login_focus()">
    <form name="login" method="post" action="LoginOk.jsp">
		<h1><a href="index.html">알ZIB</a></h1>
        <a href="bosslogin.html"><input type="button" value="사장님 로그인"></a>
		<br>
        <a href="partlogin.html"><input type="button" value="알바생 로그인"></a>
		<br>
        <p>아직 회원이 아니신가요? <a href="member.html"><em>회원가입</em></a></p>
    </form>
</body>
</html>
