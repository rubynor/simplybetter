SettingsCtrl = ['$scope', '$rootScope', '$routeParams', 'User', ($scope, $rootScope, $routeParams, User) ->
  $scope.$parent.path = true

  #$scope.user = User.getUser($scope.$parent.email, $scope.$parent.token)
  $scope.user = User.get
    user:
      email: $scope.$parent.email
    application:
      token: $scope.$parent.token
]

angular
  .module('Simplybetter')
  .controller('SettingsCtrl', SettingsCtrl)
