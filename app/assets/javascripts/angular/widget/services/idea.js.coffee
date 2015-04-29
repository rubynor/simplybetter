widget.factory 'Idea', ['$resource', 'Session', ($resource, Session) ->
  $resource '/widget_api/ideas/:id.json',
    {
      id: '@id',
      info: Session.info,
      appkey: Session.token,
      email: Session.email
    },
    {
      patch: { method: 'PATCH' },
      update: { method: 'PUT' }
    }
]
