SimplyBetterApplication.Navigator = (function(navigator){
    var module = navigator;

    module.NavigatorView = Backbone.View.extend({
        initialize: function(){
            this.ideas = new SimplyBetterApplication.Ideas.collection();
            this.ideasView = new SimplyBetterApplication.Ideas.collectionView({
                collection: this.ideas, 
                navigator: this
            });
            this.application = new SimplyBetterApplication.Application.Model();
            this.listenTo(this,'close',this.deActivateLink);
        },
        template: 'navigator.html',
        el: '#simplybetterIdeasModal',
        events: {
            "click .goToIdeas": "navigateOverview",
            "click .home": "navigateToRootPage"
        },

        navigateOverview: function(e){
            e.preventDefault();
            this.trigger('close');
            $(e.target).addClass('active');
            var newIdeaView = new SimplyBetterApplication.Ideas.newIdeaView({
                navigator: this,
                ideasCollection: this.ideas
            });
            var overviewLayout = new SimplyBetterApplication.Ideas.OverviewLayout({
                newIdeaView: newIdeaView,
                ideasView: this.ideasView,
                navigator: this
            })
            this.$el
                .find('#simplybetterIdeasModalContent')
                .html(overviewLayout.render().el);
            this.ideas.fetch();
        },

        showIdea: function(ideaModel,voteModel,container){
            if (!voteModel) {
                var voteModel = new SimplyBetterApplication.Votes.Model({
                    idea_id: ideaModel.get('id'), 
                    voter_email: SimplyBetterApplication.config.userEmail
                });
                voteModel.fetch();
            }
            var idea_layout = new SimplyBetterApplication.Ideas.Layout({
                idea: ideaModel, 
                navigator: this, 
                voteModel: voteModel
            });

            if (container){
                this.$el
                    .find(container)
                    .html(idea_layout.render().el);
            } else {
                this.trigger('close');
                this.$el
                    .find('#simplybetterIdeasModalContent')
                    .html(idea_layout.render().el);
            }
            return idea_layout;
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
            root_link = $('.goToIdeas');
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
