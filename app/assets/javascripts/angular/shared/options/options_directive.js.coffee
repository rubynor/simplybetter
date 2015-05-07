# Directive for options
# configurable
# hide/make visible is always included
# If u want edit-icon, add edit='true' and also provide edititem method
# If u want to override isAdmin then send admin='true'
# Example:
# %options(item='idea' admin='true' all='true' togglevisible='toggleVisible(idea)' togglecompleted='toggleCompleted(idea)' edititem='edit(idea)' deleteitem='delete(idea, $index)')
Options = ->
  restrict: 'E'
  scope:
    item: '='             # Required
    visible: '='          # Optional, use if u want visible symbold
    togglevisible: '&'    # Required
    admin: '='            # Optional to override Session.isAdmin()
    all: '='              # Optional, use if u want all symbols. Don't forget to add methods for actions
    edit: '='             # Optional, use if u want edit symbold
    edititem: '&'         # If u want action on edit symbol, then please provide method
    complete: '='         # Optional, use if u want complete/not-complete symbol
    togglecompleted: '&'  # If u want action on complete symbol, then please provide method
    delete: '='           # Optional, use if u want delete symbol
    deleteitem: '&'       # If u want action on delete symbol, then please provide method
  template: JST['angular/shared/options/options']
  controller: ['Session', '$scope', (Session, $scope) ->

    @
  ]
  controllerAs: 'options'

angular.module('shared').directive('options', Options)
