widget.factory 'Idea', ['$resource', ($resource) ->
  $resource '/widget_api/ideas/:id.json', {id: '@id'}
]
