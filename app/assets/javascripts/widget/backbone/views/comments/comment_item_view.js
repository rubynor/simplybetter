SimplyBetterApplication.Comments = (function(comments){
    module = comments;

    module.ItemView = SimplyBetterApplication.Comments.BaseView.extend({
        templateName: 'comment_item.html',
        tagName: 'li',
        className: 'comment-item',

        render: function(){
            console.log(this.model.attributes);
            this.$el.html(_.template(this.template(), this.model.attributes));
            return this;
        } 
    });

    return module;
}(SimplyBetterApplication.Comments || {}));
