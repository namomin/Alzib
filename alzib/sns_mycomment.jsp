<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>���� �� ���</title>
    <link href="sns_mycomment.css" rel="stylesheet" type="text/css">
 <!--  
	<script type="text/javascript">
        function showDeletedMessage() {
            alert("�ش� �Խñ��� �����Ǿ����ϴ�.");
        }
    
	</script>
--> 
</head>
<body>
<div class="wrap">
    <div class="wrap2">
        <h2>���� �ۼ��� ���</h2>
        <div class="table_wrap">
            <table>
                <th><a href="sns_mywrite.jsp">�ۼ���</a></th>
                <th><a href="sns_mycomment.jsp"><font color="#0E448F">�ۼ����</font></a></th>
				<th><a href="sns_myscrap.jsp">��ũ��</a></th>
            </table>

            <% try {

                String myid = (String) session.getAttribute("sid");

				if (session.getAttribute("sid") == null) {
				response.sendRedirect("login.jsp");
				}

                String DB_URL="jdbc:mysql://localhost:3306/alzib";
                String DB_ID="multi";
                String DB_PASSWORD="abcd";

                Class.forName("org.gjt.mm.mysql.Driver");
                Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                String jsql = "select * from comment where CWId = ? ORDER BY Cdate DESC";
                PreparedStatement pstmt = con.prepareStatement(jsql);
                pstmt.setString(1, myid);

                ResultSet rs = pstmt.executeQuery();

                boolean hasComments = false; // ����� �ִ��� ���θ� �����ϴ� ����

                while(rs.next()){
                    hasComments = true; // ����� �ϳ��� ������ true�� ������
                    int CId =  rs.getInt("CId");
                    int SId =  rs.getInt("SId");
                    String CWId =  rs.getString("CWId");
                    String CText = rs.getString("CText");
                    String Cdate = rs.getString("Cdate");

                    //sns table�� Title �ҷ�����
                    String title = "";
                    String sql = "SELECT Title FROM sns WHERE SId = ?";
                    PreparedStatement pstmtTitle = con.prepareStatement(sql);
                    pstmtTitle.setInt(1, SId);
                    ResultSet rsTitle = pstmtTitle.executeQuery();
                    if(rsTitle.next()) {
                        title = rsTitle.getString("Title");
                    }
            %>
            <div class="detailview">
                <% if (title.equals("")) { %>
                    <a href="#" onclick="showDeletedMessage(); return false;">
                <% } else { %>
                    <a href="sns_detailview.jsp?SId=<%=SId%>">
                <% } %>

                <table>
                    <tr>
                        <% if (title.equals("")) { %>
                            <td><font color="#CADCF4">[ �Խñ��� �����Ǿ����ϴ� ]</font></td>
                        <% } else { %>
                            <td><font color="#0047A9">[<%=title%>]</font></td>
                        <% } %>
                    </tr>
                    <tr><td><h3>�� <%=CText%></h3></td></tr>
                    <tr>
                        <td id="date"><%=Cdate%></td>
                        <td id="font">
                            <a href="sns_commentdelete.jsp?CId=<%=CId%>">����</a>
                        </td>
                    </tr>
                </table>
                </a>
            </div>

            <% }
                if (!hasComments) { // ����� ���� ���
            %>
            <script type="text/javascript">
                showDeletedMessage(); // �Խñ� ���� �˸�â
            </script>
            <% }
            } catch (Exception e) {
                out.println(e);
            }
            %>
        </div>
        <br><br>
        <center>
            <a href="snsmain.jsp"><input type="button" value="���ư���"></a>
        </center>
    </div>  
</div>
</body>
</html>
