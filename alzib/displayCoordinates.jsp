<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
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

body{
	font-family: 'GmarketSansMedium', sans-serif;
	margin: 0;
}

.wrap{
    width: 1000px;
    margin: 100px auto;	
}

.postlist a{
	text-decoration: none;
	color: black;
}

.postlist a:hover{
	color: #CADCF4;
}

#map {
	border: 2px solid #689ADE;
	box-shadow: 5px 5px 5px rgba(33, 86, 158, 0.5);
	width: 99%;
	height: 500px;
	margin-top: 20px;
}

.menubutton{
	text-align: right;
	margin-top: 25px;
}


.border_wrap{
	width: 70%;
}

.border_wrap table{
	width: 100%;
	text-align: center;
	border-spacing: 0;
	border-top: 2px solid #689ADE;
	border-bottom: 1px solid #689ADE;
}

.border_wrap th{
	border-bottom: 2px solid #689ADE;
	padding: 20px;
	color: #0047A9;
}

.border_wrap td{
	border-bottom: 1px solid #689ADE;
	padding: 20px;
}

.page{
	margin-bottom: 35px;
	padding-top: 15px;
	text-align: center;
}

.page span{
	font-size: 17px;
	
}

#present{
	color:#0047A9;
	font-weight:bold;
}

#pagenumber a:hover{
	color: #CADCF4;
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

.filter-item {
	margin-top: 10px;
	text-align: center;
}

.filter-container {
  border: 2px solid #689ADE;
  height: 510px;
  margin-bottom: 10px;
  box-shadow: 5px 5px 5px rgba(33, 86, 158, 0.5);
  font-family: 'GmarketSansMedium';
  color: black;
  width: 400px;
  position: fixed;
  top: 20px;
  right: 20px; /* 오른쪽에서의 거리를 조절하려면 right 속성을 조정하세요 */
  display: none;
  flex-direction: column;
  align-items: flex-end; /* 오른쪽 정렬을 위해 align-items를 flex-end로 조정합니다 */
  background: rgba(255, 255, 255, 0.9);
  z-index: 999;
}

#filter-btn {
	background-color: transparent;
	background-image: url("images/menu.png");
	z-index: 9999;
	background-repeat: no-repeat;
	width: 50px;
	height: 50px;
	border: none;
	cursor: pointer;
	text-indent: -9999px; /* 텍스트를 화면 밖으로 숨김 */
	vertical-align: middle;
	margin-right: 10px;
	margin-top: 10px;
}

input[type="text"]{
	background-color: white;
	margin: 10px;
	padding: 5px;
	font-size: 15px;
	outline: none;
	border: 1px solid #5475A2;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	vertical-align: middle;
	font-family: 'GmarketSansMedium', sans-serif;
}

select {
	border: 2px solid #689ADE;
	height: 40px;
	padding: 10px;
	box-shadow: 5px 5px 5px rgba(33, 86, 158, 0.5);
	font-family: 'GmarketSansMedium';
}

input[type="text"], input[type="epkey"] {
	border: 2px solid #689ADE;
	height: 20px;
	box-shadow: 5px 5px 5px rgba(33, 86, 158, 0.5);
	padding: 8px;
	font-size: 16px;
	font-family: 'GmarketSansMedium';
}

#in {
	background-color: #689ADE;
	color: white;
	width: 60px;
	padding: 0px;
	border: none;
	cursor: pointer;
	margin-top: 10px;
	margin-bottom: 10px;	
	font-size: 20px;
	box-shadow: 5px 5px 5px rgba(33, 86, 158, 0.5);
	font-family: 'GmarketSansMedium';
	display: block;
	margin: 20px auto;
}

#in:hover{
	background-color: #CADCF4;
	color: black;
	font-family: 'GmarketSansMedium';
}

#map {
	font-family: 'GmarketSansMedium';
	border: 2px solid #689ADE;
	box-shadow: 5px 5px 5px rgba(33, 86, 158, 0.5);
}

#now {
	background-color: transparent;
	background-image: url("images/now.png");
	z-index: 9999;
	background-repeat: no-repeat;
	width: 50px;
	height: 50px;
	border: none;
	cursor: pointer;
	text-indent: -9999px; /* 텍스트를 화면 밖으로 숨김 */
	vertical-align: middle;
	margin-top: 10px;
}

		.nav{
			margin-left: 10px;
			width: 20%;
			border-radius: 10px;
			border: 1px solid #689ADE;
			padding: 15px;
			color: #689ADE;
		}

		a{
			color: #689ADE;
			text-decoration: none;
		}

		a:hover{
			color:#CADCF4;
		}
</style>

    <title>Google Maps API</title>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC6HzP4mxUfKIntAnU85vf9MJTIiQiMDks&libraries=places"></script>
    <script type="text/javascript">
    var map;
    var markers = [];
    var infoWindows = [];

    function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 36.8323515, lng: 127.1479648}, // 좌표를 중심으로 수정
        zoom: 15
    });
    displayMarkers();
}


    function displayMarkers() {
        <% request.setCharacterEncoding("UTF-8");
        String url = "jdbc:mysql://localhost:3306/alzib";
        String user = "multi";
        String password = "abcd";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM post";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                double x = rs.getDouble("x");
                double y = rs.getDouble("y");
                String BStore = rs.getString("BStore");
                String PostNum = rs.getString("PostNum");
        %>
                var marker = new google.maps.Marker({
                    position: {lat: <%= x %>, lng: <%= y %>},
                    map: map
                });

                var contentString = "<div><strong>가게이름: <%= BStore %></strong><br/><a href='postmapdetail.jsp?PostNum=<%= PostNum %>'>더 자세히</a></div>";

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

                markers.push(marker);
        <% }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    }
</script>
</head>
<body onload="initMap()">
<div id="wrap">
<div class="nav">
		<span><a href="post_list.jsp">알바 검색</a> > <a href="displayCoordinates.jsp">지도 검색</a></span>
	</div>
<div id="map">
	<table align="right">
		<th>
          <button id="now">현재 위치</button>
        </th>
        <th>
          <button id="filter-btn">필터</button>
        </th>
      </table>
   
</div>

<%
    // PostNum 설정 
    String Id = (String) session.getAttribute("sid");
    
    // 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    // 데이터베이스 연결 변수
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 페이지네이션을 위한 변수
    int currentPage = 1; // 기본 페이지는 1
    int recordsPerPage = 10; // 페이지당 게시글 수
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    // 총 게시글 수
    int totalPosts = 0;
    int totalPages = 0;

    try {
        // 데이터베이스 연결
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL 쿼리 작성: 총 게시글 수 조회
        String countQuery = "SELECT COUNT(*) AS count FROM Post";
        pstmt = con.prepareStatement(countQuery);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalPosts = rs.getInt("count");
        }

        // 총 페이지 수 계산
        totalPages = (int) Math.ceil((double) totalPosts / recordsPerPage);

        // SQL 쿼리 작성: 현재 페이지에 표시될 게시글 목록 조회
        int start = (currentPage - 1) * recordsPerPage;
        String query = "SELECT * FROM Post ORDER BY PostNum DESC LIMIT ?, ?";
        pstmt = con.prepareStatement(query);
        pstmt.setInt(1, start);
        pstmt.setInt(2, recordsPerPage);
        rs = pstmt.executeQuery();
%>

<div class="postlist">

	<div class="border_wrap">
	<div class="menubutton">
		<table id="list_header">
			<tr>
				<td id="list" align="left">최신 공고</td>
				<td id="button" align="right"><a href="fillterMap.jsp"><img src="images/menu.png" alt="필터검색"></a></td>
			</tr>
		</table>
	</div>
		<table>
			<tr>
				<th>기업/점포명</th>
				<th>공고제목</th>
				<th>근무시간</th>
				<th>급여</th>
			</tr>

<%
                    while (rs.next()) {
                        String PostNum = rs.getString("PostNum");
						String BStore =rs.getString("BStore");
                        String Title = rs.getString("Title");
                        String Day = rs.getString("Day");
                        String Time = rs.getString("Time");
						String Pay = rs.getString("Pay");
%>
		
			<tr>
				<td>
				<a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=BStore%></a>
				</td>
				<td>
					<a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Title%></a>
				</td>
				<td>
					<a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Day%> / <%=Time%></a>
				</td>
				<td>
					<a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Pay%></a>
				</td>
			</tr>
		
<%
	}
%>
		</table>
	</div>	

	<div class="page">
	<%
                    // 이전 페이지
                    int prevPage = currentPage > 1 ? currentPage - 1 : 1;
                    out.println("<a href='?currentPage=" + prevPage + "'> < </a>");

                    // 페이지 번호 표시
                    for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) {
                            out.println("<span class='active'>" + i + "</span>");
                        } else {
                            out.println("<a href='?currentPage=" + i + "'>" + i + "</a>");
                        }
						out.println("&nbsp;");
                    }

                    // 다음 페이지
                    int nextPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                    out.println("<a href='?currentPage=" + nextPage + "'> > </a>");
                %>

	</div>
</div>

</div>

<script>
  // 필터 코드
  document.getElementById('filter-btn').addEventListener('click', function () {
    var filterContainer = document.querySelector('.filter-container');
    filterContainer.style.display = filterContainer.style.display === 'none' ? 'block' : 'none';
  });

  function applyFilters() {
    // Your filter application logic goes here
  }
</script>
<script>
        // 10세부터 80까지 나오는 코드
        var ageSelect = document.getElementById('age');

        for (var i = 10; i <= 80; i++) {
            var option = document.createElement('option');
            option.value = i;
            option.text = i + '세';
            ageSelect.add(option);
        }
</script>
</body>
</html>
<%
    } catch (SQLException e) {
        // SQL 오류 처리
        e.printStackTrace();
    } finally {
        // 연결 해제
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>