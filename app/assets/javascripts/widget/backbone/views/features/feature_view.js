SimplyBetterApplication.Features = (function(features){
    var module = features;
    module.showFeature = SimplyBetterApplication.Features.BaseItemView.extend ({
        initialize: function(){
            this.model.on('change',this.render,this);
            this.voteView = new SimplyBetterApplication.Votes.FeatureView({model: this.options.voteModel});
        },
        template: 'feature.html',
        className: 'featureView',

        render: function(){
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template({feature: this.model.attributes}));
            this.$el.find('#vote').html(this.voteView.render().el);
            //this.renderComments();  // We're not gonna use this
            return this;
        }
    });

    return module;
}(SimplyBetterApplication.Features || {}));
