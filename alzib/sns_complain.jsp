<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">

<title>sns ����������</title>
<link href="sns_main.css" rel="stylesheet" type="text/css">

<script>
    function search(category) {
    var keyword = document.getElementById("searchbar").value;
    window.location.href = "sns_searchResult.jsp?keyword=" + encodeURIComponent(keyword) + "&Category=" + encodeURIComponent(category);
}



    function onKeyPress(event) {
      if (event.keyCode === 13) { //���Ͱ˻�
        search();
      }
    }
</script>

</head>

<body>

<%
String myid = (String) session.getAttribute("sid");

if(myid == null) {
    myid = "��ȸ��";
}

 try {
          String DB_URL="jdbc:mysql://localhost:3306/alzib";
          String DB_ID="multi";
          String DB_PASSWORD="abcd";

          Class.forName("org.gjt.mm.mysql.Driver");
          Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
		
		String group_index;
    int list_index;

    group_index = request.getParameter("group_index");

    if (group_index != null)
        list_index = Integer.parseInt(group_index);
    else
        list_index = 0; // ���� ������ ��

    int pageSize = 10; // �������� ������ �Խñ� ��

    String Category = request.getParameter("Category");
    String jsqlCategory = "SELECT * FROM sns WHERE Category = ? ORDER BY Sdate DESC LIMIT ?, ?";

    PreparedStatement pstmt = con.prepareStatement(jsqlCategory);
    pstmt.setString(1, Category);
    pstmt.setInt(2, list_index * pageSize); // ���� �ε��� ���
    pstmt.setInt(3, pageSize); // �������� ������ �Խñ� ��

    ResultSet rs = pstmt.executeQuery();

    // �Խñ� �� ��ȸ
    String countQuery = "SELECT COUNT(*) FROM sns WHERE Category = ?";
    PreparedStatement countStmt = con.prepareStatement(countQuery);
    countStmt.setString(1, Category);
    ResultSet countRs = countStmt.executeQuery();
    countRs.next();
    int totalPosts = countRs.getInt(1);
    int totalPage = (int) Math.ceil((double) totalPosts / pageSize); // �� ������ ��
%>

<div class="wrap">
	<div class="side_left">
		<div class="category_wrap">
			<ul>
				<li><a href="sns_free.jsp?Category=free">�����Խ���</a></li>
				<li><a href="sns_information.jsp?Category=information">�����Խ���</a></li>
				<li><a href="sns_complain.jsp?Category=complain">�ϼҿ��Խ���</a></li>
				<li><a href="sns_q.jsp?Category=q">�����Խ���</a></li>
				<li><a href="sns_after.jsp?Category=after">�ı�Խ���</a></li>
			</ul>
		</div>
	</div>	

	
  <div class="main">
		<div class="board_wrap">
			<div class="search_wrap">
				<table>
					<th id="th_logo">
					</th>
					<th id="th_search">
						<input type="text" name="keyword" id="searchbar" placeholder="�˻�� �Է��ϼ���" onkeypress="onKeyPress(event)"> &nbsp;
						<input type="button" id="button" value="search" onclick="search('complain')">
					</th>
				</table>
			</div>
			
			<div class="ad_wrap">
				<a href="#"><table><tr><td>�����̹��� ũ��</td></tr></table></a>
			</div>
			
			<div class="board_wrap">
				<div class="head">
					<h2>�ϼҿ��Խ���</h2>
				</div>

<%
	while(rs.next()){
		int SId =  rs.getInt("SId");
		String Title = rs.getString("Title");
		String Content = rs.getString("Content");
		String Sdate = rs.getString("Sdate");
		int Viewcount = rs.getInt("Viewcount");
		int heart = rs.getInt("heart");
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

				<div class="content_wrap">
					<a href="sns_detailview.jsp?SId=<%=SId%>">
						<table>
							<tr>
								<td>
									<font color="gray" size="2"><%=Category_name%>
									</font>
								</td>
								<!--<td rowspan="4" class="image">
									���� �̹���
								</td>-->
							</tr>
							<tr>
								<td><h3><%=Title%></h3></td>
							</tr>
							<tr>
								<td><%=Content%></td>
							</tr>
							<tr>
								<td><font color="gray" size="2"><%=Sdate%> &nbsp; ��ȸ�� <%=Viewcount%></font></td>
							</tr>
						</table>
					</a>
				</div>
<%
	}  
%>				<br>
            <div align="center">
                <table width="700" border="0" cellspacing="0" cellpadding="5">
                    <tr>&nbsp;</tr>
                    <tr>
                        <td colspan="5">
                            <div align="center">
                                <%-- ó�� �������� �̵� --%>
                                <a href="sns_complain.jsp?Category=<%=Category%>&group_index=0">
                                    <img src="images/before_icon.png" alt="ó��">
                                </a>
                                <span id="pagenumber">
                                <%-- ������ ��ȣ ��� --%>
                                <% 
                                    for (int j = 0; j < totalPage; j++) {
                                        if (j == list_index) {
                                %>
                                            <span id="present"><%= j + 1 %></span>
                                <%
                                        } else {
                                %>
                                            <a href="sns_complain.jsp?Category=<%=Category%>&group_index=<%= j %>"><%= j + 1 %></a>
                                <%
                                        }
                                    }
                                %>
								</span>

                                &nbsp;&nbsp;&nbsp;
                                <%-- ������ �������� �̵� --%>
                                <a href="sns_complain.jsp?Category=<%=Category%>&group_index=<%= totalPage - 1 %>">
                                    <img src="images/after_icon.png" alt="��">
                                </a>
                            </div>
			</div>
		</div>
	</div>
	
	
	<div class="side_right">
		<div class="my_wrap">
			<a href="sns_write.jsp"><input type="button" value="�Խñ� �ۼ�" id="write_button"></a>
			<br><br><br><br>
			
			<div class="my">
			<span id="memberid"><%=myid%></span>
			<span id="text">���� Ȱ��</span><br><br>
			
			<ul>
                <li align="left"><a href="sns_mywrite.jsp">���� �� �Խñ�</a></li>
                <li align="left"><a href="sns_mycomment.jsp">���� �� ���</a></li>
				<li align="left"><a href="sns_myscrap.jsp">��ũ���� �Խñ�</a></li>
            </ul>
			</div>
		</div>
	</div>
</div>
<%
 }catch (Exception e) {
out.println(e);  
}
%>
</body>
</html>
