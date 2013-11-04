SimplyBetterApplication.Votes = (function(votes){
    var module = votes;

    module.Model = Backbone.Model.extend({
        initialize: function(options){
            this.url = SimplyBetterApplication.config.votesUrl(options);
        }
    });

    return module;
}(SimplyBetterApplication.Votes || {}));
