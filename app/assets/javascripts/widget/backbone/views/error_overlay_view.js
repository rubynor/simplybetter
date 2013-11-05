SimplyBetterApplication.UiFeedback = (function(uiFeedback){
    var module = uiFeedback;

    // Base view
    module.BaseView = Backbone.View.extend({
        className: 'ui-feedback',

    });

    module.ErrorView = module.BaseView.extend({
        template: 'error_overlay.html',

        close: function(){
            this.remove();
        },
        render: function(){
            var self = this;
            var template = SimplyBetterApplication.Template.get(this.template);
            $('#featureVotingFeaturesModal').append(this.$el.html(template({errorMessage: this.options.errorMessage})));
            $('.error-overlay').animate({
                opacity: '0.6'
            }, 500, 'ease-out');
            setTimeout(function(){
                $('.error-overlay').animate({
                    opacity: '0'
                }, 500, 'ease-out')
            }, 2000);
            setTimeout(function(){
                self.close();
            }, 2500);
        }
    });

    return module;
}(SimplyBetterApplication.UiFeedback || {}));
