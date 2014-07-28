widget.factory 'Idea', ['$resource', ($resource) ->
  $resource '/widget_api/ideas/:id.json', {id: '@id', token: token, user_email: email}
]
