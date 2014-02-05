SimplyBetterApplication.Navigator = (function(navigator){
    var module = navigator;

    module.NavigatorView = Backbone.View.extend({
        initialize: function(){
            this.features = new SimplyBetterApplication.Features.collection();
            this.featuresView = new SimplyBetterApplication.Features.collectionView({
                collection: this.features, 
                navigator: this
            });
            this.application = new SimplyBetterApplication.Application.Model();
            this.listenTo(this,'close',this.deActivateLink);
        },
        template: 'navigator.html',
        el: '#simplybetterFeaturesModal',
        events: {
            "click .goToFeatures": "navigateOverview",
            "click .home": "navigateToRootPage"
        },

        navigateOverview: function(e){
            e.preventDefault();
            this.trigger('close');
            $(e.target).addClass('active');
            var newFeatureView = new SimplyBetterApplication.Features.newFeatureView({
                navigator: this,
                featuresCollection: this.features
            });
            var overviewLayout = new SimplyBetterApplication.Features.OverviewLayout({
                newFeatureView: newFeatureView,
                featuresView: this.featuresView,
                navigator: this
            })
            this.$el
                .find('#simplybetterFeaturesModalContent')
                .html(overviewLayout.render().el);
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
                    .find('#simplybetterFeaturesModalContent')
                    .html(feature_layout.render().el);
            }
            return feature_layout;
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
            var self = this;
            var template = SimplyBetterApplication.Template.get(this.template);
            this.application.fetch({
                success: function(model){
                    console.log(model);
                    self.$el.html(template({
                      applicationName: model.get('name'),
                      applicationIntro: model.get('intro')
                    }));
                    self.navigateToRootPage();
                }
            });
        }

    });

    return module;
}(SimplyBetterApplication.Navigator || {}));
