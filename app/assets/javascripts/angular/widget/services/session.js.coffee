widget.factory 'Session', ['$cookies', ($cookies) ->
  @email = ''
  @token = undefined

  user_signed_in: ->
    @email && @token

  owner: (other_email) ->
    @email == other_email

  set_email: (email) ->
    # For some reason email gets undefined unless I do this
    # and then the rails controller complain about
    # missing params email for demo widget
    @email = if email then email else ''

  set_token: (token) ->
    @token = token

  isAdmin: ->
    $cookies.auth_token

  adminLogin: ->
    $window.open(location.origin + '/popup_login', "login", "width=600, height=550")
]
