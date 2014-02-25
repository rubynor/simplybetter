SimplyBetterApplication.Ideas = (function(ideas){
    var module = ideas;

    module.newIdeaView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
            this.model = new SimplyBetterApplication.Ideas.model();
        },
        template: 'new_idea.html',
        className: 'newIdea',
        events: {
            "focus .title": "showCompleteForm",
            "click .submit": "createIdeaRequest",
            "keyup .title": "findSimilarIdeas",
            "focus textarea.description": "hideSimilarIdeas"
        },

        showCompleteForm: function(e){
            var form = $('.new-idea-form');
            form.addClass('focused');
        },
        createIdeaRequest: function(){
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
                    self.options.navigator.showIdea(model);
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
                    '/ideas/find_similar?query='+
                    queryString, function(response){
                    addToList(response);
                });

                function addToList(response){
                    var ol = $('.similar-ideas ol');
                    if (response.length > 0){
                        ol.parent().removeClass('fade-hidden');
                        $('input#title-input').addClass('show-similar-ideas');
                        ol.empty();
                        return $.each(response,function(){
                            var model = self.options.ideasCollection.get(this["id"]);
                            var itemView = new module.ItemLayout({
                                model: model, 
                                navigator: self.options.navigator
                            });
                            itemView.ideaItem.options.container = '#ideas';
                            $(ol).append(itemView.render().el);
                        }); 
                    }
                };
            }
        },

        hideSimilarIdeas: function(){
            $('input#title-input').removeClass('show-similar-ideas');
            $('.similar-ideas').addClass('fade-hidden');
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
}(SimplyBetterApplication.Ideas || {}));
