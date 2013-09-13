SimplyBetterApplication.Features = (function (features) {
    app = features;
    app.model = Backbone.Model.extend({
        url: function(){
            if (this.isNew()){
                return SimplyBetterApplication.config.featuresNewModelUrl(this.id);
            } else {
                return SimplyBetterApplication.config.featuresModelUrl(this.id);
            }
        }
    });

    app.collection = Backbone.Collection.extend({
        url: function(){
            return SimplyBetterApplication.config.featuresCollectionUrl();
        },
        model: app.model
    });
    return app;
}(SimplyBetterApplication.Features || {}));
