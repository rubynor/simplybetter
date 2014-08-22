AbuseReport = ($http) ->
  all = (application_id, allSuccess, allError) ->
    $http
      .get("/applications/#{application_id}/abuse_reports")
      .success (data) ->
        allSuccess(data)
      .error (error) ->
        allError(error)

  return {
    all: all
  }

angular
  .module('Backoffice')
  .factory('AbuseReport', ['$http', AbuseReport])
