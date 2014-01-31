SimplyBetterApplication.Navigator = (function(navigator){
    var module = navigator;

    module.NavigatorView = Backbone.View.extend({
        template: 'navigator.html',
        el: '#featureVotingFeaturesModal',
        events: {
            "click .goToFeatures": "navigateFeatures",
            "click .featureVotingCloseButton": "closeModal"
        },

        navigateFeatures: function(e){
            e.preventDefault();
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template());            
            this.trigger('close');
            this.$el.find('.active').removeClass('active');
            $(e.target).addClass('active');
            var col = new SimplyBetterApplication.Features.collection();
            var cv = new SimplyBetterApplication.Features.collectionView({
                collection: col, 
                navigator: this
            });
            this.$el.find('#features').html(cv.render().el);
            var fm = new SimplyBetterApplication.Features.model();
            var nfView = new SimplyBetterApplication.Features.newFeatureView({
                model: fm, 
                navigator: this,
                featuresCollection: col
            });
            this.$el.find('#newFeature').html(nfView.render().el);
  col.fetch();
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

        render: function() {
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template());
            this.navigateToRootPage();
        }

    });

    return module;
}(SimplyBetterApplication.Navigator || {}));
