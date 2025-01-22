<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=euc-kr">
  <title>�Խñ� ���� ���</title>
  <link href="sns_detailview.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="wrap">
	<div class="side_left">
		<div class="category_wrap">
			
			<a href="sns_main.jsp"><button>����</button></a>
			
			<ul>
				<li><a href="sns_categoryview.jsp?Category=free">�����Խ���</a></li>
				<li><a href="sns_categoryview.jsp?Category=information">�����Խ���</a></li>
				<li><a href="sns_categoryview.jsp?Category=complain">�ϼҿ��Խ���</a></li>
				<li><a href="sns_categoryview.jsp?Category=q">�����Խ���</a></li>
				<li><a href="sns_categoryview.jsp?Category=after">�ı�Խ���</a></li>
			</ul>
		</div>
	</div>
	
	<div class="main">

<%
String myid = (String) session.getAttribute("sid");

    if (session.getAttribute("sid") == null) {
        response.sendRedirect("login.html");
    }

request.setCharacterEncoding("euc-kr");

String SId = request.getParameter("SId");
String Category = request.getParameter("Category");
String Title = request.getParameter("Title");
String Content = request.getParameter("Content");

try {
    String DB_URL="jdbc:mysql://localhost:3306/alzib";
    String DB_ID="multi";
    String DB_PASSWORD="abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    String jsql = "UPDATE sns SET Category=?, Title=?, Content=? WHERE SId=?";
    PreparedStatement pstmt = con.prepareStatement(jsql);
    pstmt.setString(1, Category);
    pstmt.setString(2, Title);
    pstmt.setString(3, Content);
    pstmt.setString(4, SId);

    pstmt.executeUpdate();

    String jsq4 = "SELECT * FROM sns WHERE SId=?";
    PreparedStatement pstmt2 = con.prepareStatement(jsq4);
    pstmt2.setString(1, SId);

    ResultSet rs = pstmt2.executeQuery();
    rs.next();
	
	int Viewcount = rs.getInt("Viewcount");
%>

<%
	String Category_name;

    if (Category.equals("free"))
		Category_name = "�����Խ���";
	else if (Category.equals("information"))
		Category_name = "�����Խ���";
	else if (Category.equals("complain"))
		Category_name = "�ϼҿ��Խ���";
	else if (Category.equals("q"))
		Category_name = "�����Խ���";
	else 
		Category_name = "�ı�Խ���";
%>
		<div class="board_wrap">
				<div class="head_wrap">
					<table>
						<tr>
							<td><font color="#0047A9"><%=Category_name%></font></td>
						</tr>
						<tr>
							<td><h2><%=Title%></h2></td>
						</tr>
						<tr>
							<td><font color="gray" size="2"><%=rs.getString("Sdate")%> &nbsp; ��ȸ�� <%=Viewcount%></font></td>
						</tr>
					</table>
				</div>
				
				<div class="content_wrap">
					<table>
						<tr>
							<td><%=Content%></td>
						</tr>
						<tr>
							<td id="like"><button>���ƿ�</button></td>
						</tr>
					</table>
				</div>
		</div>
		
		<div style="display: flex; justify-content: center; align-items: center; height: 100vh;">
	<!-- sns_comment.jsp ���� �ҷ�����-->
	<iframe src="sns_comment.jsp?SId=<%=SId%>" frameborder="0" scrolling="auto" width="700" height="900" style="display:block; margin:auto;"></iframe>
	</div>
		
		
	<div class="side_right">
		<div class="my_wrap">
			<a href="sns_write.jsp"><input type="button" value="�Խñ� �ۼ�" id="write_button"></a>
			<br><br><br><br>
			
			<div class="my">
			<span id="memberid"><%=myid%></span>
			<span id="text">���� Ȱ��</span><br><br>
<%
    } catch(Exception e) {
		out.println(e);
}
%>			
			<ul>
                <li align="left"><a href="sns_mywrite.jsp">���� �� �Խñ�</a></li>
                <li align="left"><a href="sns_mycomment.jsp">���� �� ���</a></li>
				<li align="left"><a href="sns_myscrap.jsp">��ũ���� �Խñ�</a></li>
            </ul>
			</div>
		</div>
	</div>
</div>
</div>

</body>
</html>
