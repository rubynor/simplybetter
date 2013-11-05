SimplyBetterApplication.Features = (function(features){
    module = features;

    module.Layout = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
            this.feature_view = this.newFeatureView();
            this.comments_collection = this.newCommentsCollection();
            this.comments_collection_view = this.newCommentsCollectionView();
        },

        newFeatureView: function(){
            return new SimplyBetterApplication.Features.showFeature({
                model: this.options.feature, 
                navigator: this.options.navigator,
                voteModel: this.options.voteModel
            });
        },
        newCommentsCollection: function(){
            commentsCollection = new SimplyBetterApplication.Comments.Collection();
            commentsCollection.url = SimplyBetterApplication.config.commentsCollectionUrl(this.options.feature.id)
            return commentsCollection;
        },

        newCommentsCollectionView: function(){
            return new SimplyBetterApplication.Comments.CollectionView({
                collection: this.comments_collection, 
                navigator: this.options.navigator
            });
        },
          
        template: 'feature_layout.html',

        close: function(){
            this.remove();
        },
        
        className: 'feature-layout',
        render: function(){
            var self = this;
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template());
            var ui = {
                feature: this.$el.find('#feature'),
                comments: this.$el.find('#comments')
            };

            ui.feature.html(this.feature_view.render().el);
            this.comments_collection.fetch();
            ui.comments.html(self.comments_collection_view.render().el); 
            return this;
        }
    });

    return module;
}(SimplyBetterApplication.Features || {})); 
