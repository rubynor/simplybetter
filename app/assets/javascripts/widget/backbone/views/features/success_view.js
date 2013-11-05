SimplyBetterApplication.Features = (function(features){
    var module = features;

    module.successView = Backbone.View.extend({
        template: 'success.html',
        el: '#featureVotingFeaturesModalContent',

        render: function(){
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template({message: this.options.successMessage}));
        }

    });

    return features;
}(SimplyBetterApplication.Features || {}));
