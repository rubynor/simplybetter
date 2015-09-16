Collaborator = ($resource) ->
  $resource '/applications/:applicationId/collaborators/:id', { applicationId: @applicationId, id: @id }

angular
  .module('Backoffice')
  .factory('Collaborator', ['$resource', Collaborator])
