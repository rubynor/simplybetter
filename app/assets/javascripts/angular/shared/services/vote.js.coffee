Vote = ($resource, Session) ->
  $resource '/widget_api/votes/cast.json', { info: Session.info }

angular
  .module('shared')
  .factory('Vote', ['$resource', 'Session', Vote])

