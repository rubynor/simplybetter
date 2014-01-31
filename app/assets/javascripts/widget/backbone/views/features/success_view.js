SimplyBetterApplication.Features = (function(features){
    var module = features;

    module.successView = Backbone.View.extend({
        template: 'success.html',
        id: 'success',

        render: function(){
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template({message: this.options.successMessage}));
            return this;
        }

    });

    return features;
}(SimplyBetterApplication.Features || {}));
