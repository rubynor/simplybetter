SimplyBetterApplication.Comments = (function(comments){
    var module = comments;
    
    module.BaseView = Backbone.View.extend({
        //
        // When creating a new comment view, remember to set the templateName!
        templateName: "",

        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.templateUrl + 'comments/' + this.templateName,
                method: 'GET',
                async: false,
                success: function(response){
                    tmp = response;
                }
            });
            return tmp;
        },

        render: function(){
            this.$el.html(_.template(this.template(), this.model.attributes));
            return this;
        }
    });

    return module;
}(SimplyBetterApplication.Comments || {}));
