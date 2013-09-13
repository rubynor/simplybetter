SimplyBetterApplication.Features = (function(features){
    var module = features;

    module.successView = Backbone.View.extend({
        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.baseUrl + '/assets/backbone/templates/success.html',
                method: 'GET',
                async: false,
                success: function(response){
                    tmp = response;
                }
            });
            return tmp;
        },
        el: '#featureVotingFeaturesModalContent',

        render: function(){
            this.$el.html(_.template(this.template(), {message: this.options.successMessage}));
        }

    });

    return features;
}(SimplyBetterApplication.Features || {}));