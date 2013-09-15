SimplyBetterApplication.Features = (function(features){
    var module = features;

    module.newFeatureView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
        },
        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.baseUrl + '/assets/backbone/templates/new_feature.html',
                method: 'GET',
                async: false,
                success: function(response){
                    tmp = response;
                }
            });
            return tmp;
        },
        events: {
            "click .submit": "createFeatureRequest"
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
                    var successMessage = "Your feature request has been sent. Thank you :)";
                    var successView = new SimplyBetterApplication.Features.successView({successMessage: successMessage});
                    successView.render();
                }
            });
        },

        close: function(){
            this.remove();
        },

        render: function(){
            this.$el.html(_.template(this.template()));
            return this;
        }

    });

    return module;
}(SimplyBetterApplication.Features || {}));