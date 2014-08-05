widget.factory 'Redirect', ['$NamedRouteService', ($NamedRouteService) ->
  return (name, options, urlParameters='') ->
    window.location = $NamedRouteService.reverse(name, options) + urlParameters
]
