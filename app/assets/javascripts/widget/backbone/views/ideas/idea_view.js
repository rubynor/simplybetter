SimplyBetterApplication.Ideas = (function(ideas){
    var module = ideas;
    module.showIdea = SimplyBetterApplication.Ideas.BaseItemView.extend ({
        initialize: function(){
            this.model.on('change',this.render,this);
            this.voteView = new SimplyBetterApplication.Votes.IdeaView({model: this.options.voteModel});
        },
        template: 'idea.html',
        className: 'ideaView',

        render: function(){
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template({idea: this.model.attributes}));
            this.$el.find('#vote').html(this.voteView.render().el);
            //this.renderComments();  // We're not gonna use this
            return this;
        }
    });

    return module;
}(SimplyBetterApplication.Ideas || {}));
