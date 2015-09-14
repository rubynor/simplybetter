CollaboratorsCtrl = ($resource, $scope, $rootScope, $http, ngToast) ->
  InviteCustomer = $resource '/applications/:applicationId/add_collaborator', { applicationId: '@applicationId' }
  Collaborators = $resource '/applications/:applicationId/collaborators', { applicationId: '@applicationId' }

  @list = []

  getCollaborators = =>
    @list = Collaborators.query({applicationId: $rootScope.appId})

  showErrors = (response) ->
    for error in response.data.errors
      ngToast.create(
        content: '<strong>Error: </strong>' + error
        dismissOnTimeout: false,
        className: 'danger'
        dismissButton: true
      )

  getCollaborators()

  @email = ""
  @name = ""

  @invite = =>
    invite = new InviteCustomer({email: @email, name: @name})
    $scope.visible = false
    invite.$save {applicationId: $rootScope.appId}, (response) =>
      @email = ""
      @name = ""
      ngToast.create(content: '<strong>Success: </strong>' + response.success)
      getCollaborators()
    , (response) =>
      showErrors(response)

  @remove = (user) =>
    $http.delete("/applications/#{$rootScope.appId}/remove_collaborator?email=#{user.email}")
                                                                          .then (response) ->
      ngToast.create(content: '<strong>Success: </strong>' + response.data.success)
      getCollaborators()
    , (response) ->
      showErrors(response)

  @ownerOrCollaborator = (customer) =>
    if customer.owner
      'owner'
    else
      'collaborator'

  return

angular
  .module('Backoffice')
  .controller('CollaboratorsCtrl', ['$resource', '$scope', '$rootScope', '$http', 'ngToast', CollaboratorsCtrl])
