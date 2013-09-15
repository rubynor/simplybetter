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
            "click .goToNewFeature": "navigateNewFeature",
            "click .featureVotingCloseButton": "closeModal"
        },

        navigateFeatures: function(e){
            this.trigger('close');
            this.$el.find('.active').removeClass('active');
            $(e.target).addClass('active');
            var col = new SimplyBetterApplication.Features.collection();
            var cv = new SimplyBetterApplication.Features.collectionView({collection: col, navigator: this});
            self = this;
            col.fetch({
                success: function(){
                    self.$el.find('#featureVotingFeaturesModalContent').html(cv.render().el);
                }
            });
        },
        navigateNewFeature: function(e){
            this.trigger('close');
            this.$el.find('.active').removeClass('active');
            $(e.target).addClass('active');
            var fm = new SimplyBetterApplication.Features.model();
            var nfView = new SimplyBetterApplication.Features.newFeatureView({model: fm, navigator: this});
            this.$el.find('#featureVotingFeaturesModalContent').html(nfView.render().el);
        },
        closeModal: function(){
            this.$el.hide();
            this.$el.prev().hide();
        },

        render: function() {
            this.$el.html(_.template(this.template()));
        }

    });

    return module;
}(SimplyBetterApplication.Navigator || {}));