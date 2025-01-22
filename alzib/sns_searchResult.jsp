<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>sns</title>
<link href="snsmain.css" rel="stylesheet" type="text/css">

<script>
    function search() {
      var keyword = document.getElementById("search_bar").value;
      window.location.href = "sns_searchResult.jsp?keyword=" + encodeURIComponent(keyword);
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

Connection con = null;
ResultSet rs = null;
int totalPage = 0;
int list_index = 0;

String word = request.getParameter("keyword");
String category = request.getParameter("Category");

try {
    String DB_URL="jdbc:mysql://localhost:3306/alzib";
    String DB_ID="multi";
    String DB_PASSWORD="abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
    
    String sql;
    PreparedStatement pstmt = null; // ���⼭ pstmt ���� ����

    // ī�װ� ���� ���� SQL ���� ���� ����
    if (category != null && !category.isEmpty()) {
        sql = "SELECT * FROM sns WHERE Title LIKE ? AND Category = ? ORDER BY Sdate DESC"; // ī�װ� ����
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, "%" + word + "%");
        pstmt.setString(2, category);
    } else {
        sql = "SELECT * FROM sns WHERE Title LIKE ? ORDER BY Sdate DESC"; // ī�װ� ������
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, "%" + word + "%");
    }

    // ������ ���� �Ķ����
    String group_index = request.getParameter("group_index");
    if (group_index != null) {
        list_index = Integer.parseInt(group_index);
    } else {
        list_index = 0; // ���� ������ ��
    }

    int pageSize = 5; // �������� ������ �Խñ� ��

    // �������� �´� �Խñ� ��ȸ
    rs = pstmt.executeQuery();

    // �Խñ� �� ��ȸ
    String countQuery = "SELECT COUNT(*) FROM sns";
    PreparedStatement countStmt = con.prepareStatement(countQuery);
    ResultSet countRs = countStmt.executeQuery();
    countRs.next();
    int totalPosts = countRs.getInt(1);
    totalPage = (int) Math.ceil((double) totalPosts / pageSize); // �� ������ ��
%>


<div class="wrap">
    <div class="popular_wrap1">
    <div class="popular_wrap">
        <div class="popular_head">
            <span>������ �α�� top3</span>
        </div>
        <div class="popular_body">
            <div class="popular">
                
                <%
                    String popularSql = "SELECT sns.SId, sns.Title, sns.Content, sns.Sdate, sns.Viewcount, " +
                             "COUNT(comment.CId) AS CommentCount, COUNT(scrap.SCId) AS ScrapCount " +
                             "FROM sns " +
                             "LEFT JOIN comment ON sns.SId = comment.SId " +
                             "LEFT JOIN scrap ON sns.SId = scrap.SId " +
                             "WHERE DATE(sns.Sdate) = CURDATE() " +
                             "GROUP BY sns.SId " +
                             "ORDER BY Viewcount DESC, CommentCount DESC " +
                             "LIMIT 3";
                    PreparedStatement popularStmt = con.prepareStatement(popularSql);
                    ResultSet popularRs = popularStmt.executeQuery();
                    while (popularRs.next()) {
                        int SId = popularRs.getInt("SId");
                        String Title = popularRs.getString("Title");
                        String Content = popularRs.getString("Content");
                        String Sdate = popularRs.getString("Sdate");
                        int Viewcount = popularRs.getInt("Viewcount");
                        int CommentCount = popularRs.getInt("CommentCount");
                        int ScrapCount = popularRs.getInt("ScrapCount");
                %>
                <a href="sns_detailview.jsp?SId=<%=SId%>">
                <table>
                    <tr>
                        <td><font color="gray" size="2"></font></td>
                        <!--<td rowspan="4" class="im">�̹���</td>-->
                    </tr>
                    <tr>
                        <td><h3><%= Title %></h3></td>
                    </tr>
                    <tr>
                        <td class="content"><%= Content %></td>
                    </tr>
                    <tr>
                        <td><font color="gray" size="2"><%= Sdate %> ��ȸ�� <%= Viewcount %> ��ũ�� <%= ScrapCount %></font></td>
                    </tr>
                </table>
                </a>
                <%
                    }
                    popularRs.close();
                    popularStmt.close();
                %>
                
            </div>
        </div>
    </div>
    </div>
    
    <div class="contents">
        <div class="left_wrap">
            <div class="category">
                <table>
                    <tr>
                        <td><a href="snsmain.jsp">����</a></td>
                        <td><a href="snsfree.jsp?Category=free">����</a></td>
                        <td><a href="snsinformation.jsp?Category=information">����</a></td>
                        <td><a href="snscomplain.jsp?Category=complain">�ϼҿ�</a></td>
                        <td><a href="snsq.jsp?Category=q">����</a></td>
                        <td><a href="snsafter.jsp?Category=after">�ı�</a></td>
                    </tr>
                </table>
            </div>

            <div class="content">
				<table>
				<tr>
					<td><% 
							//�˻��ܾ����
							String keyword = request.getParameter("keyword");
								if (keyword != null && !keyword.isEmpty()) {
								out.println("' " + keyword + " ' �˻� ���");
							}
						%></td>
				</tr>
				</table>
<%
    while(rs.next()){
        int SId =  rs.getInt("SId");
        String Title = rs.getString("Title");
        String Content = rs.getString("Content");
		String Category = rs.getString("Category");

        String Sdate = rs.getString("Sdate");
        int Viewcount = rs.getInt("Viewcount");

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
                <a href="sns_detailview.jsp?SId=<%=SId%>">
                <table>
                    <tr>
                        <td><font color="gray" size="2"><%=Category_name%></font></td>
                        <!--<td rowspan="4" class="im">�̹���</td>-->
                    </tr>
                    <tr>
                        <td><h3><%=Title%></h3></td>
                    </tr>
                    <tr>
                        <td class="content"><%=Content%></td>
                    </tr>
                    <tr>
                        <td><font color="gray" size="2"><%=Sdate%> &nbsp; ��ȸ�� <%=Viewcount%> ��ũ��
<%
    try {
        String checkSql = "SELECT COUNT(*) AS count FROM scrap WHERE SId = ?";
        PreparedStatement checkStmt = con.prepareStatement(checkSql);
        checkStmt.setInt(1, SId);
        ResultSet checkResult = checkStmt.executeQuery();
        checkResult.next();
        int count = checkResult.getInt("count");

        // Scrap ���̺��� �ش� SId ���� ���� ���ڵ��� ���� ���
        out.println("<span style=\"font-size: 13px;\">" + count + "</span>");

    } catch (Exception e) {
        out.println(e);
    }
%>
                        </font></td>
                    </tr>
                </table>
                </a>   
<%
    }  
%>
            </div>
            <!--
            <div class="page">
                
                <%-- ó�� �������� �̵� --%>
                <a href="snsmain.jsp?group_index=0">
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
                     <a href="snsmain.jsp?group_index=<%= j %>"><%= j + 1 %></a>
                <%
                         }
                   }
                %>
                </span>
                
                <%-- ������ �������� �̵� --%>
                <a href="snsmain.jsp?group_index=<%= totalPage - 1 %>">
                    <img src="images/after_icon.png" alt="������">
                </a>
            </div>
			-->
        </div>
    
        <div class="right_wrap">
            <div class="search">
                <input type="text" id="search_bar" placeholder="�˻�� �Է��ϼ���" onkeypress="onKeyPress(event)"><input type="button" id="search_button" onclick="search()">
            </div>
            <div class="write">
                <a href="sns_write.jsp"><input type="button" value="�� �ۼ�" id="write_button"></a>
            </div>
            
            <div class="my">
                <div class="member">
                    <h3><font color="#02377E"><%=myid%></font> ���� Ȱ��</h3>
                </div>
                <div class="activity">
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
<%
} catch (Exception e) {
    // ���� ó��: ���� �޽����� ���� �α׿� ���
    e.printStackTrace();  
} finally {
    if (rs != null) {
        try {
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (con != null) {
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>
</body>
</html>
