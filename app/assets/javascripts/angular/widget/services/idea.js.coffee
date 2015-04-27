widget.factory 'Idea', ['$resource', 'Session', ($resource, Session) ->
  $resource '/widget_api/ideas/:id.json',
    {
      id: '@id',
      token: Session.token,
      user_email: Session.email
    },
    {
      patch: { method: 'PATCH' }
    }
]
