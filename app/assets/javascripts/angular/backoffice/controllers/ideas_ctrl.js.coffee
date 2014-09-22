IdeasCtrl = ($scope, IdeasCache) ->
  @ideas = IdeasCache.get($scope.appId)
  return

angular
  .module('Backoffice')
  .controller('IdeasCtrl', ['$scope', 'IdeasCache', IdeasCtrl])
