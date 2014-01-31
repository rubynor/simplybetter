SimplyBetterApplication.Navigator = (function(navigator){
    var module = navigator;

    module.NavigatorView = Backbone.View.extend({
        initialize: function(){
            this.features = new SimplyBetterApplication.Features.collection();
            this.overview = new SimplyBetterApplication.Features.collectionView({
                collection: this.features, 
                navigator: this
            });
            this.listenTo(this,'close',this.deActivateLink);
        },
        template: 'navigator.html',
        el: '#featureVotingFeaturesModal',
        events: {
            "click .goToFeatures": "navigateFeatures",
            "click .featureVotingCloseButton": "closeModal"
        },

        navigateFeatures: function(e){
            e.preventDefault();
            this.trigger('close');
            $(e.target).addClass('active');
            this.$el
                .find('#featureVotingFeaturesModalContent')
                .html(this.overview.render().el);
            this.features.fetch();
        },

        showFeature: function(featureModel,voteModel,container){
            if (!voteModel) {
                var voteModel = new SimplyBetterApplication.Votes.Model({
                    feature_id: featureModel.get('id'), 
                    voter_email: SimplyBetterApplication.config.userEmail
                });
                voteModel.fetch();
            }
            var feature_layout = new SimplyBetterApplication.Features.Layout({
                feature: featureModel, 
                navigator: this, 
                voteModel: voteModel
            });

            if (container){
                this.$el
                    .find(container)
                    .html(feature_layout.render().el);
            } else {
                this.trigger('close');
                this.$el
                    .find('#featureVotingFeaturesModalContent')
                    .html(feature_layout.render().el);
            }
        },

        alertSuccess: function(message){
            var successView = new SimplyBetterApplication.Alerts.SuccessView({
                message: message
            });
            successView.render();
        },

        closeModal: function(){
            this.$el.hide();
            this.$el.prev().hide();
        },

        navigateToRootPage: function(){
            root_link = $('.goToFeatures');
            if (!root_link.hasClass('active')) {
                root_link.click();
            }
            return false;
        },

        deActivateLink: function(){
            this.$el.find('.active').removeClass('active');
        },

        render: function() {
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template());
            this.navigateToRootPage();
        }

    });

    return module;
}(SimplyBetterApplication.Navigator || {}));
