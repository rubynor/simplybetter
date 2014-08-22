AbuseReportsCtrl = ($scope, AbuseReport) ->
  $scope.init = (app_id) ->
    @app_id = app_id
    AbuseReport.all(@app_id, allSuccess, allError)

  allSuccess = (data) ->
    console.log data
  allError = (err) ->
    console.log err

angular
  .module('Backoffice')
  .controller('abuseReportsCtrl', ['$scope', 'AbuseReport', AbuseReportsCtrl])
