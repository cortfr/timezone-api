var app = angular.module('LookupTZ', []);

app.controller('formController', function($scope, $http) {

  // initialize map...
  var map = L.map('map').fitWorld();
  var osmMapnikBasemap = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  	maxZoom: 19,
  	attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
  }).addTo(map);
  map.locate({setView: true, maxZoom: 16});

  $scope.submitForm = function() {
    console.log("posting data....", $scope.zipcode);
    //$http.post('http://...', JSON.stringify(data)).success(function(){/*success callback*/});
    return false;
  };

});
