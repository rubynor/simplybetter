angular.module("filters", []).filter "truncate", ->
  (text, length, end) ->
    length = 10 if isNaN(length)
    end = "..."  if end is undefined
    if text.length <= length or text.length - end.length <= length
      text
    else
      String(text).substring(0, length - end.length) + end


@widget = angular.module('Simplybetter', ['ngResource', 'filters'])


widget.factory 'Idea', ['$resource', ($resource) ->
  $resource '/widget_api/ideas.json'
]

widget.controller 'WidgetCtrl', ['$scope', 'Idea', ($scope, Idea) ->
  $scope.init = (token, email) ->
    console.log 'Inside init'
    console.log "Token = #{token} og email = #{email}"
    $scope.ideas = Idea.query({token: token, user_email: email})
]
