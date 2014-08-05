widget.factory 'EmailSettings', ['$resource', ($resource) ->
  @settings = {}
  @authParams = {}

  @get = (email, token) ->
    @setAuthParams(email, token)
    if @settings.length > 0
      @settings
    else
      @fetchFromBackend()

  @fetchFromBackend = ->
    @settings =
      @resource.get
        email: @authParams.email
        token: @authParams.token

  @update = (success, error) ->
    @settings.$update(
      token: @authParams.token
      email: @authParams.email
    ,(data) =>
      success(data)
    , =>
      error()
    )

  @setAuthParams = (email, token) ->
    @authParams = { email: email, token: token }

  @resource = (->
    $resource '/widget_api/email_settings.json', null,
      update:
        method: 'PUT'
  )()

  return @
]
