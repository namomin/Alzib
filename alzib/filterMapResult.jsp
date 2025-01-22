<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String Dong = request.getParameter("Dong");
		String[] locationArray = Dong.split(",");
        String X = locationArray[0];
        String Y = locationArray[1];
%>
<html>
<head>
    <title>지도검색 결과</title>

<style>
	@charset "utf-8";

	@font-face {
		font-family: 'GmarketSansMedium';
		src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		font-weight: normal;
		font-style: normal;
	}

	* {
		padding: 0;
		margin: 0 auto;
	}

	a{
		text-decoration: none;
		color: black;
	}


	body{
		font-family: 'GmarketSansMedium', sans-serif;
		margin: 0;
	}

	.wrap{
		margin: 0;
	}

	#map {
		border: 2px solid #689ADE;
		box-shadow: 5px 5px 5px rgba(33, 86, 158, 0.5);
		width: 99%;
		height: 450px;
		margin-top: 20px;
	}

	.fillter_wrap{
		width: 70%;
		margin-top: 25px;
	}

	.menubutton{
		text-align: right;
		padding-right: 5px;
	}

	#list_header{
		border:none;
		width: 99%;
	}

	#list{
		border:none;
		color:#0047A9;
		font-size: 25px;
		font-weight: bold;
	}

	#button{
		border:none;
	}


	.fillter_wrap .menubutton span{
		text-align: left;
		color: #0047A9;
		font-weight: bold;
		font-size: 22px;
		margin-bottom: 5px;
	}

	.fillter_select{
		text-align: center;
	}
	
	.fillter_select table{
		width: 100%;
		text-align: center;
		border-spacing: 0;
		border-top: 2px solid #689ADE;
		border-bottom: 2px solid #689ADE;
		border-left: 2px solid #689ADE;
		border-right: 2px solid #689ADE;
		border-radius: 10px;
	}

	.fillter_select table th{
		text-align: center;
		color: #0047A9;
		border-bottom: 1px solid #689ADE;
		padding: 15px;
	}

	.fillter_select table td{
		text-align: center;
		padding: 20px;
	}

</style>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAwsqFhWq9RDEhb0ngWci4q7Yzdx84EOD4&libraries=places"></script>
    <script type="text/javascript">
        var map;
        var markers = [];
        var infoWindows = [];

        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: 36.8323515, lng: 127.1479648},
                zoom: 17
            });
            displayMarkers();
        }

        function displayMarkers() {
            <% 
                String url = "jdbc:mysql://localhost:3306/alzib";
                String user = "multi";
                String password = "abcd";
                String category = request.getParameter("Category");
                String type = request.getParameter("Type");
                String sex = request.getParameter("Sex");
                String age = request.getParameter("Age");
                String period = request.getParameter("Period");
                String day = "";
                String time = request.getParameter("Time1") + "~" + request.getParameter("Time2");
                String Selector = request.getParameter("Selector");
                if (Selector.equals("요일 지정")) {
                    for (int i = 1; i <= 7; i++) {
                        String dayCheckbox = request.getParameter("day" + i);
                        if (dayCheckbox != null) {
                            day += dayCheckbox + ",";
                        }
                    }
                    if (!day.isEmpty()) {
                        day = day.substring(0, day.length() - 1);
                    }
                } else if (Selector.equals("요일 협의")) {
                    day = "요일 협의";
                }
                double x = 0.0;
                double y = 0.0;
                String BStore = "";
                String PostNum = "";

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(url, user, password);
                    String sql = "SELECT x, y, BStore, PostNum FROM post WHERE Category=? AND Time=? AND Day=? AND Period=? AND Sex=? AND Age=? AND Type=?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, category);
                    pstmt.setString(2, time);
                    pstmt.setString(3, day);
                    pstmt.setString(4, period);
                    pstmt.setString(5, sex);
                    pstmt.setString(6, age);
                    pstmt.setString(7, type);
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                        x = rs.getDouble("x");
                        y = rs.getDouble("y");
                        BStore = rs.getString("BStore");
                        PostNum = rs.getString("PostNum");
            %>
                        var marker = new google.maps.Marker({
                            position: {lat: <%= x %>, lng: <%= y %>},
                            map: map
                        });

                        var contentString = "<div><strong>가게이름: <%= BStore %></strong><br/><a href='postdetail.jsp?PostNum=<%= PostNum %>'>더 자세히</a></div>";

                        var infoWindow = new google.maps.InfoWindow({
                            content: contentString
                        });

                        marker.addListener('click', (function(infoWindow, marker, x, y) {
                    return function() {
                        infoWindow.open(map, marker);
                        map.setCenter({lat: x, lng: y}); // 핑 클릭하면 해당 핑을 중앙으로 두기
                        map.setZoom(19); // 핑 클릭시 확대
                    };
                })(infoWindow, marker, <%= x %>, <%= y %>));
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        }
    </script>
</head>
<body onload="initMap()">
<div class="wrap">

    <div id="map" style="height: 500px; width: 99%;"></div>
	
	<div class=" fillter_wrap">
	<div class="menubutton">
		<table id="list_header">
			<tr>
				<td id="list" align="left">선택한 필터 내용</td>
				<td id="button" align="right"><a href="fillterMap.jsp"><img src="images/menu.png" alt="필터검색"></a></td>
			</tr>
		</table>
	</div>

	<div class="fillter_select">
		<table>
			<tr>
				<th>업직종</th>
				<th>시간</th>
				<th>요일</th>
				<th>기간</th>
				<th>성별</th>
				<th>연령</th>
				<th>고용형태</th>
			</tr>
			<tr>
				<td><%=category%></td>
				<td><%=time%></td>
				<td><%=day%></td>
				<td><%=period%></td>
				<td><%=sex%></td>
				<td><%=age%></td>
				<td><%=type%></td>
			</tr>
		</table>
	</div>
	</div>

</div>
</body>
</html>
