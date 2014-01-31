SimplyBetterApplication.Comments = (function(comments){
    var module = comments;

    module.New = SimplyBetterApplication.Comments.BaseView.extend({
        initialize: function(){

        },
        template: 'comments/new_comment.html',
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
                    self.collection.add(model);
                },
                error: function(model){
                    errorView = new SimplyBetterApplication.Alerts.ErrorView({message: "You must be signed in to comment"});
                    errorView.render();
                }
            });
        }, 

    });

    return module;
}(SimplyBetterApplication.Comments || {}));
