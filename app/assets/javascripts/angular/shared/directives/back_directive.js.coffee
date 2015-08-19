Back = ->
  restrict: 'E'
  template: '<a ui-sref="overview" class="back"><div class="icon back-arrow"></div>BACK</a>'

angular.module('shared').directive('back', Back)
