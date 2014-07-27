'use strict'

@rebootme = angular.module('rebootmeApp', ['ngRoute', 'ngResource', 'ngSanitize', 'ngCookies', 'ngResource', 'google-maps'])

@rebootme.config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    .when '/category/:categoryId',
      templateUrl: 'views/categories/show.html',
      controller: 'ShowCategoryCtrl'
    .otherwise
      redirectTo: '/'

