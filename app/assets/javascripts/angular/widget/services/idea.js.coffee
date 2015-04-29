widget.factory 'Idea', ['$resource', 'Session', ($resource, Session) ->
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

  @ideas = undefined

  removeIdea = (idea) ->
    index = @ideas.indexOf(idea)
    @ideas.splice(index, 1)

  addIdea = (idea) ->
    @ideas.push(idea)

  @all = =>
    if @ideas
      @ideas
    else
      @ideas = resource.query()

  @get = (id) =>
    for idea in @ideas
      return idea if idea.id == id

  @delete = (idea) =>
    removeIdea(idea)
    idea.$delete {}, ->
      return
    , ->
      addIdea(idea)

  @new = (attributes = {}) ->
    new resource(attributes)

  @create = (attributes = {}, success, error) =>
    @new(attributes).$save (data) ->
      @ideas.push(@new(data))
      success(data) if success
    , (err) ->
      error(err) if error

  return
]
