//= require ./luxe

angular.module('luxe').controller('CleanMeController', [ '$scope', '$timeout', '$http', function ($scope, $timeout, $http) {
    $scope.date = new Date();
    $scope.addScheduleCleanService = function(){

    var payload = {
      service: {
        starts_at_date : $scope.date,
      }
    };

    $http.post('/api/services', payload).then(
      function(response){

        $scope.alert('CleanMe', 'Your service was scheduled!', payload);
        console.log(payload);
      },
      function(response){
        $scope.alert('CleanMe', 'FAILED TO SAVE scheduled clean service');
      }
    );
  }

}]);
