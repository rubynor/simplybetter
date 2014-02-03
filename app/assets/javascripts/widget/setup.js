var SimplyBetterApplication = (function (app){
    return app;
}(SimplyBetterApplication || {}));


SimplyBetterApplication.init = (function (){
    var app = {};
    // Add init actions here


    // Required since ruby uses <%= tags ..
    // Fix for underscore <%= %> to {{= }}
    _.templateSettings = {
        interpolate: /\{\{\=(.+?)\}\}/g,
        evaluate: /\{\{(.+?)\}\}/g
    };

    app.start = function(appKey, email, name, baseUrl){
        console.log("Starting app!");
        // Set configurations on start of app
        SimplyBetterApplication.config = (function (key, baseUrl){
            var app = {};
            // Add configurations here
            app.appKey = key;
            app.userEmail = email;
            app.userName = name;
            app.baseUrl = baseUrl;
            app.templateUrl = baseUrl + '/assets/widget/backbone/templates/'

            // URLs
            app.featuresCollectionUrl = function(){
                return app.baseUrl + '/widget_api/features.json?token=' + key;
            };
            app.featuresModelUrl = function(id){
                return app.baseUrl + '/widget_api/features/' + id + '.json?token=' + key;
            };
            app.featuresNewModelUrl = function(){
                return app.featuresCollectionUrl();
            };
            app.votesUrl = function(options){
                return app.baseUrl + '/widget_api/votes/cast.json?voter_email=' + options.voter_email + '&feature_id=' + options.feature_id + '&token=' + key;
            };
            app.featuresCastVoteRoot = function(){
                return app.baseUrl + '/widget_api/votes/';
            };
            app.commentsCollectionUrl = function(fid){
                return app.baseUrl + '/widget_api/features/' + fid + '/comments.json?token=' + key;
            };
            app.commentsNewModelUrl = function(fid){
                return app.commentsCollectionUrl(fid);
            };
            app.commentsModelUrl = function(fid, id){
                return app.commentsModelCollectionUrl(fid) + '/' + id;
            };            

            app.applicationModelUrl = function(){
                return app.baseUrl + '/widget_api/applications/' + app.appKey;
            };
            

            return app;
        }(appKey, baseUrl));

        // Create main view
        var n = new SimplyBetterApplication.Navigator.NavigatorView();
        n.render();

    };

    return app;
}());

