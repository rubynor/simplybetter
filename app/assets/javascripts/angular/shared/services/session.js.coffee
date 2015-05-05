angular.module('shared').factory 'Session', ['$cookies', '$http', '$window', '$timeout', ($cookies, $http, $window, $timeout) ->
  @email = ''
  @token = undefined
  @admin = undefined
  @info = undefined

  setAdmin = (token) =>
    that = @
    $http.get("/widget_api/applications/#{token}/is_admin.json")
      .success (data) ->
        that.admin = data.is_admin
      .error (err) ->
        alert(err)

  setParams: ->
    that = @
    params = atob(location.search.split('=')[1]).substring(1).split('&')
    angular.forEach(params, (param) ->
      splitted_param = param.split('=')
      key = splitted_param[0]
      value = splitted_param[1]
      if key == 'appkey'
        that.token = value
        console.log 'token is ', value
      if key == 'email'
        that.email = value
        console.log 'email is ', value
    )
    setAdmin(that.token)

  setInfoParam: ->
    params = location.search
    console.log 'params is ', params
    splitted = params.split('=')
    console.log 'splitted is ', splitted
    @info = splitted[1]

  user_signed_in: ->
    @email && @token

  owner: (other_email) ->
    @email == other_email

  isAdmin: =>
    # $cookies.auth_token && @admin
    # We can't use cookies for Safari
    # But not sure if this would be suffice...
    @admin

  adminLogin: ->
    token = @token
    popup = $window.open(location.origin + '/popup_login', "login", "width=600, height=550")
    popup.onbeforeunload = ->
      $timeout ->
        setAdmin(token)
      , 1000
      return null
]
