<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>이력서 열람</title>
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
			<hr><h1>기본정보</h1><hr>
		</div>
		
		<div class="content">
			<table id="inform"> 
			<tr>
				<td>
				<input type="hidden" name="AName" value="<%=AName%>"><font color="#689ADE">이름</font>&nbsp; <%=AName%>&nbsp;&nbsp;
				</td>
				<td>
				<input type="hidden" name="ABirth" value="<%=ABirth%>"><font color="#689ADE">생년월일</font>&nbsp; <%=ABirth%>&nbsp;&nbsp;
				</td>
				<td>
				<input type="hidden" name="APhone" value="<%=APhone%>"><font color="#689ADE">전화번호</font>&nbsp; <%=APhone%>&nbsp;&nbsp;
				</td>
				<td>
				<input type="hidden" name="AEmail" value="<%=AEmail%>"><font color="#689ADE">이메일</font>&nbsp; <%=AEmail%>
				</td>
			</tr>
		</table>
		
			
		<div class="sub_title">
			<h3>이력서 제목</h3>
		</div>
		<div class="sub_content">
		<input type="hidden" name="RTitle" value="<%=RTitle%>"><%=RTitle%>
		</div>
			
		<div class="sub_title">
			<h3>학력 정보</h3>
		</div>
		<div class="sub_content">
			<p><input type="hidden" name="RAbility" value="<%=RAbility%>">학력: <%=RAbility%></p>
		<p><input type="hidden" name="RHigh" value="<%=RHigh%>">학교명: <%=RHigh%> <input type="hidden" name="RCollege" value="<%=RCollege%>">전공: <%=RCollege%></p>
		</div>

			
		<div class="sub_title">
			<h3>경력사항</h3>
		</div>
		<div class="sub_content">
			<p><input type="hidden" name="RCareer" value="<%=RCareer%>">경력: <%=RCareer%></p>
		</div>
			
		<div class="header">
			<hr><h1>희망 근무 조건</h1><hr>
		</div>
		<div class="content">
			<div class="sub_title">
				<h3>근무 지역</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HArea" value="<%=HArea%>"><%=HArea%>
			</div>
			
			<div class="sub_title">
				<h3>업직종</h3>
			</div>
			<div class="sub_content">
					<input type="hidden" name="HType" value="<%=HType%>"><%=HType%>
			</div>
			<div class="sub_title">
				<h3>근무 형태</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HForm" value="<%=HForm%>"><%=HForm%>
			</div>
			
			<div class="sub_title">
				<h3>근무 기간</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HPeriod" value="<%=HPeriod%>"><%=HPeriod%>
			</div>
			
			<div class="sub_title">
				<h3>근무 요일</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HDay" value="<%=HDay%>"><%=HDay%>
			</div>
			
			<div class="sub_title">
				<h3>근무 시간</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HTime" value="<%=HTime%>"><%=HTime%>
			</div>
			
			<div class="sub_title">
				<h3>희망 급여</h3>
			</div>
			<div class="sub_content">
				<input type="hidden" name="HSalary" value="<%=HSalary%>"><%=HSalary%>
			</div>
		</div>
		
		<div class="header">
			<hr><h1>소개</h1><hr>
		</div>
		<div class="content">
			<div class="sub_title">
				<h3>자기소개</h3>
			</div>	
			<div class="sub_content">
				<input type="hidden" name="RIntroduce" value="<%=RIntroduce%>"><%=RIntroduce%>
			</div>
			
			<div class="sub_title">
				<h3>기타사항</h3>
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
