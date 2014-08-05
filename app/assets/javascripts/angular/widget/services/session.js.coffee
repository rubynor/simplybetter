widget.factory 'Session', ['$cookieStore', ($cookieStore) ->
  email = $cookieStore.get('email')
  token = $cookieStore.get('token')


  user_signed_in: ->
    email && token

  email: ->
    email

  token: ->
    token

  owner: (other_email) ->
    email == other_email
]
