SimplyBetterApplication.Features = (function(features){
    var module = features;

    module.ItemLayout = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
            this.voteModel = new SimplyBetterApplication.Votes.Model({
                feature_id: this.model.get('id'), 
                voter_email: SimplyBetterApplication.config.userEmail
            });            
            this.featureItem = new SimplyBetterApplication.Features.itemView({model: this.model, navigator: this.options.navigator, voteModel: this.voteModel});
            this.voteModel.fetch();
            this.voteView = new SimplyBetterApplication.Votes.FeatureView({model: this.voteModel});
        },
        template: 'feature_item_layout.html',

        tagName: 'li',

        className: 'feature',

        close: function(){
            this.remove();
        },

        render: function(){
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template());
            var ui = {
                feature: this.$el.find('.feature-item'),
                vote: this.$el.find('.vote')
            }

            ui.feature.html(this.featureItem.render().el); //this.feature_item_view
            ui.vote.html(this.voteView.render().el); //this.vote_view

            return this;
        }
    });

    return module;
}(SimplyBetterApplication.Features || {}));
