widget.controller 'NotificationCtrl', ['$scope', 'Notification', ($scope, Notification) ->
  # $scope.notififications = Notification.query({ token: $scope.token, user_email: $scope.email })
  # Mocking up data... resource gives me nothing.
  $scope.notifications = [{ checked: true, image_url: 'kj', message: 'Hello', creator: 'Arne', idea: { title: '"arne"'}, time: '2 minutes ago' }, { checked: false, image_url: 'kj', message: 'Weee', creator: 'Hans', idea: { title: '"arne"'}, time: '1 minutes ago' }]
  $scope.tmp = 'arne'
  console.log 'in notifications ctrl'
]
