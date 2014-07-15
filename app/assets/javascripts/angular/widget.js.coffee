angular.module("filters", []).filter "truncate", ->
  (text, length, end) ->
    return unless text
    length = 10 if isNaN(length)
    end = "..."  if end is undefined
    if text.length <= length or text.length - end.length <= length
      text
    else
      String(text).substring(0, length - end.length) + end

@widget = angular.module('Simplybetter', ['ngResource', 'filters', 'ngRoute', 'simplyDirectives'])

widget.config ($routeProvider) ->
  $routeProvider
  .when('/widget', {template: JST['angular/templates/overview']})
  .when('/widget/:id', {controller: 'IdeaCtrl', template: JST['angular/templates/idea_view']})
  .otherwise(redirectTo: '/widget')
