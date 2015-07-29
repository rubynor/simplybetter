IdeasCtrl =  ($rootScope, $scope, Idea) ->

  $scope.ideas = Idea.all({token: $rootScope.appKey})

  $scope.activeClass = 'all'

  $scope.showAll = ->
    $scope.activeClass = 'all'
    $scope.selectedFilter = undefined

  $scope.showCompleted = ->
    $scope.activeClass = 'completed'
    $scope.selectedFilter = { completed: true }

  $scope.hideCompleted = ->
    $scope.activeClass = 'hide_completed'
    $scope.selectedFilter = { completed: false }

  $scope.showVisible = ->
    $scope.activeClass = 'visible'
    $scope.selectedFilter = { visible: true }

  $scope.hideVisible = ->
    $scope.activeClass = 'hide_visible'
    $scope.selectedFilter = { visible: false }

angular
  .module('Backoffice')
  .controller('ideasCtrl', ['$rootScope', '$scope', 'Idea', IdeasCtrl])
