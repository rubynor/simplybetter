SimplyBetterApplication.Features = (function(features){
    var module = features;
    module.showFeature = SimplyBetterApplication.Features.BaseItemView.extend ({
        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.templateUrl + 'feature.html',
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
        renderComments: function(){
            var self = this;
            var comments_collection = new SimplyBetterApplication.Comments.Collection(this.model.get('id'));
            var commentsContainer = this.$el.find('.comments-container');
            var comments_view = new SimplyBetterApplication.Comments.CollectionView({
                collection: comments_collection, 
                navigator: this.options.navigator
            });
            comments_collection.fetch({
                success: function(){
                    commentsContainer.html(comments_view.render().el); 
                }, 
                async: false
            });
        },
        render: function(){
             console.log(this.voteStatus);
             console.log(this.voteStatusClass(this.voteStatus));
             this.$el.html(_.template(this.template(),{feature: this.model.attributes, voteClass: this.voteStatusClass(this.voteStatus)}));
             this.renderComments();
             return this;
        }
    });

    return module;
}(SimplyBetterApplication.Features || {}));
