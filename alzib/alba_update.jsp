<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import = "java.sql.*"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>ȸ������ ����</title>
<link href="alba_update.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
	request.setCharacterEncoding("euc-kr");

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

        String sql = "SELECT * FROM alba WHERE AId=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, myid);
        rs = pstmt.executeQuery();

        if (rs.next()) {
			String AId = rs.getString("AId");
            String AName = rs.getString("AName");
			String ABirth = rs.getString("ABirth");
			String APhone = rs.getString("APhone");
			String AEmail = rs.getString("AEmail");
%>
<div class="wrap">
<div class="board_wrap">
	<div class="header">
		<h2>ȸ������ ����</h2>
	</div>
	
	<form name="alba_update" action="alba_updateResult.jsp" method="post">
		<table>
			<tr>
				<th>���̵�</th>
				<td id="ID"><input type="hidden" name="AId" value="<%=AId%>"><%=AId%></td>
			</tr>
			<tr>
				<th>��й�ȣ</th>
				<td id="PASSWORD"><a href="#"><button>�����ϱ�</button></a></td>
			</tr>
			<tr>
				<th>�̸�</th>
				<td><input type="text" name="AName" value="<%=AName%>"></td>
			</tr>
			<tr>
				<th>�������</th>
				<td><input type="date" name="ABirth" value="<%=ABirth%>"></td>
			</tr>
			<tr>
				<th>��ȭ��ȣ</th>
				<td> <input type="text" id="phone" name="APhone" value="<%=APhone%>" oninput="formatPhoneNumber(this);"></td>
			</tr>
			<tr>
				<th>�̸���</th>
				<td><input type="text" name="AEmail" value="<%=AEmail%>"></td>
			</tr>
		</table>
		<input type="submit" value="�����Ϸ�"> &nbsp;&nbsp;&nbsp; 
		<a href="mypageAlba.jsp"><input type="button" value="���"></a>
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