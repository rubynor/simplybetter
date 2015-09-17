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
  @addCollaboratorModalOpen = false

  @openModal = =>
    @addCollaboratorModalOpen = true

  @closeModal = =>
    @addCollaboratorModalOpen = false

  @invite = =>
    invite = new Collaborator({email: @email, name: @name})
    @closeModal()
    invite.$save {applicationId: $rootScope.appId}, (response) =>
      @email = ""
      @name = ""
      ngToast.create(content: '<strong>Success: </strong>' + response.success)
      getCollaborators()
    , (response) =>
      showErrors(response)

  @remove = (user) =>
    Collaborator.delete {applicationId: $rootScope.appId, id: user.id}, (response) ->
      ngToast.create(content: '<strong>Success: </strong>' + response.success)
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
