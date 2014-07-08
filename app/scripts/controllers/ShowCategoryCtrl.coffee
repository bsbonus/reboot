
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

  $scope.setCoords = (position)->
    $scope.coords = position.coords
    setTimeout (->
      $scope.map =
        center:
          latitude: $scope.coords.latitude
          longitude: $scope.coords.longitude
        zoom: 13
      $scope.$apply()
    ), 500

  $scope.displayNextEvent = ->
    if @.meetups.next_event.id then event_id = @.meetups.next_event.id else alert('There are no upcoming meetups')
    if event_id
      url = "https://api.meetup.com/2/event/#{event_id}?&sign=true&photo-host=public&page=1&key=#{key}&callback=JSON_CALLBACK"
      $http.jsonp(url).success((data) ->
        if data.status is "404 Not Found"
          console.log 'Not found'
        else if data.venue and data.venue.lon and data.venue.lat
          console.log data.venue.lat
          console.log data.venue.lon
          $scope.mapMarker = new google.maps.Marker({
            position:
              latitude: $scope.coords.latitude
              longitude: $scope.coords.longitude
            map: $scope.map,
            title: 'Hello World!'
          })
        else
          console.log data
      )

  $scope.getLocation()
]
