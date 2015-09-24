//= require ./luxe
angular.module('luxe').controller('FeedMeController', [ '$scope', '$timeout', '$http', function ($scope, $timeout, $http) {

  $scope.date = new Date;
  $scope.food_items = [];


  $scope.thumbnail_selected = function(thumbnail){

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
			data: "Cheeseburger",
			src: "https://upload.wikimedia.org/wikipedia/commons/5/55/Atelopus_zeteki1.jpg",
			selected: false,
		},
		{
			data: "Fries",
			src: "http://www.amnh.org/var/ezflow_site/storage/images/media/amnh/images/frog/311113-1-eng-US/frog_dynamic_lead_slide.jpg",
			selected: false,
		},
		{
			data: "Ice Cream",
			src: "https://s3.amazonaws.com/EarthwatchMedia/GalleryImages/7-mahony-australias-vanishing-frogs-c-ross-knowles-h-6_1178_onwebsite_5058.jpg",
			selected: false,
		},
	];

	$scope.addScheduleFoodService = function(foodData){
    var date = $scope.date;
    var payload = {
    	service: {
        title: 'Feed Me',
  			starts_at_date : date

    	}
    };

		$http.post('/api/services', payload).then(
      function(response){
        $scope.alert('FeedMe', 'Your service was scheduled for '+date);
        debugger;
      },
      function(response){
        $scope.alert('FeedMe', 'FAILED TO SAVE scheduled food service');
      }
    );
	}

}]);
