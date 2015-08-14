CustomizationCtrl = ($rootScope, $scope, Application) ->
  $scope.application = Application.get({ id: $rootScope.appId })
  console.log $rootScope

  return


angular
  .module('Backoffice')
  .controller('customizationCtrl', ['$rootScope', '$scope', 'Application', CustomizationCtrl])
