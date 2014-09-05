AbuseReport = ($http) ->
  service = @
  service.all = undefined
  getAll = (application_id, allSuccess, allError) ->
    if service.all
      return service.all
    else
      $http
        .get("/applications/#{application_id}/abuse_reports")
        .success (data) ->
          service.all = data
          allSuccess(data)
        .error (error) ->
          allError(error)

  return {
    all: getAll
  }

angular
  .module('Backoffice')
  .factory('AbuseReport', ['$http', AbuseReport])
