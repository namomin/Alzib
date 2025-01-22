<%@ page contentType="text/html; charset=utf-8" %> <!-- 문자 인코딩 설정 -->

<%@ page import="java.sql.*" %>

<%
boolean isExist = false;

try {
    String DB_URL="jdbc:mysql://localhost:3306/alzib";  
    String DB_ID="multi"; 
    String DB_PASSWORD="abcd"; 
     
    Class.forName("org.gjt.mm.mysql.Driver");  
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
    
    String id = request.getParameter("id"); // id로 변경
    
    String jsql = "select * from alba where aId = ?";   
    PreparedStatement pstmt  = con.prepareStatement(jsql);
    pstmt.setString(1, id);

    ResultSet rs = pstmt.executeQuery();  
    
    if(rs.next()) {
        isExist = true;
    } else {
        isExist = false;
    }

} catch (Exception e) {
    out.println(e);
}
%>

<script language="javascript">
function sendCheckValue() {
    opener.newMem.idCheckType.value="Checked";
    window.close();
}
</script>

<html>
<head>
<title>사용자 ID 중복 검사</title>
<meta charset="utf-8"> <!-- 문자 인코딩 설정 -->
</head>
<body bgcolor="#ffffff">
<br>
<table width="228" border="0" cellspacing="1" cellpadding="3" height="50" style="font-size:10pt;font-family:맑은 고딕">
    <tr>
        <td height="25" align=center >
          ID:  <%=request.getParameter("id")%>
        </td>
    </tr>
    
    <tr>
        <td height="25" align=center>
  <%  
    if(isExist) { 
        out.println("이미 존재하는 ID입니다.");
    } else {
        out.println("사용 가능한 ID입니다. ");
    }
  %>
        </td>
    </tr>
</table>
</body>
</html>
