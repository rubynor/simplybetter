Options = ->
  restrict: 'E'
  scope:
    edit: '='
    complete: '='
    delete: '='
    item: '='
    admin: '='
    togglevisible: '&'
    edititem: '&'
    deleteitem: '&'
    togglecompleted: '&'
    all: '='
  template: JST['angular/shared/options/options']
  controller: ['Session', '$scope', (Session, $scope) ->
    @isAdmin = $scope.admin || Session.isAdmin()

    @
  ]
  controllerAs: 'options'

angular.module('shared').directive('options', Options)
