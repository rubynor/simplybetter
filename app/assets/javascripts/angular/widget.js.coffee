angular.module("filters", []).filter "truncate", ->
  (text, length, end) ->
    length = 10 if isNaN(length)
    end = "..."  if end is undefined
    if text.length <= length or text.length - end.length <= length
      text
    else
      String(text).substring(0, length - end.length) + end


@widget = angular.module('Simplybetter', ['ngResource', 'filters'])

widget.directive 'ideaItem', ->
  restrict: 'E'
  template: JST["angular/templates/idea_item"]

widget.directive 'vote', ->
  restrict: 'E'
  template: JST['angular/templates/vote']
  