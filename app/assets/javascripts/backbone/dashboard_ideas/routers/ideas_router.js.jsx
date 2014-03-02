/** @jsx React.DOM */
SimplyBetterIdeas.Routers = (function(router){
  var module = router;

  module.Ideas = Backbone.Router.extend({
    routes: {
      '': 'all',
      'all': 'all',
      'hidden': 'hidden',
      'visible': 'visible'
    },

    render: function(collection){
      var view = SimplyBetterIdeas.Views.Ideas;
      React.renderComponent((
        <view myCollection={collection} />
      ), document.getElementById('manage-ideas'));
    },

    fetchIdeas: function(filter){
      var that = this;
      var ideas = new SimplyBetterIdeas.Models.IdeaCollection();     
      console.log(ideas);
      ideas.fetch({
        success: function(collection){
          if (filter){
            that.render(filter(collection));
          } else {
            that.render(collection);
          }
        }
      });
    },

    filterWhereCondition: function(condition){
      var filter = function(collection){
        return collection.where(condition);
      };
      this.fetchIdeas(filter);
    },

    all: function(){
      this.fetchIdeas();
    },
    
    visible: function(){
      this.filterWhereCondition({idea_group_id: 1})
    },

    hidden: function(){
      this.filterWhereCondition({idea_group_id: null})
    }

  });


  return module;
})(SimplyBetterIdeas.Routers || {});
