widget.factory 'User', ['$resource', 'Session', ($resource, Session) ->
  @user = {}
  @authParams = {}
  email = Session.email
  token = Session.token

  @get = ->
    if @user.length > 0
      @user
    else
      @fetchFromBackend()

  @fetchFromBackend = ->
    @user =
      @resource.get
        email: email
        token: token

  @update = (success, error) ->
    @user.$update(
      token: token
    ,(data) =>
      success(data)
    , =>
      error()
    )

  @resource = (->
    $resource '/widget_api/user.json', null,
      update:
        method: 'PUT'
  )()

  return @
]
