backoffice.factory 'Comment', ['$resource', ($resource) ->
  $resource '/comments/:id.json', { id: '@id'}
]
