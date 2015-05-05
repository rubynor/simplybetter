widget.factory 'Comment', ['$resource', 'Session', ($resource, Session) ->
  $resource('/widget_api/ideas/:idea_id/comments/:id.json', {idea_id: '@idea_id', id: '@id', info: Session.info }, { update: { method: 'PUT' } })
]
