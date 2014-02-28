var SimplyBetterIdeas = (function (app){
    return app;
}(SimplyBetterIdeas || {}));


SimplyBetterIdeas.Init = (function (){
    var app = {};
    // Add init actions here


    // Required since ruby uses <%= tags ..
    // Fix for underscore <%= %> to {{= }}
    _.templateSettings = {
        interpolate: /\{\{\=(.+?)\}\}/g,
        evaluate: /\{\{(.+?)\}\}/g
    };

    app.start = function(applicationId){
      SimplyBetterIdeas.Config = (function(appId){
        var module = {};
        module.appId = appId;
        return  module;
      }(applicationId));

      new SimplyBetterIdeas.Routers.Ideas();
      Backbone.history.start();
    };

    return app;
}());
