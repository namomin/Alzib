<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>

<html>
<head>
<meta charset="UTF-8">
<title>mypage_boss</title>
<link href="mypageBoss.css" rel="stylesheet" type="text/css">
<style>
		.nav{
			text-align: left;
			margin-left: 15%;
			width: 20%;
			border-radius: 10px;
			border: 1px solid #689ADE;
			padding: 15px;
			color: #689ADE;
			margin-bottom: 15px;
		}

		.nav a{
			color: #689ADE;
			text-decoration: none;
		}

		.nav a:hover{
			color:#CADCF4;
		}
</style>
</head>
<body>
<%
	try {
		String myid = (String) session.getAttribute("sid");
		if (session.getAttribute("sid") == null) {
			response.sendRedirect("login.jsp");
		}

		DecimalFormat formatter = new DecimalFormat("#,###");

		String DB_URL="jdbc:mysql://localhost:3306/alzib";
		String DB_ID="multi";
		String DB_PASSWORD="abcd";

		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

		// boss 테이블에서 회원 정보 불러오기
		String jsql = "SELECT * FROM boss WHERE BId = ?";
		PreparedStatement pstmt = con.prepareStatement(jsql);
		pstmt.setString(1, myid);
		ResultSet rs = pstmt.executeQuery();
		String BName = "";
		String BPhone = "";
		String BEmail = "";
		if (rs.next()) {
			BName = rs.getString("BName");
			BPhone = rs.getString("BPhone");
			BEmail = rs.getString("BEmail");
		}
%>

<div class="wrap">
<div class="nav">
		<a href="main.jsp">홈</a> > <a href="mypageBoss.jsp">구인관리</a>
</div>
	<div class="member_wrap">
		<table>
			<tr>
				<td rowspan="2" id="profile"><img src="images/egg_icon.png" alt="프로필"></td>
				<td><span><%=myid%></span></td>
			</tr>

			<tr>
				<td><font color="gray"><%=BName%> / <%=BPhone%> / <%=BEmail%></font> <a href="boss_update.jsp?BId=<%=myid%>"><input type="button" value="수정"></a></td>
			</tr>
		</table>
	</div>	
	<div class="bord_wrap">
		
		<div class="resume_wrap">
			<div class="resume_head">
				<span>공고 관리 <a href="postmap.jsp"><input type="button" value="작성"></a></span>
			</div>
			<div class="resume_table">
				<table>
					<tr>
						<th>제목</th>
						<th>지원자</th>
						<th>관리</th>
					</tr>
<%
        // post 테이블에서 공고 정보 불러오기
        jsql = "SELECT * FROM post WHERE BId = ?";
        pstmt = con.prepareStatement(jsql);
        pstmt.setString(1, myid);
        rs = pstmt.executeQuery();
        while(rs.next()){
            String PostNum =  rs.getString("PostNum");
            String Title =  rs.getString("Title");
%>					
					<tr>
						<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Title%></a></td>
						<td><input type="button" value="열람" onclick="openWindow('<%=PostNum%>', '<%=Title%>')"></td>
						<!--<td><a href="apply_resume.jsp?PostNum=<%=PostNum%>&Title=<%=Title%>" target="index"><input type="button" value="열람"></a></td>-->
						<td><a href="post_delete.jsp?PostNum=<%=PostNum%>"><input type="button" value="삭제"></a></td>
					</tr>
<%
        }
%>					
					
				</table>
				
			</div>
		</div>
<br><br>
		<div class="interview_wrap">
			<div class="employe_head">
				<span>면접 예정</span>
			</div>
			<div class="resume_table">
				<table id="interview">
					<tr>
						<th>공고</th>
						<th>이름</th>
						<th>관리</th>
					</tr>
<%
// apply 테이블과 post 테이블을 조인하여 상태가 '면접중'인 항목들을 가져오는 SQL 쿼리
String interviewSQL = "SELECT apply.AId, apply.BId, apply.PostNum, post.Title, post.Bstore, apply.AName, apply.RId, apply.applyId FROM apply JOIN post ON apply.PostNum = post.PostNum WHERE apply.state = '면접예정'";

PreparedStatement interviewStmt = con.prepareStatement(interviewSQL);
ResultSet interviewRs = interviewStmt.executeQuery();

// 결과 반복문으로 처리
while (interviewRs.next()) {
    String PostNum = interviewRs.getString("PostNum");
    String Title = interviewRs.getString("Title");
    String AName = interviewRs.getString("AName");
	String AId = interviewRs.getString("AId");
	String BId = interviewRs.getString("BId");
	String BStore = interviewRs.getString("BStore");
	int RId = interviewRs.getInt("RId");
	int applyId = interviewRs.getInt("applyId");
%>
					<tr>
						<td><a href="postdetail_boss.jsp?PostNum=<%=PostNum%>"><%=Title%></a></td>
						<td><a href="applicant_resume.jsp?RId=<%=RId%>" target="_blank"><%=AName%></a></td>
						<td>
							 <a href="apply_hire_mypage.jsp?applyId=<%=applyId%>&PostNum=<%=PostNum%>&RId=<%=RId%>&AId=<%=AId%>&BId=<%=BId%>&BStore=<%=BStore%>&Title=<%=Title%>" target="index">
							 <input type="button" value="채용">
							 </a>
							 <br>
							 <a href="apply_fail_mypage.jsp?applyId=<%=applyId%>&PostNum=<%=PostNum%>&RId=<%=RId%>&BId=<%=BId%>&AName=<%=AName%>&Title=<%=Title%>" target="index">
							<input type="button" value="불채용">
							</a>
						</td>
					</tr>
<%
}

interviewRs.close();
interviewStmt.close();
%>
				</table>
			</div>
		</div>
		
		<div class="employe_wrap">
			<div class="employe_head">
				<span>고용 관리 </span>(<%
            // employee 테이블에서 직원 수 조회
            String employeeCountQuery = "SELECT COUNT(*) AS count FROM employee WHERE BId = ?";
            PreparedStatement employeeCountStmt = con.prepareStatement(employeeCountQuery);
            employeeCountStmt.setString(1, myid);
            ResultSet employeeCountRs = employeeCountStmt.executeQuery();
            int employeeCount = 0;
            if (employeeCountRs.next()) {
                employeeCount = employeeCountRs.getInt("count");
            }
            employeeCountRs.close();
            employeeCountStmt.close();
            out.print(employeeCount);
        %>)
			</div>
			<div class="employe_table">
				<table>
					<tr>
						<th>이름</th>
						<th>요일/시간</th>
						<th>급여</th>
						<th>상태</th>
						<th>채용일/퇴사일</th>
						<th>관리</th>
					</tr>
<%
                // employee 테이블에서 직원 정보 조회
                jsql = "SELECT * FROM employee WHERE BId = ?";
                pstmt = con.prepareStatement(jsql);
                pstmt.setString(1, myid);
                rs = pstmt.executeQuery();

                while(rs.next()) {
					String EId = rs.getString("EId");
                    String AName = rs.getString("AName");
                    String HDay = rs.getString("HDay");
                    String HTime = rs.getString("HTime");
                    int HSalary = rs.getInt("HSalary");
					int RId = rs.getInt("RId");
                    String state = rs.getString("state");
					String hiredate = rs.getString("hiredate");
					String retiredate = rs.getString("retiredate");
					String HSalary2 = formatter.format(HSalary);

					// hiredate 시간 부분 제거
					if (hiredate != null && hiredate.length() > 10) {
					hiredate = hiredate.substring(0, 10);
					}

					// retiredate가 null이면 '근무중' 출력
					if (retiredate == null) {
					retiredate = "근무중";
					}
            %>

					<tr>
						<td>
							<%
							if (!"근무중".equals(retiredate)) { // retiredate값이 존재할 경우(퇴사했을경우)에는 이력서 a태그 동작x
							%>
							<%=AName%>
							<%
							} else {
							%>
								<a href="applicant_resume.jsp?RId=<%=RId%>" target="_blank"><h4><%=AName%></h4></a>
							
							<%
							}
							%>
						</td>
						<td><%=HDay%> / <%=HTime%></td>
						<td><%=HSalary2%>원</td>
						<td><%=state%></td>
						<td><%=hiredate%><br>~<br><%=retiredate%></td>
						<td>
							<a href="employee_update.jsp?EId=<%=EId%>"><input type="button" value="수정"></a>
							<a href="employee_retire.jsp?EId=<%=EId%>&AName=<%=AName%>"><br><input type="button" value="퇴사"></a><br>
							<a href="employee_delete.jsp?EId=<%=EId%>&AName=<%=AName%>"><input type="button" value="삭제"></a>
						</td>
					</tr>
<%
                }
%>
				</table>
			</div>
			
		</div>
	</div>
</div>

<script>
	function openWindow(postNum, Title) {

		console.log("Title: " + Title);

		var encodedTitle = encodeURIComponent(Title); // Title 값 인코딩해서 전달

		window.open("apply_resume.jsp?PostNum=" + postNum + "&BId=<%=myid%>&Title=" + Title, "_blank", "width=1000,height=900");
	}		
</script>
<%
    rs.close();
    pstmt.close();
    con.close();
} catch (Exception e) {
    out.println(e);
}
%>
</body>
</html>
