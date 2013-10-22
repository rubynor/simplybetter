SimplyBetterApplication.Comments = (function(comments){
    var module = comments;

    module.New = SimplyBetterApplication.Comments.BaseView.extend({
        initialize: function(){
            console.log(this.model);
        },
        templateName: 'new_comment.html',
        tagName: 'form',
        events: {
            "click .submit-comment": "submitComment" 
        },

        setWaitingmode: function(e){
            $(e.target).attr('value','Please wait...').unbind();
        },

        submitComment: function(e){
            e.preventDefault();
            var self = this;
            this.setWaitingmode(e);
            var commentInput = this.$el.find('.comment-body');
            this.model.save({
                body: commentInput.val(),
                user: {
                    email: SimplyBetterApplication.config.userEmail
                }
            },{
                success: function(model){
                    console.log("Re-render comments");  
                },
                error: function(model){
                    errorView = new SimplyBetterApplication.UiFeedback.ErrorView({errorMessage: "An error occured"});
                    errorView.render();
                }
            });
        }, 

    });

    return module;
}(SimplyBetterApplication.Comments || {}));
