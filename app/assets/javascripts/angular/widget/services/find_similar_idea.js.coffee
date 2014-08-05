widget.factory 'FindSimilarIdea', ['$resource', '$cookieStore', ($resource, $cookieStore) ->
  $resource '/widget_api/ideas/find_similar/:id.json', {id: '@id', token: $cookieStore.get('token')}
]
