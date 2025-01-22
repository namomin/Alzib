<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
	request.setCharacterEncoding("UTF-8");
    // 세션에서 BId 값 가져오기
    String AId = (String) session.getAttribute("sid");

    // 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // JDBC 드라이버 로드
       

        // 데이터베이스 연결
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL 쿼리 작성
        String query = "SELECT AName, ABirth, APhone, AEmail, RTitle, RAbility, RHigh, RCollege, RCareer, HArea, HType, HForm, HPeriod, HDay, HTime, HSalary, RIntroduce, REtc FROM Resume WHERE AId = ?";

        // PreparedStatement 객체 생성
        pstmt = con.prepareStatement(query);

        // SQL 쿼리에 파라미터 값 설정
        pstmt.setString(1, AId);

        // SQL 실행 및 결과 가져오기
        rs = pstmt.executeQuery();

        // 결과가 있을 경우
        if (rs.next()) {
            // 결과에서 필드 값 가져오기
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

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>이력서</title>
<link href="resume.css" rel="stylesheet" type="text/css">
</head>

<body>
<form>
	<hr><h1>이력서 제목 연동</h1><hr>
	<div>
		<section class="image"></section>
		<p><%=AName%></p>
		<p><%=ABirth%></p>
		<p>전화번호 : <%=APhone%></p>
		<p>이메일 : <%=AEmail%></p>
	</div>

	<div>
		<h3>학력</h3><p><%=RAbility%></p>
		<p><%=RHigh%></p>
		<p><%=RCollege%></p>
	</div>
	<div>
		<h3>경력</h3>
		<p><%=RCareer%></p>
	</div>
	<div>
		<h3>희망 근무 조건</h3>
		<table>
			<tr>
				<td>근무지 :</td>
				<td><%=HArea%></td>
			</tr>
			<tr>
				<td>업직종 :</td>
				<td><%=HType%></td>
			</tr>
			<tr>
				<td>근무 형태 :</td>
				<td><%=HForm%></td>
			</tr>
			<tr>
				<td>근무 기간 :</td>
				<td><%=HPeriod%></td>
			</tr><tr>
				<td>근무 요일 :</td>
				<td><%=HDay%></td>
			</tr>
			<tr>
				<td>근무 시간 :</td>
				<td><%=HTime%></td>
			</tr>
			<tr>
				<td>급여 :</td>
				<td><%=HSalary%></td>
			</tr>
		</table>
	</div>
	<div>
		<h3>자기 소개서</h3>
		<p><%=RIntroduce%></p>
	</div>
	<div id="last">
		<h3>기타</h3>
		<p><%=REtc%></p>
	</div>	
</form>
</body>
</html>

<%
	   } else {
            // 세션에서 AId에 해당하는 정보를 찾을 수 없는 경우에 대한 처리
            out.println("해당하는 정보를 찾을 수 없습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 자원 해제
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>