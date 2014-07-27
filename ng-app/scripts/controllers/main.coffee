@rebootme.factory 'TestFactory', ($http) ->
  categories = "http://api.meetup.com/2/categories?order=shortname&desc=false&offset=0&format=json&page=500&sig_id=9849582&sig=96f38c16324bcaf8d4c5851c6272297b84e8a0e3&callback=JSON_CALLBACK"
  TestFactory = () ->
    @categoryList = null
    return

  TestFactory::listCategories = ()->
    self = this
    $http.jsonp(categories).then (response) ->
      listing = response.data
      self.groups = [[]]
      count = 0
      for category, index in listing.results
        if index % 6 is 0 and index != 0
          count += 1
          self.groups[count] = []
          self.groups[count][index % 6 - 1] = category
        else if index % 6 isnt 0
          self.groups[count][index % 6 - 1] = category
      self.categoryList = response.data
      response

  TestFactory

@rebootme.controller 'MainCtrl', ($scope, TestFactory, $location) ->
  categoryListing = new TestFactory()
  categoryListing.listCategories().then ->
    $scope.categoryGroups = categoryListing.groups
    $scope.categories = categoryListing.categoryList.results
    $scope.loadCategoryIdeas = ->
      $location.path("/category/#{@.category.id}")
