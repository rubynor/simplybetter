SimplyBetterApplication.Alerts = (function(alerts){
    var module = alerts;

    // Base view
    module.BaseView = Backbone.View.extend({
        close: function(){
            this.remove();
        },

        className: 'alert',

        render: function(){
            var self = this;
            var template = SimplyBetterApplication.Template.get(this.template);
            $('#simplybetterIdeasModal').append(this.$el.html(template({message: this.options.message})));

            var overlay = $('.'+this.classPrefix+'-overlay');
            overlay.animate({
                opacity: '1'
            }, 500, 'ease-out');
            setTimeout(function(){
                overlay.animate({
                    opacity: '0'
                }, 500, 'ease-out')
            }, 2000);
            setTimeout(function(){
                self.close();
            }, 2500);
        }
    });

    module.ErrorView = module.BaseView.extend({
        template: 'alerts/error_overlay.html',
        classPrefix: 'error'
    });

    module.SuccessView = module.BaseView.extend({
        template: 'alerts/success_overlay.html',
        classPrefix: 'success'
    });

    return module;
}(SimplyBetterApplication.Alerts || {}));
