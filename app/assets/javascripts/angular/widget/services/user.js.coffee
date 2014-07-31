widget.factory 'User', ['$resource', ($resource) ->
  $resource '/widget_api/user.json',
    email: '@email'
    token: '@token'
  ,
    update:
      method: 'PUT'
      params:
        email: '@email'
        name: '@name'
        token: '@token'
]
