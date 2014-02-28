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
            <div>
              <view myCollection={collection} />
            </div>
          ), document.getElementById('manage-ideas'));

        }
      });
      console.log(ideas);
      var swag = new SimplyBetterIdeas.Models.Idea({title: 'Yolo to go'});
      console.log(swag);
      setTimeout(function(){
        ideas.add(swag);
      },5000);
    }
  });

  return module;
})(SimplyBetterIdeas.Routers || {});
