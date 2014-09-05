ReportInfoCtrl = ($scope, AbuseReport) ->
  @report = AbuseReport.all()[$scope.index]
  return

ReportInfo = ->
  restrict: 'E'
  template: JST['angular/backoffice/templates/abuse_reports/report_info']
  controller: ['$scope', 'AbuseReport', ReportInfoCtrl]
  controllerAs: 'infoCtrl'

angular
  .module('Backoffice')
  .directive('reportInfo', ReportInfo)
