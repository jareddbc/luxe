//= require ./luxe

angular.module('luxe').controller('ThumbnailSelectorController', function ($scope, $timeout) {

	$scope.selectOption = function(option){
		option.selected = !option.selected;
		if($scope.thumbnail_selected){
		  $scope.thumbnail_selected(option);
		}
	};
});
