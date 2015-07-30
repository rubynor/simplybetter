ApplicationsCtrl = ($rootScope, $scope, Session) ->
  $scope.init = (appKey, email) ->
    $rootScope.appKey = appKey
    Session.setAdmin(appKey)
    Session.setEmail(email)

  return

angular
  .module('Backoffice')
  .controller('applicationsCtrl', ['$rootScope', '$scope', 'Session', ApplicationsCtrl])
