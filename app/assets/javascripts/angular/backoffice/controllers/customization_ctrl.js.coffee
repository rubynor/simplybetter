CustomizationCtrl = ($rootScope, $scope, ngToast, Application) ->
  $scope.application = Application.get { id: $rootScope.appId }, (data) ->
    $scope.applicationOriginal = angular.copy(data)

  BUTTON_SAVED_TEXT = 'Saved'
  BUTTON_UNSAVED_TEXT = 'Save'

  @saveText = BUTTON_UNSAVED_TEXT

  $scope.$watch 'form.$pristine', (newVal, oldVal) =>
    @saveText = BUTTON_UNSAVED_TEXT if newVal == false

  @save = =>
    @saveText = 'Saving...'
    $scope.application.$update (data) =>
      $scope.errors = undefined
      ngToast.create(content: 'Updated!')
      $scope.applicationOriginal = angular.copy(data)
      $scope.form.$setPristine()
      @saveText = BUTTON_SAVED_TEXT
    , (response) ->
      $scope.errors = response.data.errors

  @isUnchanged = ->
    angular.equals($scope.application, $scope.applicationOriginal)

  @hasJustBeenSaved = =>
    @isUnchanged() && @saveText == BUTTON_SAVED_TEXT

  return


angular
  .module('Backoffice')
  .controller('customizationCtrl', ['$rootScope', '$scope', 'ngToast', 'Application', CustomizationCtrl])
