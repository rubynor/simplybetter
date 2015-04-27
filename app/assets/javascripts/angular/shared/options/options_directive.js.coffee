Options = ->
  restrict: 'E'
  scope:
    edit: '='
    complete: '='
    delete: '='
    item: '='
    togglevisible: '&'
  template: JST['angular/shared/options/options']
  controller: ['Session', (Session) ->
    @isAdmin = Session.isAdmin()

    @
  ]
  controllerAs: 'options'

angular.module('shared').directive('options', Options)
