AbuseReportsCtrl = ($scope, AbuseReport) ->
  $scope.appId = undefined
  $scope.init = (appId) ->
    $scope.appId = appId

  return

angular
  .module('Backoffice')
  .controller('abuseReportsCtrl', ['$scope', 'AbuseReport', AbuseReportsCtrl])
