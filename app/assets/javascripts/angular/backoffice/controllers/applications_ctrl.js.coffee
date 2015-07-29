ApplicationsCtrl = ($rootScope, $scope, Session) ->
  $scope.init = (appKey) ->
    $rootScope.appKey = appKey
    Session.setAdmin(appKey)

  return

angular
  .module('Backoffice')
  .controller('applicationsCtrl', ['$rootScope', '$scope', 'Session', ApplicationsCtrl])
