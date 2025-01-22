<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>ī�װ��� �Խ���</title>
    <link href="sns_category.css" rel="stylesheet" type="text/css">

    <script>
        function search() {
            var keyword = document.getElementById("searchbar").value;
            window.location.href = "sns_categorysearchResult.jsp?keyword=" + encodeURIComponent(keyword);
        }

        function onKeyPress(event) {
            if (event.keyCode === 13) {
                search();
            }
        }
    </script>
</head>
<body>
<div class="wrap">
    <div class="main_wrap">
<%
	String Category = request.getParameter("Category");
	String Category_name;

	if (Category != null) {
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
	}
	else {
		Category_name = "��ü�Խ���";
	}
%>

        <div class="head_wrap">
            <table>
                <th align="left">
                    <a href="sns_main.jsp"><button>����</button></a>
                    <h2><%= Category_name %></h2>
                    <% 
                    String keyword = request.getParameter("keyword");
                    if (keyword != null && !keyword.isEmpty()) {
                        out.println("'" + keyword + "' �˻� ���");
                    }
                    %>
                </th>
                <th align="right">
                    <input type="text" id="searchbar" name="keyword" placeholder="�˻�� �Է��ϼ���" onkeypress="onKeyPress(event)">
                    <input type="button" value="search" onclick="search()">
                </th>
            </table>
        </div>

        <div class="table_wrap">
            <table>
                <th><a href="sns_categoryview.jsp?Category=free">����</a></th>
                <th><a href="sns_categoryview.jsp?Category=information">����</a></th>
                <th><a href="sns_categoryview.jsp?Category=complain">�ϼҿ�</a></th>
                <th><a href="sns_categoryview.jsp?Category=q">����</a></th>
                <th><a href="sns_categoryview.jsp?Category=after">�ı�</a></th>
            </table>

<%
	String DB_URL = "jdbc:mysql://localhost:3306/alzib";
	String DB_ID = "multi";
	String DB_PASSWORD = "abcd";

	String word = request.getParameter("keyword");

	try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

	String sql = "SELECT * FROM sns WHERE Title LIKE ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, "%" + word + "%");
	ResultSet rs = pstmt.executeQuery();
	
	while (rs.next()) {
		int SId =  rs.getInt("SId");
		String Title = rs.getString("Title");
		String Sdate = rs.getString("Sdate");
%>
                    
                    <div class="detailview">
                        <a href="sns_detailview.jsp?SId=<%=SId%>">
                            <table>
                                <tr>
                                    <td><h3><%=Title%></h3></td>
                                </tr>
                                <tr>
                                    <td id="si"><%=Sdate%> &nbsp; ��ȸ��9999 &nbsp; ���ƿ�9999</td>
                                </tr>
                            </table>
                        </a>
                    </div>
<%
}

rs.close();
pstmt.close();
con.close();
} catch (Exception e) {
out.println(e);
}
%>
        </div>
    </div>
</div>
</body>
</html>
