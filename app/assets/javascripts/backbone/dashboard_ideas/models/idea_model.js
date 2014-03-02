SimplyBetterIdeas.Models = (function(models){
  var module = models;

  module.Comment = Backbone.Model.extend({
    
  });

  module.CommentCollection = Backbone.Collection.extend({
    constructor: function(models,options){
      this.idea = options.idea;
      Backbone.Collection.apply(this, arguments);
    },
    model: module.Comment
  });

  module.Idea = Backbone.Model.extend({
    urlRoot: function(){
      return '/applications/' + SimplyBetterIdeas.Config.appId + '/ideas'
    },
    parse: function(data){
      var that = this;
      if (data.comments.length > 0){
        this.commentCollection = new module.CommentCollection(data.comments,{idea: that});
      }
     delete data['comments'];
     return data;
    }

  });
  module.IdeaCollection = Backbone.Collection.extend({
    url: function(){
      return '/applications/' + SimplyBetterIdeas.Config.appId + '/ideas'
    },
    model: module.Idea
  });

  return module;
})(SimplyBetterIdeas.Models || {});
