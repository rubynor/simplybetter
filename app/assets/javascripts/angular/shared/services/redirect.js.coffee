Redirect = ($state) ->
  removeEmptyQueryStringParams = (queryString) ->
    for key, value of queryString
      delete queryString[key] unless value

  return (name, options) ->
    removeEmptyQueryStringParams(options)
    $state.go(name, options)

angular
  .module('shared')
  .factory('Redirect', ['$state', Redirect])
