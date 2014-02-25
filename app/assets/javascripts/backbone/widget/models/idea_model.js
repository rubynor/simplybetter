SimplyBetterApplication.Ideas = (function (ideas) {
    var app = ideas;
    app.model = Backbone.Model.extend({
        url: function(){
            if (this.isNew()){
                return SimplyBetterApplication.config.ideasNewModelUrl(this.id);
            } else {
                return SimplyBetterApplication.config.ideasModelUrl(this.id);
            }
        }
    });

    app.collection = Backbone.Collection.extend({
        url: function(){
            return SimplyBetterApplication.config.ideasCollectionUrl();
        },
        model: app.model
    });
    return app;
}(SimplyBetterApplication.Ideas || {}));
