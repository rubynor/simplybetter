SimplyBetterApplication.Ideas = (function(ideas){
    var module = ideas;

    module.ItemLayout = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
            this.voteModel = new SimplyBetterApplication.Votes.Model({
                idea_id: this.model.get('id'), 
                voter_email: SimplyBetterApplication.config.userEmail,
                value: this.model.get('voter_status'),
                votes_count: this.model.get('votes_count')
            });            
            this.ideaItem = new SimplyBetterApplication.Ideas.itemView({
                model: this.model, 
                navigator: this.options.navigator, 
                voteModel: this.voteModel
            });
            this.voteView = new SimplyBetterApplication.Votes.IdeaView({
                model: this.voteModel
            });
        },
        template: 'idea_item_layout.html',

        tagName: 'li',

        className: 'idea',

        close: function(){
            this.remove();
        },

        render: function(){
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template());
            var ui = {
                idea: this.$el.find('.idea-item'),
                vote: this.$el.find('.vote')
            }

            ui.idea.html(this.ideaItem.render().el); //this.idea_item_view
            ui.vote.html(this.voteView.render().el); //this.vote_view

            return this;
        }
    });

    return module;
}(SimplyBetterApplication.Ideas || {}));
