<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import = "java.sql.*"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>회원정보 수정</title>
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
		<h2>회원정보 수정</h2>
	</div>
	
	<form name="boss_update" action="boss_updateResult.jsp" method="post">
		<table>
			<tr>
				<th>아이디</th>
				<td id="ID"><input type="hidden" name="BId" value="<%=BId%>"><%=BId%></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td id="PASSWORD"><a href="#"><button>변경하기</button></a></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="BName" value="<%=BName%>"></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="BPhone" value="<%=BPhone%>"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="BEmail" value="<%=BEmail%>"></td>
			</tr>
			<tr>
				<th>사업자등록번호</th>
				<td id="BBusiness"><input type="hidden" name="BBusiness" value="<%=BBusiness%>">123456789</td>
			</tr>
			<tr>
				<th>회사/점포명</th>
				<td><input type="text" name="BStore" value="<%=BStore%>"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="BAddress" value="<%=BAddress%>"></td>
			</tr>
		</table>
		<input type="submit" value="수정완료"> &nbsp;&nbsp;&nbsp; 
		<a href="mypageBoss.jsp"><input type="button" value="취소"></a>
	</form>
</div>
</div>
<%
        } else {
            out.println("회원 정보를 가져올 수 없습니다.");
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