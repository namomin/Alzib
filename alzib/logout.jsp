<%@ page contentType="text/html;charset=UTF-8" %>
<%
    session.invalidate();    //  ���Ǽ����� ��ȿȭ��Ŵ
    response.sendRedirect("index.html");     //  <jsp:forward page="index.html"/>�� ������ �ǹ�
%>