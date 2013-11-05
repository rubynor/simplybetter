SimplyBetterApplication.Features = (function(features){
    var app = features;

    app.BaseItemView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
        },

        template: '',
        
        close: function(){
            this.remove();
        },

        truncate: function(string, length){
            var returnValue = string.substring(0,length);
            if (string.length > length){
                returnValue += '...'
            }
            return returnValue;
        },

        render: function(){
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template({feature: this.model.attributes, helpers: this}));
            return this;
        }
    });




    app.itemView = app.BaseItemView.extend({
        template: 'feature_item.html',

        events: {
            "click h1" : "showFeature"
        },

        showFeature: function(){
            //var feature = new SimplyBetterApplication.Features.showFeature({model: this.model, navigator: this.options.navigator, voteStatus: this.voteStatus});
            this.options.navigator.trigger('close');
            var feature_layout = new SimplyBetterApplication.Features.Layout({feature: this.model, navigator: this.options.navigator, voteModel: this.options.voteModel});
            this.options.navigator.$el.find('#featureVotingFeaturesModalContent').html(feature_layout.render().el);
        }
    });

    return app;
}(SimplyBetterApplication.Features || {}));
