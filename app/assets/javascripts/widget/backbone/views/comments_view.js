SimplyBetterApplication.Comments = (function (comments) {
  module = comments;

  module.CollectionView = Backbone.View.extend({
    template: function(){
      var tmp = "";
      $.ajax({
          url: SimplyBetterApplication.config.templateUrl + 'comments.html',
          method: 'GET',
          async: false,
          success: function(response){
              tmp = response;
          }
      });
      return tmp;
    }, 
    
    render: function(){
      var self = this;
      this.$el.html(_.template(self.template()));
      var ol = this.$el.find('ol');
      _.each(self.collection.models, function(model){
        var comment = new module.ItemView({model: model, navigator: self.options.navigator});
        ol.append(comment.render().el);
      });
      return this;
    }


  });

  return module;
}(SimplyBetterApplication.Comments || {}));
