SimplyBetterApplication.Comments = (function(comments){
    var module = comments;
    
    module.BaseView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
        },
        //
        // When creating a new comment view, remember to set the templateName!
        template: 'comments/',
        close: function(){
            this.remove();
        },

        afterRender: function(){
          this.highlight();
        },

        render: function(){
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template(this.model.attributes));
            this.afterRender();
            return this;
        }
    });

    return module;
}(SimplyBetterApplication.Comments || {}));
