SettingsCtrl = ['$scope', '$rootScope', '$routeParams', '$timeout', 'User', ($scope, $rootScope, $routeParams, $timeout, User) ->
  $scope.$parent.path = true
  @spinnerVisible = false
  @errorVisible = false
  @successVisible = false
  @user = {}
  @user = User.get()

  @initSpinner = ->
    spinner = new Spinner().spin()
    element = $('div.spinner')[0]
    element.appendChild(spinner.el)

  @submitForm = ->
    @showSpinner()
    @user.$update( (data) =>
      @hideSpinner()
      @hideError()
      @showSuccess()
    , =>
      @hideSpinner()
      @showError()
    )

  @showError = ->
    @errorVisible = true

  @hideError = ->
    @errorVisible = false

  @showSuccess = ->
    @successVisible = true
    $timeout( =>
      @successVisible = false
    , 1000)

  @showSpinner = ->
    @spinnerVisible = true

  @hideSpinner = ->
    @spinnerVisible = false

  @initSpinner()

  return
]

angular
  .module('Simplybetter')
  .controller('SettingsCtrl', SettingsCtrl)
