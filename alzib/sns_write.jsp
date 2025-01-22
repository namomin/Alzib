<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>sns 게시글 작성</title>
<link href="sns_write.css" rel="stylesheet" type="text/css">
	
<script>
	//선택한 파일 명 표시.
    function displayFileName() {
      const input = document.getElementById('fileinput');
      const fileNameSpan = document.getElementById('filename');

      if (input.files.length > 0) {
        fileNameSpan.innerText = input.files[0].name;
      } else {
        fileNameSpan.innerText = '파일을 선택하세요';
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

<form method="post" action="sns_writeResult.jsp" name="write">
	
<div class="board_wrap">
	<div class="background">
	<table width="625">
			<thead><tr><td width="617"><h2>게시글 작성</h2>
			<input type="hidden" name="SWId" value="<%=myid%>">
			</td></tr></thead>
			 <tr>
				<td>
					<select name="Category" required>
						<option selected value="free">게시판을 선택하세요</option>
						<option value="free">자유게시판</option>
						<option value="information">알바꿀팁게시판</option>
						<option value="complain">하소연게시판</option>
						<option value="q">질문게시판</option>
						<option value="after">후기게시판</option>
					</select> 
				</td>
			 </tr>
			<tr>
				<td><input type="text" name="Title" placeholder="제목을 입력하세요" required></td>
			</tr>
			
			<tr>
				<td height="300"><textarea name="Content" placeholder="내용을 입력하세요" cols="10px" rows="15px" required></textarea></td>
			</tr>
			
			<tfoot><tr>
				<td align="left">
					<label for="fileinput" id="custom_fileinput"> <!--input 태그와 연동하여 버튼타입 수정-->
					<input type="file" id="fileinput" name="fileinput" onchange="displayFileName()">
					</label>
					<span id="filename"></span> <!--선택한 파일 명-->
				</td>
			</tr></tfoot>
			
		</table>
		</div>
	<div class="bottom">
	  <center><input type="submit" value="등록"> &nbsp;&nbsp; <a href="snsmain.jsp"><input type="button" value="돌아가기"></a></center>
	</div>
</div>
</form>
</body>
</html>
