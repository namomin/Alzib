<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>�˹� ��õ ���</title>
<link href="recommend_result.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="wrap">
	<div class="head_wrap">
		<div class="head_title">
			<span id="title">�˹� ��õ ���</span><br><br>
			<span id="result"><font color="white">��õ�ϴ� �������� <b>�ܽ�/����</b></font></span><br>
			<span>�˻� ����� �������� ��ſ��� �� �´� �˹ٸ� �����Ծ��!</span>
		</div>
	</div>	
	
	<div class="post_wrap">
		<div class="table_wrap">
			<table>
				<tr>
					<th>�����</th>
					<th>����</th>
					<th>�ٹ��ð�</th>
					<th>�޿�</th>
				</tr>
				
				
				<tr>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>">�ƿ��� õ����</a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>">�ָ� �˹� ���մϴ�</a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>">9��~18��</a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>">[�ñ�]13,000��</a></td>
				</tr>
				
				
			</table>
		</div>
	</div>
	
</div>
</body>
</html>
