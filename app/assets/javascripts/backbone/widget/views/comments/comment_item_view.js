SimplyBetterApplication.Comments = (function(comments){
    module = comments;

    module.ItemView = SimplyBetterApplication.Comments.BaseView.extend({
        template: 'comments/comment_item.html',
        tagName: 'li',
        className: 'comment-item',
        id: function(){
          return this.model.get('id') + '-comment';
        },

        highlight: function(){
          var that = this;
          var type = this.options.highlight;
          window.location.hash = '';
          if (type && type['comment']){
            if (this.model.get('id') === parseInt(type['comment'])){
              setTimeout(function(){
                that.$el.addClass('highlighted');
                window.location.hash = that.id();
              },500);
              setTimeout(function(){
                that.$el.removeClass('highlighted');
              },3000);
            }
          }
        },

        afterRender: function(){
          this.highlight();
        }
    });

    return module;
}(SimplyBetterApplication.Comments || {}));
