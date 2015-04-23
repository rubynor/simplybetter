@IdeaFilterCtrl =  ['$scope', 'Session', ($scope, Session) ->

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

  $scope.showMine = (email) ->
    $scope.activeClass = 'mine'
    $scope.selectedFilter = { creator_email: email }

  $scope.isAdmin = ->
    Session.isAdmin()
]
