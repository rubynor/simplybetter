SimplyBetterApplication.Features = (function(features){
    var module = features;

    module.VoteStatusModel = Backbone.Model.extend({
        initialize: function(options){
            this.url = SimplyBetterApplication.config.featuresVoteStatusUrl(options);
        }
    });

    return module;
}(SimplyBetterApplication.Features || {}));