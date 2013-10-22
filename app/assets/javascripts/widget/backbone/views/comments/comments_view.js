SimplyBetterApplication.Comments = (function (comments) {
  module = comments;

  module.CollectionView = SimplyBetterApplication.Comments.BaseView.extend({
    initialize: function(){
        var feature_id = this.collection.feature_id;
        this.comment = new SimplyBetterApplication.Comments.Model(feature_id);
        this.comment.on('change', this.fetchAndRender, this);
    },
    className: 'comments-section',
    templateName: 'comments.html',
    
    fetchAndRender: function(){
        var self = this;
        this.collection.fetch({
          success: function(){
            self.render();
          }
        });
    },
    
    render: function(){
      var self = this;
      var newComment = new SimplyBetterApplication.Comments.New({model: this.comment});

      this.$el.html(_.template(self.template(), {numberOf: this.collection.models.length}));
      this.$el.find('.new-comment').html(newComment.render().el);
      var ol = this.$el.find('ol');
      _.each(self.collection.models, function(model){
        var comment_item = new SimplyBetterApplication.Comments.ItemView({model: model, navigator: self.options.navigator});
        ol.append(comment_item.render().el);
      });
      return this;
    }


  });

  return module;
}(SimplyBetterApplication.Comments || {}));
