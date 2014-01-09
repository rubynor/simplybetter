SimplyBetterApplication.Features = (function(features){
    var module = features;

    module.newFeatureView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
        },
        template: 'new_feature.html',
        events: {
            "focus .title": "showCompleteForm",
            "click .submit": "createFeatureRequest"
        },

        showCompleteForm: function(e){
            $('.new-feature-form').addClass('focused');
        },
        createFeatureRequest: function(){
            this.model.save({
                title: this.$el.find('.title').val(),// form elements
                description: this.$el.find('.description').val(),
                token: SimplyBetterApplication.config.appKey,
                user: {
                    email: SimplyBetterApplication.config.userEmail,
                    name: SimplyBetterApplication.config.userName
                }
            },{
                success: function(model){
                    var successMessage = "We really appreciate your help :-)";
                    var successView = new SimplyBetterApplication.Features.successView({successMessage: successMessage});
                    successView.render();
                }
            });
        },

        close: function(){
            this.remove();
        },

        render: function(){
            if (SimplyBetterApplication.Utils.userSignedIn()){
                var template = SimplyBetterApplication.Template.get(this.template);
                this.$el.html(template());
                return this;
            }
            return false;
        }

    });

    return module;
}(SimplyBetterApplication.Features || {}));
