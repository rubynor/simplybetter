CollaboratorsCtrl = ($resource, $scope, $rootScope, ngToast) ->
  InviteCustomer = $resource '/applications/:applicationId/add_collaborator', { applicationId: '@applicationId' }
  Collaborators = $resource '/applications/:applicationId/collaborators', { applicationId: '@applicationId' }

  @list = []

  getCollaborators = =>
    @list = Collaborators.query({applicationId: $rootScope.appId})

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
      for error in response.data.errors
        ngToast.create(
          content: '<strong>Error: </strong>' + error
          dismissOnTimeout: false,
          className: 'danger'
          dismissButton: true
        )

  return

angular
  .module('Backoffice')
  .controller('CollaboratorsCtrl', ['$resource', '$scope', '$rootScope', 'ngToast', InvitesCtrl])
