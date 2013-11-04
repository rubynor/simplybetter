SimplyBetterApplication.Comments = (function (comments) {
  module = comments;

  module.CollectionView = SimplyBetterApplication.Comments.BaseView.extend({
    initialize: function(){
        //this.collection.on('add', this.render, this);
        this.collection.on('sync', this.render, this);
    },
    className: 'comments-section',
    template: 'comments/comments.html',
    
    fetchAndRender: function(){
        var self = this;
        this.collection.fetch({
          success: function(){
            self.render();
          }
        });
    },

    renderNewCommentView: function(){
      var feature_id = this.collection.feature_id;
      var newComment = new SimplyBetterApplication.Comments.Model(feature_id);
      var newCommentView = new SimplyBetterApplication.Comments.New({model: newComment, collection: this.collection});
      this.$el.find('.new-comment').html(newCommentView.render().el);
    },
    
    render: function(){
      var self = this;
      var commentsCount = this.collection.models.length - 1;
      var template = SimplyBetterApplication.Template.get(this.template);

      this.$el.html(template({numberOf: commentsCount}));

      this.renderNewCommentView();
      var ol = this.$el.find('ol');
      if (commentsCount > 1){
          _.each(self.collection.models, function(model){
            var comment_item = new SimplyBetterApplication.Comments.ItemView({model: model, navigator: self.options.navigator});
            ol.append(comment_item.render().el);
          });
      }
      return this;
    }


  });

  return module;
}(SimplyBetterApplication.Comments || {}));
