widget.factory 'FindSimilarIdea', ['$resource', 'Session', ($resource, Session) ->
  $resource '/widget_api/ideas/find_similar/:id.json', {id: '@id', token: Session.token, user_email: Session.email}
]
