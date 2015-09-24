//= require ./luxe
angular.module('luxe').controller('SpaController', [ '$scope', '$timeout', '$http', function ($scope, $timeout, $http) {
    $scope.date = new Date;
    $scope.spa_services = [];

  $scope.thumbnail_selected = function(thumbnail){
     console.log(thumbnail);
  }

  function build_items_list(){
     var items = [];
     for(var i = 0; i < $scope.available_thumbnails.length; i++){
       if($scope.available_thumbnails[i].selected){
         items.push($scope.available_thumbnails[i].data);
       }
     }
     return items;
  }

  $scope.available_thumbnails = [
    {
      data: "Massage",
      src: "http://oasismassagekaty.com/wp-content/uploads/2014/05/massage1.jpg",
      selected: false,
    },
    {
      data: "Facial",
      src: "http://static1.squarespace.com/static/5111ce01e4b0e92fdd98def7/t/52683c55e4b02ae7c37ce382/1360567757761/img-facial-therapies-3.jpg",
      selected: false,
    },
    {
      data: "Rose Bath",
      src: "https://s-media-cache-ak0.pinimg.com/736x/73/8f/75/738f757292b289076c5b3e21296c456f.jpg",
      selected: false,
    },
    {
      data: "Manicure",
      src: "http://s3.amazonaws.com/brandrepup/note_attachments/32056/3f1ada57d96438412dd2409522778d63362bea97/original/Nail_Services.jpg?1401896372",
      selected: false,
    }
  ];
  $scope.addScheduleSpaService = function(){
    var date = $scope.date;
    var payload = {
      service: {
        title: 'Spa Service',
        starts_at_date : date,
      }
    };
    $http.post('/api/services', payload).then(
      function(response){
        $scope.alert('Spa', 'Your service was scheduled for '+date);
      },
      function(response){
        $scope.alert('Spa', 'FAILED TO SAVE scheduled spa service');
      }
    );
  }

}]);
