ApplicationsCtrl = ($rootScope, $scope, Session) ->
  $scope.init = (appKey, email, id) ->
    $rootScope.appKey = appKey
    $rootScope.appId = id
    Session.setAdmin(appKey)
    Session.setToken(appKey)
    Session.setEmail(email)

  return

angular
  .module('Backoffice')
  .controller('applicationsCtrl', ['$rootScope', '$scope', 'Session', ApplicationsCtrl])
