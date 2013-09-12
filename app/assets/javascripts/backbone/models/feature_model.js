SimplyBetterApplication.Features = (function (features) {
    app = features;
    app.model = Backbone.Model.extend({
        url: function(){
            return SimplyBetterApplication.config.featuresModelUrl(this.id);
        }
    });

    app.collection = Backbone.Collection.extend({
//        initialize: function(options){
//            this.url = options.url;
//        },
        url: function(){
            return SimplyBetterApplication.config.featuresCollectionUrl();
        },
        model: app.model
    });
    return app;
}(SimplyBetterApplication.Features || {}));
