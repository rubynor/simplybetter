SimplyBetterApplication.Comments = (function(comments){
    module = comments;

    module.ItemView = SimplyBetterApplication.Comments.BaseView.extend({
        template: 'comments/comment_item.html',
        tagName: 'li',
        className: 'comment-item',

    });

    return module;
}(SimplyBetterApplication.Comments || {}));
