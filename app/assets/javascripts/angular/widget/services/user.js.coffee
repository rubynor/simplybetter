widget.factory 'User', ['$resource', ($resource) ->
  @user = {}
  @authParams = {}

  @get = (email, token) ->
    @setAuthParams(email, token)
    if @user.length > 0
      @user
    else
      @fetchFromBackend()

  @fetchFromBackend = ->
    @user =
      @resource.get
        email: @authParams.email
        token: @authParams.token

  @update = (success, error) ->
    @user.$update(
      token: @authParams.token
    ,(data) =>
      success(data)
    , =>
      error()
    )

  @setAuthParams = (email, token) ->
    @authParams = { email: email, token: token }

  @resource = (->
    $resource '/widget_api/user.json', null,
      update:
        method: 'PUT'
  )()

  return @
]
