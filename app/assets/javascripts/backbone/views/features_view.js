SimplyBetterApplication.Features = (function(features){
    app = features;

    app.collectionView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
        },
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
        close: function(){
            this.remove();
            this.options.navigator.trigger('refresh');
        },
        render: function (){
            var self = this;
            this.$el.html(_.template(self.template()));
            //Render item views
            var ol = this.$el.find('ol');
            _.each(self.collection.models, function(model){
                var feature = new app.itemView({model: model, navigator: self.options.navigator});
                ol.append(feature.render().el);
            });
        }
    });

    return app;
}(SimplyBetterApplication.Features || {}));