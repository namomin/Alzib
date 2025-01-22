<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
  <title>�Խñ� ����</title>
  <link href="sns_write.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
  try {
       String DB_URL="jdbc:mysql://localhost:3306/alzib"; 
       String DB_ID="multi";  
       String DB_PASSWORD="abcd"; 
       
       Class.forName("org.gjt.mm.mysql.Driver"); 
       Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

       String key = request.getParameter("SId");

       String jsql = "SELECT * FROM sns WHERE SId = ?";       
       PreparedStatement pstmt  = con.prepareStatement(jsql);
       pstmt.setString(1, key);

       ResultSet rs = pstmt.executeQuery();
       rs.next();

       int SId =  rs.getInt("SId");
       String SWId = rs.getString("SWId");
	   String Title = rs.getString("Title");
       String Content = rs.getString("Content");
	   String Category = rs.getString("Category");
       String Sdate =  rs.getString("Sdate");
  %>

<form method="post" action="sns_writeupdateResult.jsp">
	
<div class="board_wrap">
	<div class="background">
	<table width="625">
			<thead><tr><td width="617"><h2>�Խñ� �ۼ�</h2></td></tr></thead>
			 <tr>
				<td> <input type=hidden name=SId value="<%=SId%>">
<%
	String[] selected = new String[5];
	
	if(Category.equals("free")){
		selected[0] = "selected";
	}
	else if(Category.equals("information")){
		selected[1] = "selected";
	}
	else if(Category.equals("complain")){
		selected[2] = "selected";
	}
	else if(Category.equals("q")){
		selected[3] = "selected";
	}
	else if(Category.equals("after")){
		selected[4] = "selected";
	}
%>
					<select name="Category">
						<option value="free" <%=selected[0]%>>�����Խ���</option>
						<option value="information" <%=selected[1]%>>�����Խ���</option>
						<option value="complain" <%=selected[2]%>>�ϼҿ��Խ���</option>
						<option value="q" <%=selected[3]%>>�����Խ���</option>
						<option value="after" <%=selected[4]%>>�ı�Խ���</option>
					</select> 
				</td>
			 </tr>
			<tr>
				<td><input type=text name="Title" value="<%=Title%>"></td>
			</tr>
			
			<tr>
				<td height="300"><textarea name="Content"cols="10px" rows="15px" ><%=Content%></textarea></td>
			</tr>
			
			<tfoot><tr>
				<td align="left">
					<label for="fileinput" id="custom_fileinput"> <!--input �±׿� �����Ͽ� ��ưŸ�� ����-->
					<input type="file" id="fileinput" onchange="displayFileName()">
					</label>
					<span id="filename"></span> <!--������ ���� ��-->
				</td>
			</tr></tfoot>
			
		</table>
		</div>
	
	
	<div class="bottom">
	  <center><input type="submit" value="���"> &nbsp;&nbsp; <a href="sns_mywrite.jsp"><input type="button" value="���ư���"></a></center>
	</div>	
</div>
</form>
<%
  } catch (Exception e) {
      out.println(e);
  }
%>


</body>
</html>

