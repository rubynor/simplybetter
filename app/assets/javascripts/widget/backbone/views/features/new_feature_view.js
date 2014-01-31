SimplyBetterApplication.Features = (function(features){
    var module = features;

    module.newFeatureView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
        },
        template: 'new_feature.html',

        events: {
            "focus .title": "showCompleteForm",
            "click .submit": "createFeatureRequest",
            "keyup .title": "findSimilarIdeas"
        },

        showCompleteForm: function(e){
            $('.new-feature-form').addClass('focused');
        },
        createFeatureRequest: function(){
            var self = this;
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
                    self.options.navigator.$el.find('#featureVotingFeaturesModalContent').empty().append(successView.render().el);
                }
            });
        },

        
        findSimilarIdeas: function(e){
            var queryString = $(e.target).val();
            var self = this;
            
            $.get('/widget_api/applications/'+SimplyBetterApplication.config.appKey+'/features/find_similar?query='+queryString, function(response){
                addToList(response);
            });

            function addToList(response){
                var ol = $('.similar-ideas ol');
                ol.empty();
                if (response.length > 0){
                    $(ol).parent().show();
                    return $.each(response,function(){
                        var model = self.options.featuresCollection.get(this["id"]);
                        var itemView = new module.ItemLayout({model: model, navigator: self.options.navigator});
                        itemView.featureItem.options.container = '#features';
                        $(ol).append(itemView.render().el);
                    }); 
                } else {
                    $(ol).parent().hide();
                }
            };
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
