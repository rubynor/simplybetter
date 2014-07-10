angular.module("filters", []).filter "truncate", ->
  (text, length, end) ->
    return unless text
    length = 10 if isNaN(length)
    end = "..."  if end is undefined
    if text.length <= length or text.length - end.length <= length
      text
    else
      String(text).substring(0, length - end.length) + end


@widget = angular.module('Simplybetter', ['ngResource', 'filters', 'ngRoute'])

widget.config ($routeProvider) ->
  $routeProvider
  .when('/widget', {controller: 'WidgetCtrl', template: JST['angular/templates/overview']})
  .when('/widget/:id', {controller: 'IdeaCtrl', template: JST['angular/templates/idea_view']})
  .otherwise(redirectTo: '/widget')

widget.directive 'ideaNew', ->
  restrict: 'E'
  template: JST['angular/templates/idea_new']

widget.directive 'ideaItem', ->
  restrict: 'E'
  template: JST["angular/templates/idea_item"]

widget.directive 'vote', ->
  restrict: 'E'
  template: "<div class='vote'><div class='vote-buttons'><a class='up' ng-click='vote(idea, 2)' ng-class='{active: idea.voter_status == 1}'></a><div class='votes'>{{ idea.votes_count }}</div><a class='down' ng-click='vote(idea, -2)' ng-class='{active: idea.voter_status == -1}'></a></div></div>"
  controller: 'VoteCtrl'

widget.directive 'comments', ->
  restrict: 'E'
  template: JST['angular/templates/comments']

widget.directive 'notifications', ->
  restrict: 'E'
  template: JST['angular/templates/notifications']
