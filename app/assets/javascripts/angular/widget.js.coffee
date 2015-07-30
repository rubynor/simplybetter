@widget = angular.module 'Simplybetter', [
  'simplyDirectives'
  'shared'
]

@widget.run ['Session', (Session) ->
  Session.setInfoParam()
  Session.setParams()
]
