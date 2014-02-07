SimplyBetterApplication.Comments = (function (comments) {
  module = comments;

  module.CollectionView = SimplyBetterApplication.Comments.BaseView.extend({
    initialize: function(){
        this.collection.on('add', this.render, this);
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
      var idea_id = this.collection.idea_id;
      var newComment = new SimplyBetterApplication.Comments.Model(idea_id);
      var newCommentView = new SimplyBetterApplication.Comments.New({model: newComment, collection: this.collection});
      this.$el.find('.new-comment').html(newCommentView.render().el);
    },
    
    render: function(){
      var self = this;
      var commentsCount = this.collection.length;
      var template = SimplyBetterApplication.Template.get(this.template);

      this.$el.html(template({numberOf: commentsCount}));

      var ol = this.$el.find('ol');
      if (commentsCount > 0){
          _.each(self.collection.models, function(model){
            var comment_item = new SimplyBetterApplication.Comments.ItemView({model: model, navigator: self.options.navigator});
            ol.append(comment_item.render().el);
          });
      }
      this.renderNewCommentView();
      return this;
    }


  });

  return module;
}(SimplyBetterApplication.Comments || {}));
