var SimplyBetterApplication = (function (app){
    return app;
}(SimplyBetterApplication || {}));

SimplyBetterApplication.config = (function (){
    var app = {};
    // Add configurations here
    app.baseUrl = 'http://localhost:3000'
    return app;
}());

SimplyBetterApplication.init = (function (){
    var app = {};
    // Add init actions here
    app.show = function(){
        var col = new SimplyBetterApplication.Features.collection();
        var cv = new SimplyBetterApplication.Features.collectionView({collection: col});
        col.fetch({
            success: function(){
                cv.render();
            }
        });
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