//= require ./luxe

angular.module('luxe').controller('CleanMeController', [ '$scope', '$timeout', '$http', function ($scope, $timeout, $http) {
  $scope.date = new Date; // initial date
  console.log('DATE:', $scope.date);
  $scope.addScheduleCleanService = function(cleanData){

    var date = $scope.date;

    var payload = {
      service: {
        title: 'Room Cleaning',
        starts_at_date: date,
      }
    };

    $http.post('/api/services', payload).then(
      function(response){
        $scope.alert('CleanMe', 'Your service was scheduled for '+date);
      },
      function(response){
        $scope.alert('CleanMe', 'FAILED TO SAVE scheduled clean service');
      }
    );
  }

}]);
