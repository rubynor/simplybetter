Idea = ($resource, Session, ngToast) ->
  resource = $resource '/widget_api/ideas/:id.json',
    {
      id: '@id',
      info: Session.info
    },
    {
      patch: { method: 'PATCH' },
      update: { method: 'PUT' }
    }

  ideas = undefined
  lastUpdated = undefined
  MIN_SECONDS_BETWEEN_UPDATE = 30

  removeIdea = (idea) ->
    index = ideas.indexOf(idea)
    ideas.splice(index, 1)

  addIdea = (idea) ->
    ideas.push(idea)

  secondsSinceLastUpdate = ->
    now = new Date()
    (now.getTime() - lastUpdated.getTime()) / 1000

  cacheIdeasFromBackend = ->
    if !ideas
      ideas = resource.query()
    else if !lastUpdated || secondsSinceLastUpdate() > MIN_SECONDS_BETWEEN_UPDATE
      lastUpdated = new Date()
      resource.query (data) ->
        ideas = data

  updateLocalIdea = (oldIdea, newIdea) ->
    for key, value of oldIdea
      if !_.startsWith(key, '_') && !_.startsWith(key, '$')
        oldIdea[key] = newIdea[key]

  dupeIdea = (idea) ->
    new resource(JSON.parse(angular.toJson(idea)))

  updateSuccessNotify = ->
    ngToast.create(content: 'Updated!')

  updateFailedNotify = ->
    ngToast.create(
      content: '<strong>Error: </strong>Could not update idea. Please try again later. Developers have been notified'
      dismissOnTimeout: false,
      className: 'danger'
      dismissButton: true
    )

  all: ->
    # Update ideas in the background, so we don't
    # have to wait for requests when we navigate
    cacheIdeasFromBackend()
    ideas

  get: (id) ->
    return resource.get({id: id}) unless ideas
    id = parseInt(id)
    for idea in ideas
      return idea if idea.id == id

  delete: (idea) ->
    removeIdea(idea)
    idea.$delete {}, ->
      ngToast.create(
        content: 'Idea was deleted'
      )
      return
    , ->
      ngToast.create(
        content: '<strong>Error: </strong>Idea could not be deleted. An error report has been sent to the developers'
        dismissOnTimeout: false,
        className: 'danger'
        dismissButton: true
      )
      addIdea(idea)

  new: (attributes = {}) ->
    new resource(attributes)

  create: (attributes = {}, success, error) ->
    (new resource(attributes)).$save (data) ->
      ideas.push(data)
      success(data) if success
      ngToast.create(
        content: 'Thank you!'
      )
    , (err) ->
      error(err) if error
      ngToast.create(
        content: '<strong>Error: </strong>Could not save idea. Please try again later. Developers have been notified'
        dismissOnTimeout: false,
        className: 'danger'
        dismissButton: true
      )

  update: (idea) ->
    idea.$update ->
      updateSuccessNotify()
    , ->
      updateFailedNotify()

  updateOptimistic: (idea, editedDupe, success) ->
    oldIdea = dupeIdea(idea)
    updateLocalIdea(idea, editedDupe)
    idea.$update ->
      updateSuccessNotify()
      success()
    , ->
      updateFailedNotify()
      updateLocalIdea(idea, oldIdea)

  dupe: (idea) ->
    dupeIdea(idea)


angular
  .module('shared')
  .factory('Idea', ['$resource', 'Session', 'ngToast', Idea])
