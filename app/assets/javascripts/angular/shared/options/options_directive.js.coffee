Options = ->
  restrict: 'E'
  scope:
    edit: '='
    complete: '='
    delete: '='
    item: '='
    togglevisible: '&'
  template: JST['angular/shared/options/options']
  controller: ->
    # TODO: Use session factory..
    @isAdmin = false
    @
  controllerAs: 'options'

angular.module('shared').directive('options', Options)
