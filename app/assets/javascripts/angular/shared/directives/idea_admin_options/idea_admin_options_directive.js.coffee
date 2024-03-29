IdeaAdminOptions = ->
  restrict: 'E'
  template: JST['angular/shared/directives/idea_admin_options/idea_admin_options_directive_template']
  require: '^ideaItem'
  scope:
    idea: '='
    collection: '='
  controller: ['$scope', 'Redirect', 'Idea', 'Session', 'ngToast', ($scope, Redirect, Idea, Session, ngToast) ->

    updateSuccessNotify = (msg) ->
      ngToast.create(content: msg)

    updateFailedNotify = (msg) ->
      ngToast.create(
        content: msg,
        dismissOnTimeout: false,
        className: 'danger'
        dismissButton: true
      )

    error_message = (error) ->
      "Something went wrong, and we couldn't update because <strong>#{error.data.msg}</strong>."

    @visible = false

    @toggle = =>
      @visible = !@visible

    @ideaToggleCompleted = =>
      $scope.idea.completed = !$scope.idea.completed
      $scope.idea.$update {}, ->
        updateSuccessNotify("Completed is now set to <strong>#{$scope.idea.completed}</strong>")
        return
      , (error) ->
        updateFailedNotify(error_message(error))
        $scope.idea.completed = !$scope.idea.completed

    @ideaToggleVisible = =>
      $scope.idea.visible = !$scope.idea.visible
      $scope.idea.$update {}, ->
        visibility = if $scope.idea.visible then 'visible' else 'invisible'
        updateSuccessNotify("This idea is now <strong>#{visibility}</strong> to your users")
        return
      , (error) ->
        updateFailedNotify(error_message(error))
        $scope.idea.visible = !$scope.idea.visible

    @ideaDelete = ->
      Idea.delete($scope.idea)
      Redirect('overview')

    @isAdmin = ->
      Session.isAdmin()

    return
  ]
  controllerAs: 'options'
  link: (scope, element, attrs, ideaItemCtrl) ->
    scope.options.ideaEdit = ->
      ideaItemCtrl.editMode = true

angular
  .module('shared')
  .directive('ideaAdminOptions', IdeaAdminOptions)
