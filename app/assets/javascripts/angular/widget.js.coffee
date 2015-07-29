@widget = angular.module 'Simplybetter', [
  'simplyDirectives'
  'shared'
  'ui.bootstrap'
]

@widget.run ['Session', (Session) ->
  Session.setInfoParam()
  Session.setParams()
]
