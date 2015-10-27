FaqCtrl = ($http, $scope, Session) ->
  $scope.$parent.path = true
  $http(method: 'GET', url: '/widget_api/faqs.json', params: { info: Session.info }).success(
    (data) ->
      $scope.faqs=data
  ).error(
    (error) ->
      console.log error
  )

angular.module('Simplybetter').controller('FaqCtrl', ['$http', '$scope', 'Session', FaqCtrl])
