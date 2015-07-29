ApplicationsCtrl = ($rootScope, $scope) ->
  $scope.init = (appKey) ->
    $rootScope.appKey = appKey

  return

angular
  .module('Backoffice')
  .controller('applicationsCtrl', ['$rootScope', '$scope', ApplicationsCtrl])
