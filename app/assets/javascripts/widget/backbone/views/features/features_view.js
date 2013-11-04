SimplyBetterApplication.Features = (function(features){
    app = features;

    app.collectionView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
            this.collection.on('sync', this.render, this);
        },

        tagName: 'ol',
        className: 'feature-container',

        close: function(){
            this.remove();
        },

        render: function (){
            var self = this;
            //Render item views
            var ol = this.$el;
            _.each(self.collection.models, function(model){
                var feature = new app.ItemLayout({model: model, navigator: self.options.navigator});
                ol.append(feature.render().el);
            });
            return this;
        }
    });

    return app;
}(SimplyBetterApplication.Features || {}));
