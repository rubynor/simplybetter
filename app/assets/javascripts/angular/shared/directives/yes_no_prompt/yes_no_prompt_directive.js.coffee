YesNoPrompt = ->
  restrict: 'A'
  template: JST['angular/shared/directives/yes_no_prompt/yes_no_prompt_directive_template']
  scope:
    yes: '&'
    text: '='
    visible: '=?'

  controllerAs: 'prompt'
  controller: ['$scope', ($scope) ->
    @yes = ->
      $scope.yes()

    @no = ->
      $scope.visible = false
    return
  ]

  link: (scope, element) ->
    element.bind 'click', ->
      scope.$apply ->
        scope.visible = true

angular
   .module('shared')
   .directive('yesNoPrompt', YesNoPrompt)
