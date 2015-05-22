widget.factory 'Redirect', ['$state', ($state) ->
  return (name, options) ->
    $state.go(name, options)
]
