SimplyBetterIdeas.Models = (function(models){
  var module = models;

  module.Idea = Backbone.Model.extend({
    urlRoot: function(){
      return '/applications/' + SimplyBetterIdeas.Config.appId + '/ideas'
    }
  });
  module.IdeaCollection = Backbone.Collection.extend({
    url: function(){
      return '/applications/' + SimplyBetterIdeas.Config.appId + '/ideas'
    }
  });
  return module;
})(SimplyBetterIdeas.Models || {});
