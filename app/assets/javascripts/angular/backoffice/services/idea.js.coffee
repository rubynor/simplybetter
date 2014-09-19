Idea = ($resource) ->
  $resource '/applications/:application_id/ideas/:id.json', { id: '@id', application_id: '@application_id' }, { patch: { method: 'PATCH' } }

angular
  .module('Backoffice')
  .factory('Idea', ['$resource', Idea])
