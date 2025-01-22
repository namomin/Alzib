<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>mypage_alba</title>
<link href="mypageAlba.css" rel="stylesheet" type="text/css">

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
		if (myid == null) {
			response.sendRedirect("login.jsp");
		}

		DecimalFormat formatter = new DecimalFormat("#,###");

		String DB_URL = "jdbc:mysql://localhost:3306/alzib";
		String DB_ID = "multi";
		String DB_PASSWORD = "abcd";

		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

		// alba 테이블에서 회원 정보 불러오기
		String albaQuery = "SELECT * FROM alba WHERE AId = ?";
		PreparedStatement albaStmt = con.prepareStatement(albaQuery);
		albaStmt.setString(1, myid);
		ResultSet albaRs = albaStmt.executeQuery();
		String AName = "";
		String APhone = "";
		String AEmail = "";
		if (albaRs.next()) {
			AName = albaRs.getString("AName");
			APhone = albaRs.getString("APhone");
			AEmail = albaRs.getString("AEmail");
		}

		// 이력서 조회
		String resumeQuery = "SELECT * FROM resume WHERE AId = ?";
		PreparedStatement resumeStmt = con.prepareStatement(resumeQuery);
		resumeStmt.setString(1, myid);
		ResultSet resumeRs = resumeStmt.executeQuery();

		// 지원한 알바 조회
		String applyQuery = "SELECT COUNT(*) AS num FROM apply WHERE AId = ?";
		PreparedStatement applyStmt = con.prepareStatement(applyQuery);
		applyStmt.setString(1, myid);
		ResultSet applyRs = applyStmt.executeQuery();
		int numAppliedJobs = 0;
		if (applyRs.next()) {
			numAppliedJobs = applyRs.getInt("num");
		}
%>

<div class="wrap">
<div class="nav">
		<a href="main.jsp">홈</a> > <a href="mypageAlba.jsp">구직관리</a>
</div>
    <div class="member_wrap">
        <table>
            <tr>
                <td rowspan="2" id="profile"><img src="images/egg_icon.png" alt="프로필"></td>
                <td><span><%=myid%></span></td>
            </tr>
            <tr>
                <td><font color="gray"><%=AName%> / <%=APhone%> / <%=AEmail%></font> 
                <a href="alba_update.jsp"><input type="button" value="수정"></a></td>
            </tr>
        </table>
    </div>  
    <div class="bord_wrap">
        <div class="resume_wrap">
            <div class="resume_head">
                <span>이력서 관리 <a href="resume_form.jsp"><input type="button" value="작성"></a></span>
            </div>
            <div class="resume_table">
                <table>
                    <tr>
                        <th>제목</th>
                        <th>관리</th>
                    </tr>
<%
            while(resumeRs.next()){
                String RTitle = resumeRs.getString("RTitle");
                int RId = resumeRs.getInt("RId");
%>                  
                    <tr>
                        <td><a href="resumedetailview.jsp?RId=<%=RId%>" target="_blank"><%=RTitle%></a></td>
                        <td><a href="resume_delete.jsp?RId=<%=RId%>"><input type="button" value="삭제"></a></td>
                    </tr>
<%
            }   
%>
                </table>
            </div>
        </div>
 
<script>
function openWindow(postNum) {
    // 새로운 창을 엽니다.
    window.open("chat.html?PostNum=" + postNum + "&BId=<%=myid%>", "_blank", "width=800,height=900");
}	
	
</script>	   

        <div class="apply_wrap">
                <div class="apply_head">
                    <span>지원한 공고 </span>(<%=numAppliedJobs%>)
                </div>
                <div class="apply_table">
                    <table>
                        <tr>
                            <th>구인공고제목</th>
							<th>이력서제목</th>
                            <th>상태</th>
                        </tr>
<%
            applyRs.close();
            applyStmt.close();
            applyQuery = "SELECT a.*, p.Title, r.RTitle " +
             "FROM apply a " +
             "JOIN post p ON a.PostNum = p.PostNum " +
             "LEFT JOIN resume r ON a.RId = r.RId " +
             "WHERE a.AId = ?";
            applyStmt = con.prepareStatement(applyQuery);
            applyStmt.setString(1, myid);
            applyRs = applyStmt.executeQuery();
            while(applyRs.next()){
                String title = applyRs.getString("Title");
                String state = applyRs.getString("state");
                if (state == null) {
                    state = "확인중";
                }
                int PostNum = applyRs.getInt("PostNum");
				int RId = applyRs.getInt("RId");
				String RTitle = applyRs.getString("RTitle");
%>
                        <tr>
                            <td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>" target="_blank"><%=title%></a></td>
							<td><a href="resumedetailview.jsp?RId=<%=RId%>"><%=RTitle%></a></td>
                            <td><%=state%></td>
                        </tr>
<%
            }   
%>
                    </table>
                </div>
            </div>
        
        <div class="employe_wrap">
            <div class="employe_head">
                <span>근무 관리 </span>(<%
            // employee 테이블에서 직원 수 조회
            String employeeCountQuery = "SELECT COUNT(*) AS count FROM employee WHERE AId = ?";
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
                        <th>근무처</th>
                        <th>요일/시간</th>
                        <th>급여</th>
                        <th>상태</th>
                        <th>채용일/퇴사일</th>
                    </tr>
<%
                // employee 테이블에서 직원 정보 조회
                String jsql = "SELECT * FROM employee WHERE AId = ?";
                PreparedStatement pstmt = con.prepareStatement(jsql);
                pstmt.setString(1, myid);
                ResultSet rs = pstmt.executeQuery();

                while(rs.next()) {
                    String EId = rs.getString("EId");
                    String BStore = rs.getString("BStore");
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
						<td><%=BStore%></td>
						<td><%=HDay%> / <%=HTime%></td>
						<td><%=HSalary2%>원</td>
						<td>
							<% if ("합격".equals(state)) { %>
								<font color="#0047A9"><%=state%></font>
							<% } else { %>
								<%=state%>
							<% } %>
						</td>
						<td><%=hiredate%><br>~<br><%=retiredate%></td>
					</tr>
<%
                }
%>
                </table>
            </div>
            
        </div>
        
    </div>
</div>
</body>
</html>
<%
    } catch (Exception e) {
        out.println(e);
}
%>
