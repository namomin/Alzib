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

		// boss ���̺��� ȸ�� ���� �ҷ�����
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
		<a href="main.jsp">Ȩ</a> > <a href="mypageBoss.jsp">���ΰ���</a>
</div>
	<div class="member_wrap">
		<table>
			<tr>
				<td rowspan="2" id="profile"><img src="images/egg_icon.png" alt="������"></td>
				<td><span><%=myid%></span></td>
			</tr>

			<tr>
				<td><font color="gray"><%=BName%> / <%=BPhone%> / <%=BEmail%></font> <a href="boss_update.jsp?BId=<%=myid%>"><input type="button" value="����"></a></td>
			</tr>
		</table>
	</div>	
	<div class="bord_wrap">
		
		<div class="resume_wrap">
			<div class="resume_head">
				<span>���� ���� <a href="postmap.jsp"><input type="button" value="�ۼ�"></a></span>
			</div>
			<div class="resume_table">
				<table>
					<tr>
						<th>����</th>
						<th>������</th>
						<th>����</th>
					</tr>
<%
        // post ���̺��� ���� ���� �ҷ�����
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
						<td><input type="button" value="����" onclick="openWindow('<%=PostNum%>', '<%=Title%>')"></td>
						<!--<td><a href="apply_resume.jsp?PostNum=<%=PostNum%>&Title=<%=Title%>" target="index"><input type="button" value="����"></a></td>-->
						<td><a href="post_delete.jsp?PostNum=<%=PostNum%>"><input type="button" value="����"></a></td>
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
				<span>���� ����</span>
			</div>
			<div class="resume_table">
				<table id="interview">
					<tr>
						<th>����</th>
						<th>�̸�</th>
						<th>����</th>
					</tr>
<%
// apply ���̺�� post ���̺��� �����Ͽ� ���°� '������'�� �׸���� �������� SQL ����
String interviewSQL = "SELECT apply.AId, apply.BId, apply.PostNum, post.Title, post.Bstore, apply.AName, apply.RId, apply.applyId FROM apply JOIN post ON apply.PostNum = post.PostNum WHERE apply.state = '��������'";

PreparedStatement interviewStmt = con.prepareStatement(interviewSQL);
ResultSet interviewRs = interviewStmt.executeQuery();

// ��� �ݺ������� ó��
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
							 <input type="button" value="ä��">
							 </a>
							 <br>
							 <a href="apply_fail_mypage.jsp?applyId=<%=applyId%>&PostNum=<%=PostNum%>&RId=<%=RId%>&BId=<%=BId%>&AName=<%=AName%>&Title=<%=Title%>" target="index">
							<input type="button" value="��ä��">
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
				<span>��� ���� </span>(<%
            // employee ���̺��� ���� �� ��ȸ
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
						<th>�̸�</th>
						<th>����/�ð�</th>
						<th>�޿�</th>
						<th>����</th>
						<th>ä����/�����</th>
						<th>����</th>
					</tr>
<%
                // employee ���̺��� ���� ���� ��ȸ
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

					// hiredate �ð� �κ� ����
					if (hiredate != null && hiredate.length() > 10) {
					hiredate = hiredate.substring(0, 10);
					}

					// retiredate�� null�̸� '�ٹ���' ���
					if (retiredate == null) {
					retiredate = "�ٹ���";
					}
            %>

					<tr>
						<td>
							<%
							if (!"�ٹ���".equals(retiredate)) { // retiredate���� ������ ���(����������)���� �̷¼� a�±� ����x
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
						<td><%=HSalary2%>��</td>
						<td><%=state%></td>
						<td><%=hiredate%><br>~<br><%=retiredate%></td>
						<td>
							<a href="employee_update.jsp?EId=<%=EId%>"><input type="button" value="����"></a>
							<a href="employee_retire.jsp?EId=<%=EId%>&AName=<%=AName%>"><br><input type="button" value="���"></a><br>
							<a href="employee_delete.jsp?EId=<%=EId%>&AName=<%=AName%>"><input type="button" value="����"></a>
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

		var encodedTitle = encodeURIComponent(Title); // Title �� ���ڵ��ؼ� ����

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
