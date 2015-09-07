InvitesCtrl = ($resource, $scope, $rootScope) ->
  InviteCustomer = $resource '/applications/:applicationId/invite_customer', { applicationId: '@applicationId' }
  Collaborators = $resource '/applications/:applicationId/collaborators', { applicationId: '@applicationId' }

  @collaborators = []
  
  getCollaborators = =>
    @collaborators = Collaborators.query({applicationId: $rootScope.appId})

  getCollaborators()

  @email = ""
  @name = ""

  @invite = =>
    invite = new InviteCustomer({email: @email, name: @name})
    $scope.visible = false
    invite.$save {applicationId: $rootScope.appId}, =>
      @email = ""
      @name = ""
      getCollaborators()

  return

angular
  .module('Backoffice')
  .controller('InvitesCtrl', ['$resource', '$scope', '$rootScope', InvitesCtrl])
