var app = angular.module('LookupTZ', []);

app.controller('formController', function($scope, $http) {

  // initialize map...
  var map = L.map('map').fitWorld();
  var osmMapnikBasemap = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  	maxZoom: 19,
  	attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
  }).addTo(map);
  map.locate({setView: true, maxZoom: 16});

  // form submit...
  $scope.submitForm = function() {
    console.log($scope)
    var data = {
      zipcode: $scope.zipcode
    };

    $http.post('/zipcodes/find', JSON.stringify(data)).then(function(resp){

      var tzName = resp.data.tz_name;
      var zipcode = resp.data.zipcode;

      console.log(resp);

      // show results on map...
      if (typeof(zipcode.lat) !== 'undefined' && typeof(zipcode.lng) !== 'undefined') {
        map.setView([zipcode.lat, zipcode.lng], 14);
        // invoke popup...
        var popupContent = '<b>Zipcode:</b> ' + zipcode.zipcode + '<br />';
        popupContent += '<b>ActiveSupport TimeZone</b>:<br />' + tzName + ' (UTC' + zipcode.utc_offset + ')<br />';
        var marker = L.marker([zipcode.lat, zipcode.lng]).addTo(map).bindPopup(popupContent).openPopup();
      }

    }, function(resp){
      $('.help-block').html(resp.data.errors);
      $('.form-group').addClass('has-error');
    });

    return false;
  };

});
