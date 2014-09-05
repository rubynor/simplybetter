ListReportsCtrl = ($scope, $element, $compile, AbuseReport) ->
  @reports = {}
  $scope.$watch 'appId', (oldVal, newVal) ->
    if newVal
      AbuseReport.all(newVal, allSuccess, allError)

  allSuccess = (data) =>
    @reports = data
    angular.forEach @reports, (value, key) ->
      $scope.add(value, key)
  allError = (err) ->
    console.log err

  $scope.add = (model, key) ->
    type = model.abuse_reportable_type
    directive = "<abuse-report-#{type} index='#{key}'></abuse-report-#{type}>"
    el = $compile(directive)($scope)
    $element.append(el)

  return

ListReports = ($compile) ->
  return {
    restrict: 'E'
    controller: ['$scope', '$element', '$compile', 'AbuseReport', ListReportsCtrl]
  }

angular
  .module('Backoffice')
  .directive('listReports', ['$compile', ListReports])
