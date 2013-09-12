var SimplyBetterApplication = (function (app){
    return app;
}(SimplyBetterApplication || {}));


SimplyBetterApplication.init = (function (){
    var app = {};
    // Add init actions here
    app.start = function(appKey){
        // Set configurations on start of app
        SimplyBetterApplication.config = (function (key){
            var app = {};
            // Add configurations here
            app.baseUrl = 'http://localhost:3000';
            app.featuresCollectionUrl = function(){
                return '/features?token=' + key;
            };
            app.featuresModelUrl = function(id){
                return '/features/' + id + '?token=' + key;
            };
            return app;
        }(appKey));

        // Create collection, fetch, and render
        var col = new SimplyBetterApplication.Features.collection();
        var cv = new SimplyBetterApplication.Features.collectionView({collection: col});
        col.fetch({
            success: function(){
                cv.render();
            }
        });
        // \Create collection, fetch, and render
    };

    return app;
}());

$(document).ready(function(){
    // Required since ruby uses <%= tags ..
    // Fix for underscore <%= %> to {{= }}
    // TODO: This should only affect our underscore library. But how??
    _.templateSettings = {
        interpolate: /\{\{\=(.+?)\}\}/g,
        evaluate: /\{\{(.+?)\}\}/g
    };
});