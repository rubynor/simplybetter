SimplyBetterApplication.Navigator = (function(navigator){
    var module = navigator;

    module.NavigatorView = Backbone.View.extend({
        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.baseUrl + '/assets/backbone/templates/navigator.html',
                method: 'GET',
                async: false,
                success: function(response){
                    tmp = response;
                }
            });
            return tmp;
        },
        el: '#featureVotingFeaturesModal',
        events: {
            "click .goToFeatures": "navigateFeatures",
            "click .goToNewFeature": "navigateNewFeature"
        },

        navigateFeatures: function(){
            this.trigger('close');
            var col = new SimplyBetterApplication.Features.collection();
            var cv = new SimplyBetterApplication.Features.collectionView({collection: col, navigator: this});
            self = this;
            col.fetch({
                success: function(){
                    self.$el.find('#featureVotingFeaturesModalContent').html(cv.render().el);
                }
            });
        },
        navigateNewFeature: function(){
            this.trigger('close');
            var fm = new SimplyBetterApplication.Features.model();
            var nfView = new SimplyBetterApplication.Features.newFeatureView({model: fm, navigator: this});
            this.$el.find('#featureVotingFeaturesModalContent').html(nfView.render().el);
        },

        render: function() {
            this.$el.html(_.template(this.template()));
        }

    });

    return module;
}(SimplyBetterApplication.Navigator || {}));