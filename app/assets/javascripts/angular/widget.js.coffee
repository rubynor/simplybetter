angular.module("filters", []).filter "truncate", ->
  (text, length, end) ->
    return unless text
    length = 10 if isNaN(length)
    end = "..."  if end is undefined
    if text.length <= length or text.length - end.length <= length
      text
    else
      String(text).substring(0, length - end.length) + end

@widget = angular.module 'Simplybetter', [
  'ngResource'
  'filters'
  'ngRoute'
  'simplyDirectives'
  'ui.bootstrap'
  'zj.namedRoutes'
  'ngCookies'
]

@widget.run ['$cookies', 'Session', ($cookies, Session) ->
  Session.set_token($cookies.token)
  Session.set_email($cookies.email)
]

@widget.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    # use hashbang fallback mode
    $locationProvider
      .hashPrefix("")
      .html5Mode(false);

    $routeProvider
      .when '/widget',
        template: JST['angular/widget/templates/overview']
        name: 'overview'
      .when '/widget/ideas/:id',
        controller: 'IdeaCtrl'
        template: JST['angular/widget/templates/idea_view']
        name: 'idea'
      .when '/widget/settings',
        controller: 'SettingsCtrl as setting'
        template: JST['angular/widget/templates/settings_view']
        name: 'settings'
      .when '/widget/ideas/:id/edit',
        controller: 'IdeaCtrl'
        template: JST['angular/widget/templates/idea_edit']
        name: 'idea_edit'
      .otherwise(redirectTo: '/widget')
  ]
