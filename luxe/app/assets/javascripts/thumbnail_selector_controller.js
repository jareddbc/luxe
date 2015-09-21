//= require ./luxe

angular.module('luxe').controller('ThumbnailSelectorController', function ($scope, $timeout) {

	$scope.selectOption = function(option){
		option.selected = !option.selected;
	};

	// this feels wrong to Jared
	$scope.$parent.foods = $scope.foods = [
		{
			src: "https://upload.wikimedia.org/wikipedia/commons/5/55/Atelopus_zeteki1.jpg",
			selected: false,
		},
		{
			src: "http://www.amnh.org/var/ezflow_site/storage/images/media/amnh/images/frog/311113-1-eng-US/frog_dynamic_lead_slide.jpg",
			selected: false,
		},
		{
			src: "https://s3.amazonaws.com/EarthwatchMedia/GalleryImages/7-mahony-australias-vanishing-frogs-c-ross-knowles-h-6_1178_onwebsite_5058.jpg",
			selected: false,
		},
	];


});