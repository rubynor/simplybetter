SimplyBetterApplication.Application = (function (application) {
    var module = application;

    module.Model = Backbone.Model.extend({
        url: function(){
            return SimplyBetterApplication.config.applicationModelUrl();
        }
    });

    return module;
}(SimplyBetterApplication.Application || {}));
