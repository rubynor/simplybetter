var SimplyBetterApplication = (function (app){
    return app;
}(SimplyBetterApplication || {}));


SimplyBetterApplication.init = (function (){
    var app = {};
    // Add init actions here
    app.start = function(appKey, email, name, baseUrl){
        $('body').append('<div id="fatureVotingBackdropLayer" style="display:none"></div><div id="featureVotingFeaturesModal" style="display:none"></div>');
        $('body').append('<button class="simplyBetterBtn">Press me</button>');
        $('.simplyBetterBtn').on('click', function(){
            $('#featureVotingFeaturesModal').show();
            $('#featureVotingBackdropLayer').show();
        });
        // Set configurations on start of app
        SimplyBetterApplication.config = (function (key, baseUrl){
            var app = {};
            // Add configurations here
            app.appKey = key;
            app.userEmail = email;
            app.userName = name;
            app.baseUrl = baseUrl;

            // URLs
            app.featuresCollectionUrl = function(){
                return app.baseUrl + '/features?token=' + key;
            };
            app.featuresModelUrl = function(id){
                return '/features/' + id + '?token=' + key;
            };
            app.featuresNewModelUrl = function(){
                return '/features?token=' + key;
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
    // TODO: This should only affect OUR underscore library. But how??
    _.templateSettings = {
        interpolate: /\{\{\=(.+?)\}\}/g,
        evaluate: /\{\{(.+?)\}\}/g
    };
});