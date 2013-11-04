var SimplyBetterApplication = (function (app){
    return app;
}(SimplyBetterApplication || {}));


SimplyBetterApplication.init = (function (){
    var app = {};
    // Add init actions here


    app.start = function(appKey, email, name, baseUrl){
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
            

            // Spinner settings
            app.opts = {
                lines: 11, // The number of lines to draw
                length: 10, // The length of each line
                width: 5, // The line thickness
                radius: 20, // The radius of the inner circle
                corners: 1, // Corner roundness (0..1)
                rotate: 34, // The rotation offset
                direction: 1, // 1: clockwise, -1: counterclockwise
                color: '#555', // #rgb or #rrggbb or array of colors
                speed: 2, // Rounds per second
                trail: 54, // Afterglow percentage
                shadow: false, // Whether to render a shadow
                hwaccel: false, // Whether to use hardware acceleration
                className: 'spinner', // The CSS class to assign to the spinner
                zIndex: 2e9, // The z-index (defaults to 2000000000)
                top: 'auto', // Top position relative to parent in px
                left: 'auto' // Left position relative to parent in px
            };


            return app;
        }(appKey, baseUrl));

        // Create main view
        var n = new SimplyBetterApplication.Navigator.NavigatorView();
        n.render();

    };

    return app;
}());

$(document).ready(function(){
    // Required since ruby uses <%= tags ..
    // Fix for underscore <%= %> to {{= }}
    _.templateSettings = {
        interpolate: /\{\{\=(.+?)\}\}/g,
        evaluate: /\{\{(.+?)\}\}/g
    };
});
