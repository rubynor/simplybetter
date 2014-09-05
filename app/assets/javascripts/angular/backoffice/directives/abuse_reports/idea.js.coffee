AbuseReportIdeaCtrl = ($scope, AbuseReport) ->
  @idea = AbuseReport.all()[$scope.index].idea
  return

AbuseReportIdea = () ->
  restrict: 'E'
  scope:
    index: '@'
  template: JST['angular/backoffice/templates/abuse_reports/idea']
  controller: ['$scope', 'AbuseReport', AbuseReportIdeaCtrl]
  controllerAs: 'ideaCtrl'

angular
  .module('Backoffice')
  .directive('abuseReportIdea', [AbuseReportIdea])
