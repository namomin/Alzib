<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head><title>게시글 삭제</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<style>
	@font-face {
		font-family: 'GmarketSansMedium';
		src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		font-weight: normal;
		font-style: normal;
	}
	  
	body {
		font-family: GmarketSansMedium, sans-serif;
	}

	.modal {
		display: none;
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.5);
		justify-content: center;
		align-items: center;
	}

	.modal-content {
		background: white;
		padding: 20px;
		margin-top: 20%;
		border-radius: 10px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		text-align: center;
		max-width: 500px;
		width: 100%;
	}

	.btn {
		font-family: 'GmarketSansMedium', sans-serif;
		background-color: #689ADE;
		color: white;
		width: 100px;
		padding: 10px;
		border: none;
		cursor: pointer;
		display: inline-block;
		margin-top: 10px;
		font-weight: bold;	
		font-size: 19px;
		box-shadow: 5px 5px 5px rgba(33, 86, 158, 0.5);
	}
	  
	.btn:hover {
		background-color: #CADCF4;
	}
</style>

</head>
<body>

<%
	try{

		String DB_URL = "jdbc:mysql://localhost:3306/alzib";
		String DB_ID = "multi";
		String DB_PASSWORD = "abcd";

		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

		String key = request.getParameter("CId");

		String jsql = "select * from comment where CId = ?";
		PreparedStatement pstmt = con.prepareStatement(jsql);
		pstmt.setString(1, key);

		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		int CId = rs.getInt("CId");
		int SId =  rs.getInt("SId");
		String CWId = rs.getString("CWId");
		String CText = rs.getString("CText");
		String Cdate = rs.getString("Cdate");
%>

<center>
<div>
  <div class="modal-content">
    <p><h3><font color="#0047A9">" <%=CText%> "</font></h3>해당 댓글을 삭제하시겠습니까?</p>
    <a href="sns_commentdeleteResult.jsp?CId=<%=CId%>"><button class="btn btn-yes">삭제</button></a>
    <a href="sns_mycomment.jsp"><button class="btn btn-no">취소</button></a>
  </div>
</div>
</center>

<%
    } catch (Exception e) {
    	out.println(e);
}
%>

</body>
</html>