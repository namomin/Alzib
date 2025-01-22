<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<link href="sns_detailview.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
		request.setCharacterEncoding("euc-kr");

		String myid = (String) session.getAttribute("sid");

		if (session.getAttribute("sid") == null) {
        response.sendRedirect("login.html");
		}

		String Title = request.getParameter("Title");
		String Content = request.getParameter("Content");
        String Category = request.getParameter("Category");
        String SWId = request.getParameter("SWId");

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/alzib";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Class.forName("org.gjt.mm.mysql.Driver");
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

		String jsql = "INSERT INTO sns (SWId, Title, Content, Category) VALUES (?, ?, ?, ?)";
		PreparedStatement pstmt = con.prepareStatement(jsql, Statement.RETURN_GENERATED_KEYS); // 생성된 키를 반환받기 위해 Statement.RETURN_GENERATED_KEYS 옵션 사용
		pstmt.setString(1, SWId);
		pstmt.setString(2, Title);
		pstmt.setString(3, Content);
		pstmt.setString(4, Category);
		pstmt.executeUpdate();

		ResultSet generatedKeys = pstmt.getGeneratedKeys();
		if (generatedKeys.next()) {
			int SId = generatedKeys.getInt(1); // 새로 생성된 SId 가져오기
			response.sendRedirect("sns_detailview.jsp?SId=" + SId);
		} else {
			out.println("게시글 업로드에 실패했습니다.");
		}

    } catch (Exception e) {
        out.println(e);
}
%>
</body>
</html>
