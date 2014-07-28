widget.factory 'FindSimilarIdea', ['$resource', ($resource) ->
  $resource '/widget_api/ideas/find_similar/:id.json', {id: '@id'}
]
