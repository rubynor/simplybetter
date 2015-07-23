SettingsCtrl = ($scope, $rootScope, $stateParams, $timeout, User, Session) ->
  $scope.$parent.path = true
  @spinnerVisible = false
  @errorVisible = false
  @successVisible = false

  @user = User.get()

  @initSpinner = ->
    spinner = new Spinner().spin()
    element = $('div.spinner')[0]
    element.appendChild(spinner.el)

  @submitForm = ->
    @showSpinner()
    User.update( =>
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

  @isAdmin = ->
    Session.isAdmin()

  @login = ->
    Session.adminLogin()
    return

  @initSpinner()

  return

angular
  .module('Simplybetter')
  .controller('SettingsCtrl', ['$scope', '$rootScope', '$stateParams', '$timeout', 'User', 'Session', SettingsCtrl])
