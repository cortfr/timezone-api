var app = angular.module('LookupTZ', [])

app.controller('testConsoleController', function($scope, $http) {

  // init...
  // initialize map...
  var map = L.map('map').fitWorld();
  map.zoomControl.setPosition('bottomleft');
  var osmMapnikBasemap = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  	maxZoom: 19,
  	attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
  }).addTo(map);
  map.locate({setView: true, maxZoom: 16});

  // maps zipcode...
  $scope.mapZipcode = function(map, tzName, zipcode) {
    if (typeof(zipcode.lat) !== 'undefined' && typeof(zipcode.lng) !== 'undefined') {
      map.setView([zipcode.lat, zipcode.lng], 14);
      // invoke popup...
      var popupContent = '<b>Zipcode:</b> ' + zipcode.zipcode + '<br />';
      popupContent += '<b>ActiveSupport Time Zone</b>:<br />' + tzName + ' (UTC' + zipcode.utc_offset + ')<br />';
      var marker = L.marker([zipcode.lat, zipcode.lng]).addTo(map).bindPopup(popupContent).openPopup();
    }
  };

  // shows validation errors...
  $scope.showValidationErrors = function(msg) {
    if (typeof(msg) !== 'undefined') {
      $('.help-block').html(msg);
    }
    $('.input-form-group').addClass('has-error');
  };

  // handles form submit...
  $scope.submitForm = function(isValid) {

    $('.help-block').empty();
    $('.input-form-group').removeClass('has-error');

    if (isValid) {
      $http.post('/zipcodes/find', JSON.parse($scope.requestBody)).then(function(resp){

        $('#requestResponseInput').val(JSON.stringify(resp));
        var tzName = resp.data.tz_name;
        var zipcode = resp.data.zipcode;
        $scope.mapZipcode(map, tzName, zipcode);

      }, function(resp){

        console.log(resp)

        $('#requestResponseInput').val(JSON.stringify(resp));
        $scope.showValidationErrors();

      });
    } else {
      $scope.showValidationErrors('Request body cannot be blank');
    }

    return false;
  };

});
