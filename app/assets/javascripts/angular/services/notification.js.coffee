widget.factory 'Notification', ['$resource', ($resource) ->
  $resource '/widget_api/notifications/:id.json', { id: '@id'}
]
