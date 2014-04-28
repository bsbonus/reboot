
@rebootme.controller 'ShowCategoryCtrl', ['$scope', '$location', '$routeParams', '$http', ($scope, $location, $routeParams, $http) ->
  catId = $routeParams.categoryId
  key = '7372106c1e2516b3a1b52403f6c1f20'
  groups = "http://api.meetup.com/find/groups?page=20&sig_id=9849582&category=#{catId}&sig=3c324d1cf023d2f88f7df1844bc0bc92a038ac5b&key=#{key}&callback=JSON_CALLBACK"
  $http.jsonp(groups).success((data) ->
    console.log data
    $scope.groups = data.data
  )

  $scope.categoryId = $routeParams.categoryId
]
