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
            return new SimplyBetterApplication.Comments.Collection(this.options.feature.id);
        },

        newCommentsCollectionView: function(){
            return new SimplyBetterApplication.Comments.CollectionView({
                collection: this.comments_collection, 
                navigator: this.options.navigator
            });
        },
          
        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.templateUrl + 'feature_layout.html',
                method: 'GET',
                async: false,
                success: function(response){
                    tmp = response;
                }
            });
            return tmp;
        },

        close: function(){
            this.remove();
        },
        
        className: 'feature-layout',
        render: function(){
            var self = this;
            console.log("rendering");
            this.$el.html(_.template(this.template()));
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
