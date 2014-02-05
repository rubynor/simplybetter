SimplyBetterApplication.Features = (function(features){
    var module = features;

    module.newFeatureView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
            this.model = new SimplyBetterApplication.Features.model();
        },
        template: 'new_feature.html',
        className: 'newFeature',
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
                    var successMessage = "Thank's for helping us to simply be better!";
                    self.options.navigator.showFeature(model);
                    self.options.navigator.alertSuccess(successMessage);
                }
            });
        },

        
        findSimilarIdeas: function(e){
            var queryString = $(e.target).val();
            var self = this;
            
            if (queryString.length > 10){
                $.get('/widget_api/applications/'+
                    SimplyBetterApplication.config.appKey+
                    '/features/find_similar?query='+
                    queryString, function(response){
                    addToList(response);
                });

                function addToList(response){
                    var ol = $('.similar-ideas ol');
                    if (response.length > 0){
                        ol.parent().show();
                        ol.empty();
                        return $.each(response,function(){
                            var model = self.options.featuresCollection.get(this["id"]);
                            var itemView = new module.ItemLayout({
                                model: model, 
                                navigator: self.options.navigator
                            });
                            itemView.featureItem.options.container = '#features';
                            $(ol).append(itemView.render().el);
                        }); 
                    }
                };
            }
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
