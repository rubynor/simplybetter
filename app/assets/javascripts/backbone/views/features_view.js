SimplyBetterApplication.Features = (function(features){
    app = features;

    app.collectionView = Backbone.View.extend({
        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.baseUrl + '/assets/backbone/templates/index.html',
                method: 'GET',
                async: false,
                success: function(response){
                    tmp = response;
                }
            });
            return tmp;
        },
        el: '#featureVotingFeaturesModalContent',

        render: function (){
            var self = this;
            this.$el.html(_.template(self.template()));

            //Render item views
            var ol = this.$el.find('ol');
            _.each(self.collection.models, function(model){
                var feature = new app.itemView({model: model});
                ol.append(feature.render().el);
            });
        }
    });

    return app;
}(SimplyBetterApplication.Features || {}));