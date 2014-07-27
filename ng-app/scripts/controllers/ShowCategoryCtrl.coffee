@rebootme.controller 'ShowCategoryCtrl', ['$scope', '$location', '$routeParams', '$http', ($scope, $location, $routeParams, $http) ->
  catId = $routeParams.categoryId
  key = '7372106c1e2516b3a1b52403f6c1f20'
  groups = "http://api.meetup.com/find/groups?page=20&sig_id=9849582&category=#{catId}&sig=3c324d1cf023d2f88f7df1844bc0bc92a038ac5b&key=#{key}&callback=JSON_CALLBACK"
  $http.jsonp(groups).success((data) ->
    $scope.meetupGroups = [[]]
    count = 0
    for category, index in data.data
      if index % 4 is 0 and index != 0
        count += 1
        $scope.meetupGroups[count] = []
        $scope.meetupGroups[count][index % 4 - 1] = category
      else if index % 4 isnt 0
        $scope.meetupGroups[count][index % 4 - 1] = category
    $scope.groups = data.data
    $scope.setMarkers()
    console.log $scope.groups
  )

  $scope.categoryId = $routeParams.categoryId

  $scope.getLocation = ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition($scope.setCoords)
      $scope.map =
        center:
          latitude: 34
          longitude: -116
        zoom: 13
    else
     alert('Unable to use geolocation. Upgrade your browser! Using Default location.')

  $scope.setMarkers = ->
    $scope.markerSet = []
    for group in $scope.groups
      name = "<div class='label'>#{group.name}</div>"
      $scope.markerSet.push(
        id: group.id
        latitude: group.lat
        longitude: group.lon
        title: name
      )


  $scope.setCoords = (position)->
    $scope.coords = position.coords
    setTimeout (->
      $scope.map =
        center:
          latitude: $scope.coords.latitude
          longitude: $scope.coords.longitude
        zoom: 13
        markers: $scope.markerSet
      $scope.$apply()
    ), 500

  $scope.getLocation()
]
