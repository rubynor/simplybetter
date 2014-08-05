widget.factory 'NotificationsCount', ['$resource', '$cookieStore', ($resource, $cookieStore) ->
  $resource '/widget_api/notifications/count', { token: $cookieStore.get('token'), user_email: $cookieStore.get('email') }
]
