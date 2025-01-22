<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	// PostNum ����
    String PostNum = request.getParameter("PostNum");
	String Id = (String) session.getAttribute("sid");
    
	// �����ͺ��̽� ���� ����
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    // �����ͺ��̽� ���� ����
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // �����ͺ��̽� ����
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL ���� �ۼ�
        String query = "SELECT * FROM Post WHERE PostNum = ?";

        // PreparedStatement ��ü ����
        pstmt = con.prepareStatement(query);
        
        // SQL ������ �� ����
        pstmt.setString(1, PostNum);

        // SQL ���� �� ��� �ޱ�
        rs = pstmt.executeQuery();

        // ��� Ȯ��
        if (rs.next()) {
            // ��ȸ�� ���ڵ��� �ʵ� �� ��������
			String BId = rs.getString("BId");
            String BStore = rs.getString("BStore");
            String BName = rs.getString("BName");
            String BAddress = rs.getString("BAddress");
            String BPhone = rs.getString("BPhone");
            String BEmail = rs.getString("BEmail");
            String Title = rs.getString("Title");
            String Category = rs.getString("Category");
            String Type = rs.getString("Type");
            String Personnel = rs.getString("Personnel");
            String Sex = rs.getString("Sex");
            String Age = rs.getString("Age");
            String Ability = rs.getString("Ability");
            String Preferential = rs.getString("Preferential");
            String Period = rs.getString("Period");
            String Day = rs.getString("Day");
            String Time = rs.getString("Time");
            String Pay = rs.getString("Pay");
            String Welfare = rs.getString("Welfare");
            String Etc = rs.getString("Etc");
			String x = rs.getString("x");
			String y = rs.getString("y");

            // ������ �ʵ� ���� ȭ�鿡 ���
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>���� ����</title>
    <link href="postdetail.css" rel="stylesheet" type="text/css">



<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAwsqFhWq9RDEhb0ngWci4q7Yzdx84EOD4&libraries=places"></script>
	<script type="text/javascript">
        var map;
        var markers = [];
        var infoWindows = [];

        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: <%= x %>, lng: <%= y %>},
                zoom: 15
            });
            displayMarkers(map);
        }

        function displayMarkers(map) {
			var marker = new google.maps.Marker({
                            position: {lat: <%= x %>, lng: <%= y %>},
                            map: map
                        });


                        var infoWindow = new google.maps.InfoWindow({
                            content: contentString
                        });

                        marker.addListener('click', (function(infoWindow, marker) {
                            return function() {
                                infoWindow.open(map, marker);
                            };
                        })(infoWindow, marker));

                        markers.push(marker);
		}
</script>
</head>
<body onload="initMap()">
    <div class="container">
        <div class="title">
            <h1><%= Title %></h1>
        </div>
        <div class="information">
            <h2>ȸ�� ����</h2>
            <table>
                <tr>
                    <td>ȸ��/������ :</td>
                    <td><%= BStore %></td>
                </tr>
                <tr>
                    <td>��ǥ�ڸ� :</td>
                    <td><%= BName %></td>
                </tr>
                <tr>
                    <td>ȸ��/���� �ּ� :</td>
                    <td><%= BAddress %></td>
                </tr>
                <tr>
                    <td>��ȭ��ȣ :</td>
                    <td><%= BPhone %></td>
                </tr>
                <tr>
                    <td>�̸��� :</td>
                    <td><%= BEmail %></td>
                </tr>       
            </table>

           <div id="map">���� �ҷ�����</div>

        </div>
		
        <div class="hcondition">
            <h2>���� ����</h2>
            <table>
                <tr>
                    <td>���� ���� �Ⱓ :</td>
                    <td><%= Period %></td>
                </tr>
                <tr>
                    <td>������ :</td>
                    <td><%= Category %></td>
                </tr>
                <tr>
                    <td>��� ���� :</td>
                    <td><%= Type %></td>
                </tr>
                <tr>
                    <td>���� �ο� :</td>
                    <td><%= Personnel %></td>
                </tr>
                <tr>
                    <td>���� :</td>
                    <td><%= Sex %></td>
                </tr>
                <tr>
                    <td>�з� :</td>
                    <td><%= Ability %></td>
                </tr>
                <tr>
                    <td>���� :</td>
                    <td><%= Age %></td>
                </tr>
                <tr>
                    <td>������ :</td>
                    <td><%= Preferential %></td>
                </tr>
                <tr>
                    <td>�ٹ� ���� :</td>
                    <td><%= Day %></td>
                </tr>
                <tr>
                    <td>�ٹ� �ð� :</td>
                    <td><%= Time %></td>
                </tr>
                <tr>
                    <td>�޿� :</td>
                    <td><%= Pay %></td>
                </tr>
                <tr>
                    <td>�����Ļ� :</td>
                    <td><%= Welfare %></td>
                </tr>
                <tr>
                    <td>��Ÿ���� :</td>
                    <td><%= Etc %></td>
                </tr>
            </table>
        </div>
    </div>

<script>
    function goBack() {
        window.history.back();
    }
</script>

</body>
</html>
<%
        } else {
            // ��ȸ�� ���ڵ尡 ���� ��쿡 ���� ó��
            out.println("�Խñ��� ã�� �� �����ϴ�.");
        }

    } catch (SQLException e) {
        // �����ͺ��̽� ���� ó��
        out.println("�����ͺ��̽� ���� �߻�: " + e.getMessage());
        e.printStackTrace();
    } finally {
        // �ڿ� ����
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
