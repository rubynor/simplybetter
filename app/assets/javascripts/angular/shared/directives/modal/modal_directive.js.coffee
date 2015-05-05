Modal = ($compile) ->
  restrict: 'AE'
  transclude: true
  scope:
    visible: '=?'

  controllerAs: 'modal'
  controller: ['$scope', ($scope) ->

    @close = () ->
      $scope.visible = false

    @stopPropagation = ($event) ->
      $event.stopPropagation()

    return
  ]
  link: (scope, iElement, iAttrs, controller, transcludeFn) ->
    # The modal should be appended to the bottom of <body>
    # regardless of where it is used. This is to make sure
    # that the modal and it's backdrop is always on top in
    # terms of z-index
    modal = $compile( JST['angular/shared/directives/modal/modal_directive_template']() )( scope )
    transcludeFn (clone, scope) ->
      modal.find('.modal-content').append(clone)
    angular.element('body').append(modal)

    # When the directive is destroyed, we need to include
    # the html that we appended to <body>
    scope.$on '$destroy', ->
      modal.remove()

    iElement.bind 'click', ->
      scope.$apply ->
        scope.visible = true

angular
   .module('shared')
   .directive('modal', ['$compile', Modal])
