Router = ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $urlRouterProvider.otherwise "/overview"

  $stateProvider
    .state "overview",
      url: "/overview"
      template: JST['angular/widget/templates/overview']
      controller: 'OverviewCtrl'
    .state 'idea',
      url: '/ideas/:id?comment_id'
      template: JST['angular/widget/templates/idea_view']
      controller: 'IdeaCtrl'
    .state 'settings',
      url: '/settings'
      template: JST['angular/widget/templates/settings_view']
      controller: 'SettingsCtrl as setting'

  $locationProvider.html5Mode(false)

angular
  .module('Simplybetter')
  .config ['$stateProvider', '$urlRouterProvider', '$locationProvider', Router]
