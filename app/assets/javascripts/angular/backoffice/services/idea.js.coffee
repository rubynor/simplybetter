backoffice.factory 'Idea', ['$resource', ($resource) ->
  $resource '/applications/:application_id/ideas/:id.json', { id: '@id', application_id: '@application_id' }, { patch: { method: 'PATCH' } }
]
