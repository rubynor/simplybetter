InvitesCtrl = ($resource, $rootScope) ->
  Resource = $resource '/applications/:applicationId/invite_customer', { applicationId: '@applicationId' }

  @email = ""

  @invite = =>
    invite = new Resource({email: @email})

  return

angular
  .module('Backoffice')
  .controller('InvitesCtrl', ['$resource', '$rootScope', InvitesCtrl])
