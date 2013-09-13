SimplyBetterApplication.Features = (function(features){
    var app = features;
    app.show = Backbone.View.extend({
        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.baseUrl + '/assets/backbone/templates/feature.html',
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
            this.$el.html(_.template(this.template(), this.model.attributes));
        }
    });
    return app;
}(SimplyBetterApplication.Features || {}));