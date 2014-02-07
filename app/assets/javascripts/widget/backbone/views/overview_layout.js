SimplyBetterApplication.Ideas = (function(ideas){
    var module = ideas;
    
    module.OverviewLayout = Backbone.View.extend({
        initialize: function(){
            this.topView = this.options.newIdeaView;
            this.bottomView = this.options.ideasView;
            this.listenTo(this.options.navigator, 'close', this.close);
            this.listenTo(
              this.options.navigator, 
              'ideaClosed', 
              this.renderBottomView
            );
        },
        
        template: 'ideas/overview.html',
        className: 'overview',

        close: function(){
            this.remove();
        },

        ui: {
            top: '#newIdea',
            bottom: '#ideas'
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
}(SimplyBetterApplication.Ideas || {}));
