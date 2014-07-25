widget.factory 'Comment', ['$resource', ($resource) ->
  $resource '/widget_api/ideas/:idea_id/comments/:id.json', {idea_id: '@idea_id', id: '@id'}
]
