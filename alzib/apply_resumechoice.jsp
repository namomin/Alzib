<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<title>이력서 선택</title>
<link href="apply_resumechoice.css" rel="stylesheet" type="text/css">   
</head>
<body>

<%


try {
    String PostNum = request.getParameter("PostNum");
    String BId = request.getParameter("BId");
    String myid = (String) session.getAttribute("sid");

    // 세션을 확인하고 없으면 로그인 페이지로 리디렉션
    if (myid == null) {
        response.sendRedirect("login.html");
        return; // 로그인 페이지로 리디렉션했으므로 더 이상 코드를 실행하지 않습니다.
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
  // 모달 열기
  function openModal(RId, BId) {
    document.getElementById("myModal").style.display = "flex";
    document.getElementById("applyButton").setAttribute("onclick", "redirectToAnotherPage(" + RId + ", '" + BId + "')");
  }

  // 모달 닫기
  function closeModal() {
    document.getElementById("myModal").style.display = "none";
  }

  // 예 버튼 클릭 시 다른 페이지로 이동
  function redirectToAnotherPage(RId, BId) {
    var AId = '<%= session.getAttribute("sid") %>';
    window.location.href = "applyResult.jsp?RId=" + RId + "&PostNum=<%= PostNum %>&BId=" + BId + "&AId=" + AId;
  }
</script>

<div id="myModal" class="modal">
  <div class="modal-content">
    <p><br>해당 이력서로 지원하시겠습니까?<br><br></p>
    <button id="applyButton" class="btn btn-yes">지원하기</button>
    <button class="btn btn-no" onclick="closeModal()">취소</button>
  </div>
</div>        

<div class="wrap">
<div class="board_wrap">
    <div class="header">
		<h2>저장된 이력서</h2>
		<a href="mypageAlba.jsp"><input type="button" id="mypage" value="이력서 작성하러 가기"></a>
    </div>
    <div class="table_resume">
        <table>
            <tr>
                <th>제목</th>
                <th>지원</th>
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
                    <button onclick="openModal(<%=RId%>, '<%=BId%>')">선택</button>
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
