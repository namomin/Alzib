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

		// alba ���̺��� ȸ�� ���� �ҷ�����
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

		// �̷¼� ��ȸ
		String resumeQuery = "SELECT * FROM resume WHERE AId = ?";
		PreparedStatement resumeStmt = con.prepareStatement(resumeQuery);
		resumeStmt.setString(1, myid);
		ResultSet resumeRs = resumeStmt.executeQuery();

		// ������ �˹� ��ȸ
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
		<a href="main.jsp">Ȩ</a> > <a href="mypageAlba.jsp">��������</a>
</div>
    <div class="member_wrap">
        <table>
            <tr>
                <td rowspan="2" id="profile"><img src="images/egg_icon.png" alt="������"></td>
                <td><span><%=myid%></span></td>
            </tr>
            <tr>
                <td><font color="gray"><%=AName%> / <%=APhone%> / <%=AEmail%></font> 
                <a href="alba_update.jsp"><input type="button" value="����"></a></td>
            </tr>
        </table>
    </div>  
    <div class="bord_wrap">
        <div class="resume_wrap">
            <div class="resume_head">
                <span>�̷¼� ���� <a href="resume_form.jsp"><input type="button" value="�ۼ�"></a></span>
            </div>
            <div class="resume_table">
                <table>
                    <tr>
                        <th>����</th>
                        <th>����</th>
                    </tr>
<%
            while(resumeRs.next()){
                String RTitle = resumeRs.getString("RTitle");
                int RId = resumeRs.getInt("RId");
%>                  
                    <tr>
                        <td><a href="resumedetailview.jsp?RId=<%=RId%>" target="_blank"><%=RTitle%></a></td>
                        <td><a href="resume_delete.jsp?RId=<%=RId%>"><input type="button" value="����"></a></td>
                    </tr>
<%
            }   
%>
                </table>
            </div>
        </div>
 
<script>
function openWindow(postNum) {
    // ���ο� â�� ���ϴ�.
    window.open("chat.html?PostNum=" + postNum + "&BId=<%=myid%>", "_blank", "width=800,height=900");
}	
	
</script>	   

        <div class="apply_wrap">
                <div class="apply_head">
                    <span>������ ���� </span>(<%=numAppliedJobs%>)
                </div>
                <div class="apply_table">
                    <table>
                        <tr>
                            <th>���ΰ�������</th>
							<th>�̷¼�����</th>
                            <th>����</th>
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
                    state = "Ȯ����";
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
                <span>�ٹ� ���� </span>(<%
            // employee ���̺��� ���� �� ��ȸ
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
                        <th>�ٹ�ó</th>
                        <th>����/�ð�</th>
                        <th>�޿�</th>
                        <th>����</th>
                        <th>ä����/�����</th>
                    </tr>
<%
                // employee ���̺��� ���� ���� ��ȸ
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
						<td><%=BStore%></td>
						<td><%=HDay%> / <%=HTime%></td>
						<td><%=HSalary2%>��</td>
						<td>
							<% if ("�հ�".equals(state)) { %>
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
