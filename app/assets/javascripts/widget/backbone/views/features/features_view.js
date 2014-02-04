SimplyBetterApplication.Features = (function(features){
    app = features;

    app.collectionView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
            this.collection.on('add', this.render, this);
        },

        className: 'overview-layout',
        tagName: 'ol',

        close: function(){
            this.remove();
        },

        render: function (){
            var self = this;
            this.$el.empty();
            //Render item views
            var ol = this.$el;
            _.each(self.collection.models, function(model){
                var feature = new app.ItemLayout({
                  model: model, 
                  navigator: self.options.navigator
                });
                ol.append(feature.render().el);
            });

            return this;
        }
    });

    return app;
}(SimplyBetterApplication.Features || {}));
