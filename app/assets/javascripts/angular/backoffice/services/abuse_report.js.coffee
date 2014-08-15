->(
  AbuseReport = () ->
    all = (application_id, allSuccess, allError) ->
      $http
        .get("/applications/#{application_id}/abuse_report")
        .success (data) ->
          allSuccess(data)
        .error (error) ->
          allError(error)

    return
      all: all

  angular
    .module('Backoffice')
    .factory('AbuseReport', [AbuseReport])
)()


