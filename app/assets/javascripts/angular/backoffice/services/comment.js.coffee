Comment = ($resource) ->
  $resource '/comments/:id.json', { id: '@id'}, { patch: { method: 'PATCH' } }

angular
  .module('Backoffice')
  .factory('Comment', ['$resource', Comment])
