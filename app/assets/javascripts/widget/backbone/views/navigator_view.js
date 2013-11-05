SimplyBetterApplication.Navigator = (function(navigator){
    var module = navigator;

    module.NavigatorView = Backbone.View.extend({
        template: 'navigator.html',
        el: '#featureVotingFeaturesModal',
        events: {
            "click .goToFeatures": "navigateFeatures",
            "click .goToNewFeature": "navigateNewFeature",
            "click .featureVotingCloseButton": "closeModal"
        },

        showSpinner: function(){
            var target = document.getElementById('featureVotingFeaturesModalContent');
            var spinner = new Spinner(SimplyBetterApplication.config.opts).spin(target);
        },

        navigateFeatures: function(e){
            e.preventDefault();
            this.showSpinner();
            this.trigger('close');
            this.$el.find('.active').removeClass('active');
            $(e.target).addClass('active');
            var col = new SimplyBetterApplication.Features.collection();
            var cv = new SimplyBetterApplication.Features.collectionView({collection: col, navigator: this});
            self = this;
            self.$el.find('#featureVotingFeaturesModalContent').html(cv.render().el);
            col.fetch();
        },
        navigateNewFeature: function(e){
            e.preventDefault();
            this.showSpinner();
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
