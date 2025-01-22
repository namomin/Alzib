<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import = "java.sql.*"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>알바생 정보 관리</title>
<link href="employee_update.css" rel="stylesheet" type="text/css">

<!--숫자 단위마다 ',' 자동으로 쓰기...인데 동작안해서 뺌-->
<script type="text/javascript">
    function addCommas(value) {
        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
</script>

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

        String EId = request.getParameter("EId"); // EId 파라미터 추가

        String sql = "SELECT * FROM employee WHERE EId=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, EId); // EId 파라미터로 쿼리 실행
        rs = pstmt.executeQuery();

        if (rs.next()) {
			String AName = rs.getString("AName");
            String HDay = rs.getString("HDay");
			String HTime = rs.getString("HTime");
			String HSalary = rs.getString("HSalary");
%>
<div class="wrap">
<div class="board_wrap">
	<div class="header">
		<h2>알바생 관리</h2>
	</div>
	
	<form name="employee_update" action="employee_updateResult.jsp" method="post">
		<table>
			<tr>
				<th>이름</th>
				<td id="NAME"><input type="hidden" name="AName" value="<%=AName%>">홍길동</td>
			</tr>
			<tr>
				<th>근무 요일</th>
				<td><input type="text" name="HDay" value="<%=HDay%>"></td>
			</tr>
			<tr>
				<th>근무 시간</th>
				<td><input type="text" name="HTime" value="<%=HTime%>"></td>
			</tr>
			<tr>
				<th>급여</th>
				<td><input type="text" name="HSalary" value="<%=HSalary%>"></td>
			</tr>
		</table>
		<input type="hidden" name="EId" value="<%=EId%>">
		<input type="submit" value="수정완료"> &nbsp;&nbsp;&nbsp; 
		<a href="mypageBoss.jsp"><input type="button" value="취소"></a>
	</form>
</div>
</div>
<%
        } else {
            out.println("채용 정보를 가져올 수 없습니다.");
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
