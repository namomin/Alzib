<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Google Maps API</title>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAwsqFhWq9RDEhb0ngWci4q7Yzdx84EOD4&libraries=places"></script>
    <script type="text/javascript">
        var map;
        var geocoder;
        var marker;

        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: 37.5665, lng: 126.9780},
                zoom: 8
            });
            geocoder = new google.maps.Geocoder();
            marker = new google.maps.Marker({
                map: map,
                draggable: true
            });
        }

        function geocodeAddress() {
            var address = document.getElementById('address').value;
            geocoder.geocode({'address': address}, function(results, status) {
                if (status === 'OK') {
                    map.setCenter(results[0].geometry.location);
                    marker.setPosition(results[0].geometry.location);
                    document.getElementById('x').value = results[0].geometry.location.lat();
                    document.getElementById('y').value = results[0].geometry.location.lng();
                } else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        }
    </script>
</head>
<body onload="initMap()">
    <div id="map" style="height: 400px; width: 100%;"></div>
    <input id="address" type="textbox" placeholder="Enter address">
    <input type="button" value="Geocode" onclick="geocodeAddress()">
    <form action="saveCoordinates.jsp" method="post">
        <input type="hidden" id="x" name="x">
        <input type="hidden" id="y" name="y">
        <input type="submit" value="Save Coordinates">
    </form>
</body>
</html>
