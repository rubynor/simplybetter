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
        info: Session.info

  @update = (success, error) ->
    @user.$update(
      info: Session.info
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
