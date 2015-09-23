//= require ./luxe

angular.module('luxe').controller('WakeMeController', [ '$scope', '$timeout', '$http', function ($scope, $timeout, $http) {
    $scope.date = new Date();
    $scope.addScheduleWakeUpService = function(){

    var payload = {
      service: {
        starts_at_date : $scope.date,
      }
    };

    $http.post('/api/services', payload).then(
      function(response){
        $scope.alert('WakeMe', 'Your service was scheduled!', payload);
      },
      function(response){
        $scope.alert('WakeMe','FAILED TO SAVE scheduled clean service');
      }
    );
  }

}]);
