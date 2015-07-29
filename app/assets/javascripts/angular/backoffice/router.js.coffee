Router = ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $urlRouterProvider.otherwise "/"

  $stateProvider
    .state "overview",
      url: "/"
      template: JST['angular/backoffice/templates/overview']
      controller: 'ideasCtrl'
    .state 'idea',
      url: '/:id?comment_id'
      template: JST['angular/backoffice/templates/idea']
      controller: 'IdeaCtrl'

  $locationProvider.html5Mode(false)

angular
  .module('Backoffice')
  .config ['$stateProvider', '$urlRouterProvider', '$locationProvider', Router]
