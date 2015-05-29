FaqCtrl = ($http, $scope) ->
  $scope.$parent.path = true
  $http.get('/widget_api/faqs.json').success(
    (data) ->
      $scope.faqs=data
  ).error(
    (error) ->
      console.log error
  )

angular.module('Simplybetter').controller('FaqCtrl', ['$http', '$scope', FaqCtrl])
