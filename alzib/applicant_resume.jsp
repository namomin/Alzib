<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>�̷¼� ����</title>
<link href="resume.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
   try {
		String DB_URL="jdbc:mysql://localhost:3306/alzib";
		String DB_ID="multi";
		String DB_PASSWORD="abcd";
		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
		String RId = request.getParameter("RId");
		String jsql = "select * from resume where RId = ?";
		PreparedStatement pstmt = con.prepareStatement(jsql);
		pstmt.setString(1, RId);
		ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
			String AId = rs.getString("AId");
			String AName = rs.getString("AName");
			String ABirth = rs.getString("ABirth");
			String APhone = rs.getString("APhone");
			String AEmail = rs.getString("AEmail");
			String RTitle = rs.getString("RTitle");
			String RAbility = rs.getString("RAbility");
			String RHigh = rs.getString("RHigh");
			String RCollege = rs.getString("RCollege");
			String RCareer = rs.getString("RCareer");
			String HArea = rs.getString("HArea");
			String HType = rs.getString("HType");
			String HForm = rs.getString("HForm");
			String HPeriod = rs.getString("HPeriod");
			String HDay = rs.getString("HDay");
			String HTime = rs.getString("HTime");
			String HSalary = rs.getString("HSalary");
			String RIntroduce = rs.getString("RIntroduce");
			String REtc = rs.getString("REtc");
%>
<div class="wrap">
	<div class="border_wrap">
		
		<div class="header">
			<hr><h1>�⺻����</h1><hr>
		</div>
		
		<div class="content">
			<table id="inform"> 
			<tr>
				<td>
				<input type="hidden" name="AName" value="<%=AName%>"><font color="#689ADE">�̸�</font>&nbsp; <%=AName%>&nbsp;&nbsp;
				</td>
				<td>
				<input type="hidden" name="ABirth" value="<%=ABirth%>"><font color="#689ADE">�������</font>&nbsp; <%=ABirth%>&nbsp;&nbsp;
				</td>
				<td>
				<input type="hidden" name="APhone" value="<%=APhone%>"><font color="#689ADE">��ȭ��ȣ</font>&nbsp; <%=APhone%>&nbsp;&nbsp;
				</td>
				<td>
				<input type="hidden" name="AEmail" value="<%=AEmail%>"><font color="#689ADE">�̸���</font>&nbsp; <%=AEmail%>
				</td>
			</tr>
		</table>
		
			
		<div class="sub_title">
			<h3>�̷¼� ����</h3>
		</div>
		<div class="sub_content">
		<input type="hidden" name="RTitle" value="<%=RTitle%>"><%=RTitle%>
		</div>
			
		<div class="sub_title">
			<h3>�з� ����</h3>
		</div>
		<div class="sub_content">
			<p><input type="hidden" name="RAbility" value="<%=RAbility%>">�з�: <%=RAbility%></p>
		<p><input type="hidden" name="RHigh" value="<%=RHigh%>">�б���: <%=RHigh%> <input type="hidden" name="RCollege" value="<%=RCollege%>">����: <%=RCollege%></p>
		</div>

			
		<div class="sub_title">
			<h3>��»���</h3>
		</div>
		<div class="sub_content">
			<p><input type="hidden" name="RCareer" value="<%=RCareer%>">���: <%=RCareer%></p>
		</div>
			
		<div class="header">
			<hr><h1>��� �ٹ� ����</h1><hr>
		</div>
		<div class="content">
			<div class="sub_title">
				<h3>�ٹ� ����</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HArea" value="<%=HArea%>"><%=HArea%>
			</div>
			
			<div class="sub_title">
				<h3>������</h3>
			</div>
			<div class="sub_content">
					<input type="hidden" name="HType" value="<%=HType%>"><%=HType%>
			</div>
			<div class="sub_title">
				<h3>�ٹ� ����</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HForm" value="<%=HForm%>"><%=HForm%>
			</div>
			
			<div class="sub_title">
				<h3>�ٹ� �Ⱓ</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HPeriod" value="<%=HPeriod%>"><%=HPeriod%>
			</div>
			
			<div class="sub_title">
				<h3>�ٹ� ����</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HDay" value="<%=HDay%>"><%=HDay%>
			</div>
			
			<div class="sub_title">
				<h3>�ٹ� �ð�</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HTime" value="<%=HTime%>"><%=HTime%>
			</div>
			
			<div class="sub_title">
				<h3>��� �޿�</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HSalary" value="<%=HSalary%>"><%=HSalary%>
			</div>
		</div>
		
		<div class="header">
			<hr><h1>�Ұ�</h1><hr>
		</div>
		<div class="content">
			<div class="sub_title">
				<h3>�ڱ�Ұ�</h3>
			</div>	
			<div class="sub_content">
				<input type="hidden" name="RIntroduce" value="<%=RIntroduce%>"><%=RIntroduce%>
			</div>
			
			<div class="sub_title">
				<h3>��Ÿ����</h3>
			</div>	
			<div class="sub_content">
				<input type="hidden" name="REtc" value="<%=REtc%>"><%=REtc%>
			</div>
		</div>
			
		</div>
		
	</div>
</div>

</body>
</html>
<%
	}
	} catch (Exception e) {
		out.println(e);
	}
%>
