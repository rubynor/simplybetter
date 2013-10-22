SimplyBetterApplication.Features = (function(features){
    module = features;

    module.Layout = Backbone.View.extend({
      /*
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
        }
        */
        className: 'feature-layout',
        render: function(){
            self = this;
            var feature_view = new SimplyBetterApplication.Features.showFeature({
                model: this.options.feature, 
                navigator: this.options.navigator
            });
            var comments_collection = new SimplyBetterApplication.Comments.Collection(this.options.feature.id);
            var comments_view = new SimplyBetterApplication.Comments.CollectionView({
                collection: comments_collection, 
                navigator: this.options.navigator
            });
            comments_collection.fetch({
                success: function(){
                    self.$el.append(feature_view.render().el);
                    self.$el.append(comments_view.render().el); 
                }, 
                async: false
            });
            return this;
        }
    });

    return module;
}(SimplyBetterApplication.Features || {})); 
