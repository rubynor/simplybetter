MainCtrl = ($scope) ->
  $scope.init = (appId) =>
    $scope.appId = appId

angular
  .module('Backoffice')
  .controller('MainCtrl', ['$scope', MainCtrl])
