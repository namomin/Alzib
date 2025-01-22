<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>알바 추천 결과</title>
<link href="recommend_result.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="wrap">
	<div class="head_wrap">
		<div class="head_title">
			<span id="title">알바 추천 결과</span><br><br>
			<span id="result"><font color="white">추천하는 업직종은 <b>외식/음료</b></font></span><br>
			<span>검사 결과를 바탕으로 당신에게 꼭 맞는 알바를 가져왔어요!</span>
		</div>
	</div>	
	
	<div class="post_wrap">
		<div class="table_wrap">
			<table>
				<tr>
					<th>기업명</th>
					<th>제목</th>
					<th>근무시간</th>
					<th>급여</th>
				</tr>
				
				
				<tr>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>">아웃백 천안점</a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>">주말 알바 구합니다</a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>">9시~18시</a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>">[시급]13,000원</a></td>
				</tr>
				
				
			</table>
		</div>
	</div>
	
</div>
</body>
</html>
