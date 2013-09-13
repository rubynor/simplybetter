SimplyBetterApplication.Features = (function(features){
    var module = features;

    module.newFeatureView = Backbone.View.extend({
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
        el: '#featureVotingFeaturesModalContent',
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
                    //Append dialog box with success msg
                    console.log("SUCCESS!");
                }
            });
        },
        render: function(){
            this.$el.html(_.template(this.template()))
        }

    });

    return module;
}(SimplyBetterApplication.Features || {}));