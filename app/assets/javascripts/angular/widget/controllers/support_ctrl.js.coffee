SupportCtrl = ($scope, $stateParams, $timeout, Support) ->
  $scope.$parent.path = true
  @app_name = $scope.$parent.app_name
  console.log 'app_name', @app_name
  @spinnerVisible = false
  @errorVisible = false
  @successVisible = false

  @submitForm = ->
    @showSpinner()
    Support.save({message: @message}, =>
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

  @showForm = ->
    @successVisible and @showSpinner

  @showSuccess = ->
    @successVisible = true

  @showSpinner = ->
    @spinnerVisible = true

  @hideSpinner = ->
    @spinnerVisible = false

  spinner = new Spinner().spin()
  element = $('div.spinner')[0]
  element.appendChild(spinner.el)
  return


angular
  .module('Simplybetter')
  .controller('SupportCtrl', ['$scope', '$stateParams', '$timeout', 'Support', SupportCtrl])

