CollaboratorsCtrl = ($resource, $scope, $rootScope, ngToast, Collaborator) ->
  @list = []

  getCollaborators = =>
    @list = Collaborator.query({applicationId: $rootScope.appId})

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
    invite = new Collaborator({email: @email, name: @name})
    $scope.visible = false
    invite.$save {applicationId: $rootScope.appId}, (response) =>
      @email = ""
      @name = ""
      ngToast.create(content: '<strong>Success: </strong>' + response.success)
      getCollaborators()
    , (response) =>
      showErrors(response)

  @remove = (user) =>
    collaborator = new Collaborator({applicationId: $rootScope.appId, id: user.id})
    collaborator.$delete (response) ->
      ngToast.create(content: '<strong>Success: </strong>' + response.data.success)
      getCollaborators()
    , (response) ->
      showErrors(response)

  @ownerOrCollaborator = (customer) =>
    if customer.owner
      'owner'
    else
      'collaborator'

  @allowRemove = (customer) ->
    !customer.is_me && !customer.owner

  return

angular
  .module('Backoffice')
  .controller('CollaboratorsCtrl', ['$resource', '$scope', '$rootScope', 'ngToast', 'Collaborator', CollaboratorsCtrl])
