AbuseReportCommentCtrl = ($scope, AbuseReport) ->
  @comment = AbuseReport.all()[$scope.index].comment
  return

AbuseReportComment = () ->
  restrict: 'E'
  scope:
    index: '@'
  template: JST['angular/backoffice/templates/abuse_reports/comment']
  controller: ['$scope', 'AbuseReport', AbuseReportCommentCtrl]
  controllerAs: 'commentCtrl'

angular
  .module('Backoffice')
  .directive('abuseReportComment', [AbuseReportComment])
