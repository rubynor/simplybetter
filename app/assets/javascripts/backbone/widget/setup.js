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
            app.templateUrl = baseUrl + '/assets/backbone/widget/templates/'

            // URLs
            app.ideasCollectionUrl = function(){
                return app.baseUrl + '/widget_api/ideas.json?token=' + key + '&user_email=' + app.userEmail;
            };
            app.ideasModelUrl = function(id){
                return app.baseUrl + '/widget_api/ideas/' + id + '.json?token=' + key + '&user_email=' + app.userEmail;
            };
            app.ideasNewModelUrl = function(){
                return app.ideasCollectionUrl();
            };
            app.votesUrl = function(options){
                return app.baseUrl + '/widget_api/votes/cast.json?voter_email=' + options.voter_email + '&idea_id=' + options.idea_id + '&token=' + key;
            };
            app.ideasCastVoteRoot = function(){
                return app.baseUrl + '/widget_api/votes/';
            };
            app.commentsCollectionUrl = function(fid){
                return app.baseUrl + '/widget_api/ideas/' + fid + '/comments.json?token=' + key;
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

