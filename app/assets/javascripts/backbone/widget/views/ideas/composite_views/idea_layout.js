SimplyBetterApplication.Ideas = (function(ideas){
    module = ideas;

    module.Layout = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
            this.idea_view = this.newIdeaView();
            this.comments_collection = this.newCommentsCollection();
            this.comments_collection_view = this.newCommentsCollectionView();
        },

        events: {
            "click .close-view-button" : "close"
        },

        newIdeaView: function(){
            return new SimplyBetterApplication.Ideas.showIdea({
                model: this.options.idea, 
                navigator: this.options.navigator,
                voteModel: this.options.voteModel
            });
        },
        newCommentsCollection: function(){
            var idea_id = this.options.idea.id;
            commentsCollection = new SimplyBetterApplication.Comments.Collection();
            commentsCollection.url = SimplyBetterApplication.config.commentsCollectionUrl(idea_id)
            commentsCollection.idea_id = idea_id;
            return commentsCollection;
        },

        newCommentsCollectionView: function(){
            return new SimplyBetterApplication.Comments.CollectionView({
                collection: this.comments_collection, 
                navigator: this.options.navigator,
                highlight: this.options.highlight
            });
        },
          
        template: 'idea_layout.html',

        close: function(){
            this.options.navigator.trigger('ideaClosed');
            this.remove();
        },

        highlight: function(){
          var that = this;
          var hlight = this.options.highlight;
          if (hlight && hlight['idea']){
            setTimeout(function(){
              that.$el.addClass('highlighted');
            },500);
            setTimeout(function(){
              that.$el.removeClass('highlighted');
            },3000);
          }
        },
        
        className: 'idea-layout',
        render: function(){
            var self = this;
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template());
            var ui = {
                idea: this.$el.find('#idea'),
                comments: this.$el.find('#comments')
            };
            ui.idea.html(this.idea_view.render().el);
            this.comments_collection.fetch();
            ui.comments.html(self.comments_collection_view.render().el); 
            this.highlight();
            return this;
        }
    });

    return module;
}(SimplyBetterApplication.Ideas || {})); 
