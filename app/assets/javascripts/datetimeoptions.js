//= require ./luxe

angular.module('luxe')
  .controller('DateTimePickerDemoCtrl',
    function ($scope, $timeout) {
      $scope.dateTimeNow = function() {
      };

      $scope.dateOptions = {
        startingDay: 1,
        showWeeks: false
      };
      $scope.hourStep = 1;
      $scope.minuteStep = 15;

      $scope.timeOptions = {
        hourStep: [1, 2, 3],
        minuteStep: [1, 5, 10, 15, 25, 30]
      };

      $scope.showMeridian = true;
      $scope.timeToggleMode = function() {
        $scope.showMeridian = !$scope.showMeridian;
      };

      $scope.$watch("date", function(value) {
        console.log('New date value:' + value);
      }, true);

      $scope.resetHours = function() {
        $scope.date.setHours(1);
      };
});
