widget.controller 'NotificationCtrl', ['$scope', 'Notification', ($scope, Notification) ->
  # $scope.notififications = Notification.query({ token: $scope.token, user_email: $scope.email })
  # Mocking up data... resource gives me nothing.
  $scope.notifications = [{ checked: true, image_url: 'https://secure.gravatar.com/avatar/b642b4217b34b1e8d3bd915fc65c4452.png?r=PG&s=50', message: 'Hello', creator: 'Arne', idea: { title: '"arne"'}, time: '2 minutes ago' }, { checked: false, image_url: 'https://secure.gravatar.com/avatar/b642b4217b34b1e8d3bd915fc65c4452.png?r=PG&s=50', message: 'Weee', creator: 'Hans', idea: { title: '"arne"'}, time: '1 minutes ago' }]
  $scope.tmp = 'arne'
  console.log 'in notifications ctrl'
]
