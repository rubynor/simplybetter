SimplyBetterApplication.Features = (function (features) {
    app = features;

    app.model = Backbone.Model.extend({
        url: function(){
            return '/features/' + this.id + '?token=JZTIJBHV';
        }
    });

    app.collection = Backbone.Collection.extend({
        model: app.model,
        url: '/features?token=' + 'JZTIJBHV'
    });
    return app;
}(SimplyBetterApplication.Features || {}));
