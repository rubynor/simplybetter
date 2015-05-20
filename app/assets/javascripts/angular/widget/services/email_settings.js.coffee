widget.factory 'EmailSettings', ['$resource', 'Session', ($resource, Session) ->
  @settings = {}
  @authParams = {}
  email = Session.email
  token = Session.token

  @get =  ->
    if @settings.length > 0
      @settings
    else
      @fetchFromBackend()

  @fetchFromBackend = ->
    @settings =
      @resource.get
        info: Session.info

  @update = (success, error) ->
    @settings.$update(
      info: Session.info
    ,(data) =>
      success(data)
    , =>
      error()
    )


  @resource = (->
    $resource '/widget_api/email_settings.json', null,
      update:
        method: 'PUT'
  )()

  return @
]
