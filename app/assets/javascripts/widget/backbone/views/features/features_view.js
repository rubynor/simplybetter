SimplyBetterApplication.Features = (function(features){
    app = features;

    app.collectionView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
            this.collection.on('add', this.render, this);
        },
        template: 'features/overview.html',

        className: 'overview-layout',
      //ol.feature-container

        close: function(){
            this.remove();
        },

        newFeatureView: function(){
            var fm = new SimplyBetterApplication.Features.model();
            var nfView = new SimplyBetterApplication.Features.newFeatureView({
                model: fm, 
                navigator: this.options.navigator,
                featuresCollection: this.collection
            });
            return nfView.render().el
        },

        render: function (){
            var self = this;
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template());
            this.$el.find('#newFeature').html(this.newFeatureView());

            //Render item views
            var ol = this.$el.find('ol.feature-container');
            _.each(self.collection.models, function(model){
                var feature = new app.ItemLayout({model: model, navigator: self.options.navigator});
                ol.append(feature.render().el);
            });

            return this;
        }
    });

    return app;
}(SimplyBetterApplication.Features || {}));
