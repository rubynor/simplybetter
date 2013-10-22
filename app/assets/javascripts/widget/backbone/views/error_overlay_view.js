SimplyBetterApplication.UiFeedback = (function(uiFeedback){
    var module = uiFeedback;

    // Base view
    module.BaseView = Backbone.View.extend({
        className: 'ui-feedback',
        templateName: '',

        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.templateUrl + this.templateName,
                method: 'GET',
                async: false,
                success: function(response){
                    tmp = response;
                }
            });
            return tmp;
        }
    });

    module.ErrorView = module.BaseView.extend({
        className: 'ui-feedback',
        templateName: 'error_overlay.html',

        close: function(){
            this.remove();
        },
        render: function(){
            var self = this;
            $('#featureVotingFeaturesModal').append(this.$el.html(_.template(this.template(), {errorMessage: this.options.errorMessage})));
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