Idea = ($resource, Session) ->
  resource = $resource '/widget_api/ideas/:id.json',
    {
      id: '@id',
      token: Session.token,
      user_email: Session.email
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
      return
    , ->
      addIdea(idea)

  new: (attributes = {}) ->
    new resource(attributes)

  create: (attributes = {}, success, error) ->
    (new resource(attributes)).$save (data) ->
      ideas.push(data)
      success(data) if success
    , (err) ->
      error(err) if error


angular
  .module('shared')
  .factory('Idea', ['$resource', 'Session', Idea])
