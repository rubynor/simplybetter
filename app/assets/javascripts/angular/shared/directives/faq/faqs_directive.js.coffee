Faqs = ->
  restrict: 'E'
  template: JST['angular/shared/directives/faq/faqs_template']

angular
  .module('shared')
  .directive('faqs', Faqs)

