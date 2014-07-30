widget.factory 'User', ['$resource', ($resource) ->
  #getUser: (email, token) ->
  #  $http
  #    method: 'GET'
  #    url: '/widget_api/user.json'
  #    data:
  #      user:
  #        email: email
  #      application:
  #        token: token
  $resource '/widget_api/user.json'#, {user: {email: '@email', name: '@name'}, application: {token: '@token'}}
]
