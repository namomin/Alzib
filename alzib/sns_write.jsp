<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>sns �Խñ� �ۼ�</title>
<link href="sns_write.css" rel="stylesheet" type="text/css">
	
<script>
	//������ ���� �� ǥ��.
    function displayFileName() {
      const input = document.getElementById('fileinput');
      const fileNameSpan = document.getElementById('filename');

      if (input.files.length > 0) {
        fileNameSpan.innerText = input.files[0].name;
      } else {
        fileNameSpan.innerText = '������ �����ϼ���';
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
			<thead><tr><td width="617"><h2>�Խñ� �ۼ�</h2>
			<input type="hidden" name="SWId" value="<%=myid%>">
			</td></tr></thead>
			 <tr>
				<td>
					<select name="Category" required>
						<option selected value="free">�Խ����� �����ϼ���</option>
						<option value="free">�����Խ���</option>
						<option value="information">�˹ٲ����Խ���</option>
						<option value="complain">�ϼҿ��Խ���</option>
						<option value="q">�����Խ���</option>
						<option value="after">�ı�Խ���</option>
					</select> 
				</td>
			 </tr>
			<tr>
				<td><input type="text" name="Title" placeholder="������ �Է��ϼ���" required></td>
			</tr>
			
			<tr>
				<td height="300"><textarea name="Content" placeholder="������ �Է��ϼ���" cols="10px" rows="15px" required></textarea></td>
			</tr>
			
			<tfoot><tr>
				<td align="left">
					<label for="fileinput" id="custom_fileinput"> <!--input �±׿� �����Ͽ� ��ưŸ�� ����-->
					<input type="file" id="fileinput" name="fileinput" onchange="displayFileName()">
					</label>
					<span id="filename"></span> <!--������ ���� ��-->
				</td>
			</tr></tfoot>
			
		</table>
		</div>
	<div class="bottom">
	  <center><input type="submit" value="���"> &nbsp;&nbsp; <a href="snsmain.jsp"><input type="button" value="���ư���"></a></center>
	</div>
</div>
</form>
</body>
</html>
