//= require ./luxe

angular.module('luxe').controller('SpaController', [ '$scope', '$timeout', '$http', function ($scope, $timeout, $http) {
    $scope.date = new Date();
    $scope.addScheduleSpaService = function(){

    var payload = {
      service: {
        title: 'Spa Service',
        starts_at_date : $scope.date,
      }
    };

    $http.post('/api/services', payload).then(
      function(response){

        $scope.alert('Spa', 'Your service was scheduled!', payload);
      },
      function(response){
        $scope.alert('Spa', 'FAILED TO SAVE scheduled clean service');
      }
    );
  }

}]);
