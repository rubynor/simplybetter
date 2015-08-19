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
    .state 'faqs',
      url: '/faqs'
      template: JST['angular/widget/templates/faq_view']
      controller: 'FaqCtrl as faq'
    .state 'support',
      url: '/support'
      template: JST['angular/widget/templates/support_view']
      controller: 'SupportCtrl as support'

  $locationProvider.html5Mode(false)

angular
  .module('Simplybetter')
  .config ['$stateProvider', '$urlRouterProvider', '$locationProvider', Router]
