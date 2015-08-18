Application = ($resource) ->
  resource = $resource '/applications/:id.json', { id: '@id' },
    { update: {method: 'PUT'} }


angular
  .module('Backoffice')
  .factory('Application', ['$resource', Application])
