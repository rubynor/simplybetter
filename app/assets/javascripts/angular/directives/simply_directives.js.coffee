@simplyDirectives = angular.module('simplyDirectives', []);

simplyDirectives.directive 'ideaNew', ->
  restrict: 'E'
  template: JST['angular/directives/templates/idea_new']

simplyDirectives.directive 'ideaItem', ->
  restrict: 'E'
  template: JST["angular/directives/templates/idea_item"]

simplyDirectives.directive 'vote', ->
  restrict: 'E'
  template: "<div class='vote'><div class='vote-buttons'><a class='up' ng-click='vote(idea, 2)' ng-class='{active: idea.voter_status == 1}'></a><div class='votes'>{{ idea.votes_count }}</div><a class='down' ng-click='vote(idea, -2)' ng-class='{active: idea.voter_status == -1}'></a></div></div>"
  controller: 'VoteCtrl'

simplyDirectives.directive 'comments', ->
  restrict: 'E'
  template: JST['angular/directives/templates/comments']

simplyDirectives.directive 'notifications', ->
  restrict: 'E'
  template: JST['angular/directives/templates/notifications']
