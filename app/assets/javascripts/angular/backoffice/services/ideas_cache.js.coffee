IdeasCache = (Idea) ->
  @ideas = []

  getIdeas = (appId) =>
    if @ideas.length == 0
      @ideas = Idea.query(application_id: appId)
    else
      @ideas

  get: (appId) =>
    getIdeas(appId)

  remove: (idea) =>
    if @ideas.length == 0
      throw "Can't remove idea. No ideas in cache."

    index = @ideas.indexOf(idea)
    @ideas.splice(index, 1)

angular
  .module('Backoffice')
  .factory('IdeasCache', ['Idea', IdeasCache])
