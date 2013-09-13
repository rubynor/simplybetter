var SimplyBetterApplication = (function (app){
    return app;
}(SimplyBetterApplication || {}));


SimplyBetterApplication.init = (function (){
    var app = {};
    // Add init actions here
    app.start = function(appKey, email, name){
        // Set configurations on start of app
        SimplyBetterApplication.config = (function (key){
            var app = {};
            // Add configurations here
            app.appKey = key;
            app.userEmail = email;
            app.userName = name;
            app.baseUrl = 'http://localhost:3000';

            // URLs
            app.featuresCollectionUrl = function(){
                return '/features?token=' + key;
            };
            app.featuresModelUrl = function(id){
                return '/features/' + id + '?token=' + key;
            };
            app.featuresNewModelUrl = function(){
                return '/features?token=' + key;
            };
            return app;
        }(appKey));

        // Create main view
        var n = new SimplyBetterApplication.Navigator.NavigatorView();
        n.render();

    };

    return app;
}());

$(document).ready(function(){
    // Required since ruby uses <%= tags ..
    // Fix for underscore <%= %> to {{= }}
    // TODO: This should only affect OUR underscore library. But how??
    _.templateSettings = {
        interpolate: /\{\{\=(.+?)\}\}/g,
        evaluate: /\{\{(.+?)\}\}/g
    };
});