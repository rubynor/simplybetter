angular.module('shared').factory 'Session', ['$cookies', '$http', '$window', '$timeout', ($cookies, $http, $window, $timeout) ->
  @email = ''
  @token = undefined
  @admin = undefined

  setAdmin = =>
    that = @
    $http.get("/widget_api/applications/#{$cookies.token}/is_admin.json")
      .success (data) ->
        that.admin = data.is_admin
      .error (err) ->
        alert(err)

  setAdmin()

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

  isAdmin: =>
    $cookies.auth_token && @admin

  adminLogin: ->
    popup = $window.open(location.origin + '/popup_login', "login", "width=600, height=550")
    popup.onbeforeunload = ->
      $timeout ->
        setAdmin()
      , 1000
      return null
]
