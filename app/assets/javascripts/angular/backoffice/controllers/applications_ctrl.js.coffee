ApplicationsCtrl = ($rootScope, $scope, Session) ->
  $scope.supportHelp = $scope.supportHelp2 = false
  $scope.iconHelp = false

  $scope.init = (appKey, email, id) ->
    $rootScope.appKey = appKey
    $rootScope.appId = id
    Session.setAdmin(appKey)
    Session.setToken(appKey)
    Session.setEmail(email)

  $scope.toggleSupportHelp = ->
    $scope.supportHelp =!$scope.supportHelp

  $scope.toggleSupportHelp2 = ->
    $scope.supportHelp2 =!$scope.supportHelp2

  $scope.toggleIconHelp = ->
    $scope.iconHelp = !$scope.iconHelp

  return

angular
  .module('Backoffice')
  .controller('applicationsCtrl', ['$rootScope', '$scope', 'Session', ApplicationsCtrl])
