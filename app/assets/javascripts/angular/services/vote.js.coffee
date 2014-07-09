widget.factory 'Vote', ['$resource', ($resource) ->
  $resource '/widget_api/votes/cast.json'
]
