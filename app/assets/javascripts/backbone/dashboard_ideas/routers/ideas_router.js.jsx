/** @jsx React.DOM */
SimplyBetterIdeas.Routers = (function(router){
  var module = router;

  module.Ideas = Backbone.Router.extend({
    routes: {
      '': 'all'
    },

    all: function(){
      var ideas = new SimplyBetterIdeas.Models.IdeaCollection();     
      var view = SimplyBetterIdeas.Views.Ideas;
      ideas.fetch({
        success: function(collection){
          React.renderComponent((
            <view myCollection={collection} />
          ), document.getElementById('manage-ideas'));

        }
      });
    }
  });

  return module;
})(SimplyBetterIdeas.Routers || {});
