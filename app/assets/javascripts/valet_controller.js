//= require ./luxe

angular.module('luxe').controller('ValetController', [ '$scope', '$timeout', '$http', function ($scope, $timeout, $http) {
    $scope.date = new Date();
    $scope.addScheduleValet = function(){

    var payload = {
      service: {
        title: 'Valet',
        starts_at_date : $scope.date,
      }
    };

    $http.post('/api/services', payload).then(
      function(response){

        $scope.alert('Valet', 'Your service was scheduled!', payload);
        console.log(payload);
      },
      function(response){
        $scope.alert('Valet', 'FAILED TO SAVE scheduled valet service');
      }
    );
  }

}]);
