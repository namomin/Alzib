<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	// PostNum 설정
    String PostNum = request.getParameter("PostNum");
	String Id = (String) session.getAttribute("sid");
    
	// 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    // 데이터베이스 연결 변수
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 데이터베이스 연결
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL 쿼리 작성
        String query = "SELECT * FROM Post WHERE PostNum = ?";

        // PreparedStatement 객체 생성
        pstmt = con.prepareStatement(query);
        
        // SQL 쿼리에 값 설정
        pstmt.setString(1, PostNum);

        // SQL 실행 및 결과 받기
        rs = pstmt.executeQuery();

        // 결과 확인
        if (rs.next()) {
            // 조회한 레코드의 필드 값 가져오기
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

            // 가져온 필드 값을 화면에 출력
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>공고 내용</title>
    <link href="postdetail.css" rel="stylesheet" type="text/css">


<!--
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC6HzP4mxUfKIntAnU85vf9MJTIiQiMDks&libraries=places"></script>
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
-->
</head>
<body> <!-- onload="initMap()"-->
    <div class="container">
        <div class="title">
            <h1><%= Title %></h1>
        </div>
        <div class="information">
            <h2>회사 정보</h2>
            <table>
                <tr>
                    <td>회사/점포명 :</td>
                    <td><%= BStore %></td>
                </tr>
                <tr>
                    <td>대표자명 :</td>
                    <td><%= BName %></td>
                </tr>
                <tr>
                    <td>회사/점포 주소 :</td>
                    <td><%= BAddress %></td>
                </tr>
                <tr>
                    <td>전화번호 :</td>
                    <td><%= BPhone %></td>
                </tr>
                <tr>
                    <td>이메일 :</td>
                    <td><%= BEmail %></td>
                </tr>       
            </table>
<!--
           <div id="map">지도 불러오기</div>
-->
        </div>
		
        <div class="hcondition">
            <h2>모집 조건</h2>
            <table>
                <tr>
                    <td>모집 마감 기간 :</td>
                    <td><%= Period %></td>
                </tr>
                <tr>
                    <td>업직종 :</td>
                    <td><%= Category %></td>
                </tr>
                <tr>
                    <td>고용 형태 :</td>
                    <td><%= Type %></td>
                </tr>
                <tr>
                    <td>모집 인원 :</td>
                    <td><%= Personnel %></td>
                </tr>
                <tr>
                    <td>성별 :</td>
                    <td><%= Sex %></td>
                </tr>
                <tr>
                    <td>학력 :</td>
                    <td><%= Ability %></td>
                </tr>
                <tr>
                    <td>연령 :</td>
                    <td><%= Age %></td>
                </tr>
                <tr>
                    <td>우대사항 :</td>
                    <td><%= Preferential %></td>
                </tr>
                <tr>
                    <td>근무 요일 :</td>
                    <td><%= Day %></td>
                </tr>
                <tr>
                    <td>근무 시간 :</td>
                    <td><%= Time %></td>
                </tr>
                <tr>
                    <td>급여 :</td>
                    <td><%= Pay %></td>
                </tr>
                <tr>
                    <td>복리후생 :</td>
                    <td><%= Welfare %></td>
                </tr>
                <tr>
                    <td>기타사항 :</td>
                    <td><%= Etc %></td>
                </tr>
            </table>
        </div>
		<a href="post_bossblock.jsp?PostNum=<%=PostNum%>&BId=<%=BId%>"><input type="button" value="지원하기"></a> &nbsp 
		<a href="post_list.jsp"><input type="button" value="돌아가기" id="backbutton"></a>
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
            // 조회된 레코드가 없는 경우에 대한 처리
            out.println("게시글을 찾을 수 없습니다.");
        }

    } catch (SQLException e) {
        // 데이터베이스 오류 처리
        out.println("데이터베이스 오류 발생: " + e.getMessage());
        e.printStackTrace();
    } finally {
        // 자원 해제
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
