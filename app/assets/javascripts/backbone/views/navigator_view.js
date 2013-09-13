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
            var col = new SimplyBetterApplication.Features.collection();
            var cv = new SimplyBetterApplication.Features.collectionView({collection: col});
            col.fetch({
                success: function(){
                    cv.render();
                }
            });
        },
        navigateNewFeature: function(){
            console.log('I am not implemented yet');
        },

        render: function() {
            this.$el.html(_.template(self.template()))
        }

    });

    return module;
}(SimplyBetterApplication.Navigator || {}));