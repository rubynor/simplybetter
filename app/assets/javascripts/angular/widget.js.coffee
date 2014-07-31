angular.module("filters", []).filter "truncate", ->
  (text, length, end) ->
    return unless text
    length = 10 if isNaN(length)
    end = "..."  if end is undefined
    if text.length <= length or text.length - end.length <= length
      text
    else
      String(text).substring(0, length - end.length) + end

@widget = angular.module('Simplybetter', ['ngResource', 'filters', 'ngRoute', 'simplyDirectives', 'ui.bootstrap'])

widget.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when('/widget', {template: JST['angular/widget/templates/overview']})
  .when('/widget/ideas/:id', {controller: 'IdeaCtrl', template: JST['angular/widget/templates/idea_view']})
  .when('/widget/settings', {controller: 'SettingsCtrl as setting', template: JST['angular/widget/templates/settings_view']})
  .otherwise(redirectTo: '/widget')
]
