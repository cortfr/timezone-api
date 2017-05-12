var app = angular.module('LookupTZ', []);

app.controller('formController', function($scope, $http) {

  $scope.data = {
    zipcode: "default"
  };

  $scope.submitForm = function() {
    console.log("posting data....", $scope.zipcode);
    //$http.post('http://...', JSON.stringify(data)).success(function(){/*success callback*/});
  };

});
