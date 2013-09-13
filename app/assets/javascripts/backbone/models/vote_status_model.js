SimplyBetterApplication.Features = (function(features){
    var module = features;

    module.VoteStatusModel = Backbone.Model.extend({
        initialize: function(options){
            this.url = '/features/'+ options.feature_id + '/vote_status?email=' + options.email;
        }
    });

    return module;
}(SimplyBetterApplication.Features || {}));