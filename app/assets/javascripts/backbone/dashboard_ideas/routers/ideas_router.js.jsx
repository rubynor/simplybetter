/** @jsx React.DOM */
SimplyBetterIdeas.Routers = (function(router){
  var module = router;

  module.Ideas = Backbone.Router.extend({
    initialize: function(){
      var navigation = SimplyBetterIdeas.Views.Navbar;
      var collection = new SimplyBetterIdeas.Models.IdeaCollection();
      collection.fetch();
      React.renderComponent((
        <navigation router={this} collection={collection} />
      ), document.getElementById('manage-ideas'));
    },

    routes: {
      '': 'all',
      'all': 'all',
      'hidden': 'hidden',
      'visible': 'visible'
    },

    all: function(){
      this.current = "all";
    },
    
    visible: function(){
      this.current = "visible";
    },

    hidden: function(){
      this.current = "hidden";
    }

  });


  return module;
})(SimplyBetterIdeas.Routers || {});
