var map = L.map("map", { zoomControl: false }).setView([34.95, -104], 5);

// create the sidebar instance and add it to the map
var sidebar = L.control
  .sidebar({ container: "sidebar", autopan: true })
  .addTo(map)
  .open("home");

L.control
  .zoom({
    position: "topright",
  })
  .addTo(map);

var osm = new L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png", {
  attribution:
    'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
}).addTo(map);


fetch("https://api.npoint.io/df5b4d68eb317e6b4d00", {
  method: "GET",
})
  .then((response) => response.json())
  .then((json) => {
    
    function onEachFeature(feature, layer) {
        layer.on('click', function(e) {
        
        $("#case").html(feature.properties.Case);
        $("#court").html(feature.properties.Court);
        $("#terms").html(feature.properties.terms);
        $("#romero").html(feature.properties.romero);
        });
    }

    var gavelIcon = L.icon({
        iconUrl: "assets/gavel.png",
        iconSize: [25, 25], // size of the icon
        iconAnchor: [22, 94], // point of the icon which will correspond to marker's location
        popupAnchor: [-3, -76], // point from which the popup should open relative to the iconAnchor
      });

    var markers = L.markerClusterGroup();

    var cases = L.geoJSON(json, {
        onEachFeature: onEachFeature,
        pointToLayer: function(feature, latlng){
            return L.marker(latlng,{icon: gavelIcon});
          }
      }).addTo(map);



    // json.features.forEach(function (feature) {
    //   console.log();
    //   markers.addLayer(
    //     L.marker(
    //       [feature.geometry.coordinates[1], feature.geometry.coordinates[0]],
    //       { icon: gavelIcon }
    //     ).bindPopup(
    //       "<b>Case: </b>" +
    //         feature.properties.Case +
    //         "<br>" +
    //         "<b>Court: </b>" +
    //         feature.properties.Court +
    //         "<br>" +
    //         "<b>Key terms from case: </b>" +
    //         feature.properties.terms +
    //         "<br>" +
    //         "<b>How <i>Weinberg v. Romero-Barcelo</i> was cited in this case: </b>" +
    //         feature.properties.romero
    //     )
    //   );
    // });
    // map.addLayer(markers);
  })
  .addTo(map);


document.getElementById("case-text").innerHTML+= "new content"
