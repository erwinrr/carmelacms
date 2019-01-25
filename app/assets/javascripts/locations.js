function initMap(locations) {
  // var locations = [
  //     ['DESCRIPTION', 41.926979, 12.517385, 3],
  //     ['DESCRIPTION', 41.914873, 12.506486, 2],
  //     ['DESCRIPTION', 61.918574, 12.507201, 1]
  // ];

  window.map = new google.maps.Map(document.getElementById('map'), {
      mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  var infowindow = new google.maps.InfoWindow();

  var bounds = new google.maps.LatLngBounds();

  for (i = 0; i < locations.length; i++) {
      marker = new google.maps.Marker({
          position: new google.maps.LatLng(locations[i][1], locations[i][2]),
          map: map
      });

      bounds.extend(marker.position);

      google.maps.event.addListener(marker, 'click', (function (marker, i) {
          return function () {
              infowindow.setContent(locations[i][0]);
              infowindow.open(map, marker);
          }
      })(marker, i));
  }

  map.fitBounds(bounds);

  var listener = google.maps.event.addListener(map, "idle", function () {
      map.setZoom(14);
      google.maps.event.removeListener(listener);
  });
}

