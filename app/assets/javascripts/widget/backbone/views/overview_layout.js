SimplyBetterApplication.Features = (function(features){
    var module = features;
    
    module.OverviewLayout = Backbone.View.extend({
        initialize: function(){
            this.topView = this.options.newFeatureView;
            this.bottomView = this.options.featuresView;
            this.listenTo(this.options.navigator, 'close', this.close);
            this.listenTo(
              this.options.navigator, 
              'featureClosed', 
              this.renderBottomView
            );
        },
        
        template: 'features/overview.html',
        className: 'overview',

        close: function(){
            this.remove();
        },

        ui: {
            top: '#newFeature',
            bottom: '#features'
        },

        renderBottomView: function(){
            this.$el.find(this.ui.bottom).html(this.bottomView.render().el);
        },

        render: function(){
            var self = this;
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template());
            this.$el.find(this.ui.top).append(this.topView.render().el);
            this.renderBottomView();
            return this;
        }

    });

    return module;
}(SimplyBetterApplication.Features || {}));
