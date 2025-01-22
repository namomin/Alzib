<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import = "java.sql.*"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>ȸ������ ����</title>
<link href="boss_update.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/alzib";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String myid = (String) session.getAttribute("sid");

        String sql = "SELECT * FROM boss WHERE BId=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, myid);
        rs = pstmt.executeQuery();

        if (rs.next()) {
			String BId = rs.getString("BId");
            String BName = rs.getString("BName");
			String BPhone = rs.getString("BPhone");
			String BEmail = rs.getString("BEmail");
			String BBusiness = rs.getString("BBusiness");
			String BStore = rs.getString("BStore");
			String BAddress = rs.getString("BAddress");
%>
<div class="wrap">
<div class="board_wrap">
	<div class="header">
		<h2>ȸ������ ����</h2>
	</div>
	
	<form name="boss_update" action="boss_updateResult.jsp" method="post">
		<table>
			<tr>
				<th>���̵�</th>
				<td id="ID"><input type="hidden" name="BId" value="<%=BId%>"><%=BId%></td>
			</tr>
			<tr>
				<th>��й�ȣ</th>
				<td id="PASSWORD"><a href="#"><button>�����ϱ�</button></a></td>
			</tr>
			<tr>
				<th>�̸�</th>
				<td><input type="text" name="BName" value="<%=BName%>"></td>
			</tr>
			<tr>
				<th>��ȭ��ȣ</th>
				<td><input type="text" name="BPhone" value="<%=BPhone%>"></td>
			</tr>
			<tr>
				<th>�̸���</th>
				<td><input type="text" name="BEmail" value="<%=BEmail%>"></td>
			</tr>
			<tr>
				<th>����ڵ�Ϲ�ȣ</th>
				<td id="BBusiness"><input type="hidden" name="BBusiness" value="<%=BBusiness%>">123456789</td>
			</tr>
			<tr>
				<th>ȸ��/������</th>
				<td><input type="text" name="BStore" value="<%=BStore%>"></td>
			</tr>
			<tr>
				<th>�ּ�</th>
				<td><input type="text" name="BAddress" value="<%=BAddress%>"></td>
			</tr>
		</table>
		<input type="submit" value="�����Ϸ�"> &nbsp;&nbsp;&nbsp; 
		<a href="mypageBoss.jsp"><input type="button" value="���"></a>
	</form>
</div>
</div>
<%
        } else {
            out.println("ȸ�� ������ ������ �� �����ϴ�.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null && !con.isClosed()) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>