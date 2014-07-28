widget.factory 'NotificationsCount', ['$resource', ($resource) ->
  $resource '/widget_api/notifications/count', { token: token, user_email: email }
]
