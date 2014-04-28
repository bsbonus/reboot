@rebootme.factory 'TestFactory', ($http) ->
  categories = "http://api.meetup.com/2/categories?order=shortname&desc=false&offset=0&format=json&page=500&sig_id=9849582&sig=96f38c16324bcaf8d4c5851c6272297b84e8a0e3&callback=JSON_CALLBACK"
  TestFactory = () ->
    @categoryList = null
    return

  TestFactory::listCategories = ()->
    self = this
    $http.jsonp(categories).then (response) ->
      self.categoryList = response.data
      response

  TestFactory

#@rebootme.controller 'MainCtrl', ['$scope', '$location', '$http', ($scope, $location, $http, testFactory) ->
  #categories = "http://api.meetup.com/2/categories?order=shortname&desc=false&offset=0&format=json&page=500&sig_id=9849582&sig=96f38c16324bcaf8d4c5851c6272297b84e8a0e3&callback=JSON_CALLBACK"
  #$http.jsonp(categories).success((data) ->
  # $scope.categories = data.results
  #)
 # $scope.fromFactory = new testFactory.listCategories()
#]
#
@rebootme.controller 'MainCtrl', ($scope, TestFactory) ->
  categoryListing = new TestFactory()
  categoryListing.listCategories().then ->
    $scope.categories = categoryListing.categoryList.results
