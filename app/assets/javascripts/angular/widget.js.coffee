angular.module("filters", []).filter "truncate", ->
  (text, length, end) ->
    return unless text
    length = 10 if isNaN(length)
    end = "..."  if end is undefined
    if text.length <= length or text.length - end.length <= length
      text
    else
      String(text).substring(0, length - end.length) + end

@widget = angular.module 'Simplybetter', [
  'ngResource'
  'filters'
  'simplyDirectives'
  'shared'
  'ui.bootstrap'
  'ngCookies'
  'ng-rails-csrf'
]

@widget.run ['Session', (Session) ->
  Session.setInfoParam()
  Session.setParams()
]
