landing_page.controller 'ContactUsCtrl', ['$scope', '$resource', ($scope, $resource) ->
  $scope.sendForm = ->
    $resource('/landing_page/contact_us', name: $scope.name, email: $scope.email, message: $scope.message).save(
      (data) ->
        $scope.name = ''
        $scope.email = ''
        $scope.message = ''
        $scope.message_to_customer = 'Thank you for your message, we will return to you as soon as possible'
    , (err) ->
      alert "something went wrong, and your message couldn't be sent"
    )
]
