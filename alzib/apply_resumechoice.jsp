<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<title>�̷¼� ����</title>
<link href="apply_resumechoice.css" rel="stylesheet" type="text/css">   
</head>
<body>

<%


try {
    String PostNum = request.getParameter("PostNum");
    String BId = request.getParameter("BId");
    String myid = (String) session.getAttribute("sid");

    // ������ Ȯ���ϰ� ������ �α��� �������� ���𷺼�
    if (myid == null) {
        response.sendRedirect("login.html");
        return; // �α��� �������� ���𷺼������Ƿ� �� �̻� �ڵ带 �������� �ʽ��ϴ�.
    }

    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    String jsql = "SELECT * FROM resume WHERE AId = ?";
    PreparedStatement pstmt = con.prepareStatement(jsql);
    pstmt.setString(1, myid);
    ResultSet rs = pstmt.executeQuery();
%>

<script>
  // ��� ����
  function openModal(RId, BId) {
    document.getElementById("myModal").style.display = "flex";
    document.getElementById("applyButton").setAttribute("onclick", "redirectToAnotherPage(" + RId + ", '" + BId + "')");
  }

  // ��� �ݱ�
  function closeModal() {
    document.getElementById("myModal").style.display = "none";
  }

  // �� ��ư Ŭ�� �� �ٸ� �������� �̵�
  function redirectToAnotherPage(RId, BId) {
    var AId = '<%= session.getAttribute("sid") %>';
    window.location.href = "applyResult.jsp?RId=" + RId + "&PostNum=<%= PostNum %>&BId=" + BId + "&AId=" + AId;
  }
</script>

<div id="myModal" class="modal">
  <div class="modal-content">
    <p><br>�ش� �̷¼��� �����Ͻðڽ��ϱ�?<br><br></p>
    <button id="applyButton" class="btn btn-yes">�����ϱ�</button>
    <button class="btn btn-no" onclick="closeModal()">���</button>
  </div>
</div>        

<div class="wrap">
<div class="board_wrap">
    <div class="header">
		<h2>����� �̷¼�</h2>
		<a href="mypageAlba.jsp"><input type="button" id="mypage" value="�̷¼� �ۼ��Ϸ� ����"></a>
    </div>
    <div class="table_resume">
        <table>
            <tr>
                <th>����</th>
                <th>����</th>
            </tr>

<%
    while(rs.next()){
        String RTitle =  rs.getString("RTitle");
		String AName = rs.getString("AName");
        int RId =  rs.getInt("RId");
%>

            <tr>
                <td>
                    <a href="resumedetailview.jsp?RId=<%=RId%>" target="_blank"><%=RTitle%></a>
                </td>
                <td>
                    <button onclick="openModal(<%=RId%>, '<%=BId%>')">����</button>
                </td>
            </tr>
<%
    }   
%>
        </table>
    </div>
</div>
</div>

<%
    } catch (Exception e) {
        out.println(e);
}
%>

</body>
</html>
