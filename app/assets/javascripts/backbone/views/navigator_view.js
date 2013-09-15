SimplyBetterApplication.Navigator = (function(navigator){
    var module = navigator;

    module.NavigatorView = Backbone.View.extend({
        initialize: function(){
            this.on('refresh', this.render);
        },
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
            console.log(cv);
            col.fetch({
                success: function(){
                    cv.render();
                }
            });
            console.log(self.features);
        },
        navigateNewFeature: function(){
            this.trigger('close');
            var fm = new SimplyBetterApplication.Features.model();
            var nfView = new SimplyBetterApplication.Features.newFeatureView({model: fm, navigator: this});
            nfView.render();
        },

        render: function() {
            this.$el.html(_.template(this.template()));
            console.log("navigator rendered!");
        }

    });

    return module;
}(SimplyBetterApplication.Navigator || {}));