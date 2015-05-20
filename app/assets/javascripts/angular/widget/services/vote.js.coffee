widget.factory 'Vote', ['$resource', 'Session', ($resource, Session) ->
  $resource '/widget_api/votes/cast.json', { info: Session.info }
]
