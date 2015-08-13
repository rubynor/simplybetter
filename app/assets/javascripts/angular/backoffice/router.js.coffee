Router = ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $urlRouterProvider.otherwise "/"

  $stateProvider
    .state "overview",
      url: "/"
      template: JST['angular/shared/templates/overview']
      controller: 'OverviewCtrl'
    .state 'idea',
      url: '/:id?comment_id'
      template: JST['angular/shared/templates/idea_view']
      controller: 'IdeaCtrl'

  $locationProvider.html5Mode(false)

angular
  .module('Backoffice')
  .config ['$stateProvider', '$urlRouterProvider', '$locationProvider', Router]
